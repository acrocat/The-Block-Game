local Grid = require("modules.grid")
local Sound = require("modules.sound")
local inspect = require("modules.inspect")

-- Shapes
local Block = require("modules.shapes.block")
local LeftCorner = require("modules.shapes.leftCorner")
local RightCorner = require("modules.shapes.rightCorner")
local Line = require("modules.shapes.line")
local Dot = require("modules.shapes.dot")
local BlockHole = require("modules.shapes.blockHole")
local xBlock = require("modules.shapes.xBlock")
local emptyXBlock = require("modules.shapes.emptyXBlock")
local horizontalLine = require("modules.shapes.horizontalLine")
local shortVerticalLine = require("modules.shapes.shortVerticalLine")
local verticalSplit = require("modules.shapes.verticalSplit")
local plus = require("modules.shapes.plus")
local plusGap = require("modules.shapes.plusGap")

local availableShapes = {
	Block,
	LeftCorner,
	RightCorner,
	Line,
	Dot,
	BlockHole,
	xBlock,
	emptyXBlock,
	horizontalLine,
	shortVerticalLine,
	verticalSplit,
	plus,
	plusGap
}

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local screenWidth = display.contentWidth
local screenHeight = display.contentHeight

local deck = {}

deck.maxNumberOfPieces = 3
deck.pieceOrigins = {
	{
		x = centerX - (screenWidth / 3.5),
		y = screenHeight - 75
	},
	{
		x = centerX,
		y = screenHeight - 75
	},
	{
		x = centerX + (screenWidth / 3.5),
		y = screenHeight - 75
	}
}
deck.displayGroup = display.newGroup()
deck.pieces = {}

deck.populate = function (self) 
	if #self.pieces ~= 0 then return end

	-- Play swipe sound
	Sound:swipe()

	for i = 1 , self.maxNumberOfPieces do
		-- Create a block
		local blockPiece = availableShapes[math.random(#availableShapes)]:create()
		
		blockPiece.tag = i
		blockPiece:addEventListener("touch" , shapePan)

		blockPiece.xScale = 0.75
		blockPiece.yScale = 0.75

		-- Set origin position off screen
		local origin = self:getOriginForPiece(i , blockPiece)
		blockPiece.y = origin.y
		blockPiece.x = screenWidth

		-- Animate to the piece deck origin points
		transition.to(blockPiece , {
			time = 300,
			x = origin.x
		})
		-- Add piece to the deck
		table.insert(self.pieces , blockPiece)

		self.displayGroup:insert(blockPiece)
	end
end

deck.removePiece = function (self , tag)
	-- Remove the piece from the deck
	for i = #self.pieces , 1 , -1 do
		local piece = self.pieces[i]
		if piece.tag == tag then 
			table.remove(self.pieces , i)
			piece:removeSelf() 
		end
	end
end

deck.checkForSpacesInGrid = function (self)
	local validLocations = 0

	for i = 1 , #self.pieces do
		validLocations = validLocations + Grid:scanForAvailableSpace(self.pieces[i].myName)
	end

	return (validLocations > 0)
end

deck.getOriginForPiece  =  function (self , tag , piece)
	local origin = self.pieceOrigins[tag]

	return {
		y = origin.y - (piece.height / 2 * 0.75),
		x = origin.x - (piece.width / 2 * 0.75)
	}
end

deck.clear = function (self)
	for i = 1 , self.maxNumberOfPieces do
		self:removePiece(i)
	end
end

return deck
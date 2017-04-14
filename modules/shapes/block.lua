local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local inspect = require("modules.inspect")
local color = require("modules.color")

local block = {}

block.name = "block"
block.color = {color.hex("#4286f4")}

block.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
			row = start.row
		},
		{
			col = start.col + 1,
			row = start.row
		},
		{
			col = start.col,
			row = start.row + 1
		},
		{
			col = start.col + 1,
			row = start.row + 1
		}
	}
end

block.create = function ()
	local blockGroup = display.newGroup()

	local left = 0
	local top = 0
	local right = (2 * Grid.squareSize) + Grid.padding
	local bottom = right

	local topLeft = display.newRoundedRect(blockGroup , left + (Grid.squareSize / 2) , top + (Grid.squareSize / 2) , Grid.squareSize , Grid.squareSize , 5)
	local topRight = display.newRoundedRect(blockGroup , right - (Grid.squareSize / 2) , top + (Grid.squareSize / 2) , Grid.squareSize , Grid.squareSize , 5)
	local bottomLeft = display.newRoundedRect(blockGroup , left + (Grid.squareSize / 2) , bottom - (Grid.squareSize / 2) , Grid.squareSize , Grid.squareSize , 5)
	local bottomRight = display.newRoundedRect(blockGroup , right - (Grid.squareSize / 2) , bottom - (Grid.squareSize / 2) , Grid.squareSize , Grid.squareSize , 5)

	topLeft.fill = block.color
	topRight.fill = block.color
	bottomLeft.fill = block.color
	bottomRight.fill = block.color

	Shape:addBackground(blockGroup)
	blockGroup.myName = block
	return blockGroup
end

block.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(block , start)
end

block.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(block , start)
end

block.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(block , start)
end

return block
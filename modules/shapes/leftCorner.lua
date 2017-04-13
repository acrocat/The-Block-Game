local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")

local leftCorner = {}

leftCorner.name = "leftCorner"
leftCorner.color = {1,0,1}

leftCorner.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
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

leftCorner.create = function () 
	local blockGroup = display.newGroup()

	local topLeft = display.newRoundedRect(blockGroup , (Grid.squareSize / 2) , (Grid.squareSize / 2) , Grid.squareSize , Grid.squareSize , 5)
	local bototmLeft = display.newRoundedRect(blockGroup , topLeft.x , topLeft.y + Grid.squareSize + Grid.padding , Grid.squareSize , Grid.squareSize , 5)
	local bottomRight = display.newRoundedRect(blockGroup , bototmLeft.x + Grid.squareSize + Grid.padding , bototmLeft.y , bototmLeft.width , bototmLeft.height , 5)

	topLeft.fill = leftCorner.color
	bototmLeft.fill = leftCorner.color
	bottomRight.fill = leftCorner.color

	Shape:addBackground(blockGroup)
	blockGroup.myName = leftCorner
	return blockGroup
end

leftCorner.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(leftCorner , start)
end

leftCorner.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(leftCorner , start)
end

leftCorner.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(leftCorner , start)
end

return leftCorner
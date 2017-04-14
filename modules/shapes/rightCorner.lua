local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local rightCorner = {}
rightCorner.name = "rightCorner"
rightCorner.color = {color.hex("#e88f5f")}

rightCorner.getCoordinates = function (self , start)
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
			col = start.col + 1,
			row = start.row + 1
		}
	}
end

rightCorner.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	local topLeft = display.newRoundedRect(group , half , half , size , size , 5)
	local topRight = display.newRoundedRect(group , topLeft.x + padding + size , topLeft.y , size , size , 5)
	local bottomRight = display.newRoundedRect(group , topRight.x , topRight.y + padding + size , size , size , 5)

	topLeft.fill = rightCorner.color
	topRight.fill = rightCorner.color
	bottomRight.fill = rightCorner.color

	Shape:addBackground(group)
	group.myName = rightCorner
	return group
end

rightCorner.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(rightCorner , start)
end

rightCorner.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(rightCorner , start)
end

rightCorner.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(rightCorner , start)
end


return rightCorner
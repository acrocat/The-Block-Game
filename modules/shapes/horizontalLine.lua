local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")

local horizontalLine = {}
horizontalLine.name = "horizontalLine"
horizontalLine.color = {0.5 , 1 , 0.5}

horizontalLine.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
			row = start.row
		},
		{
			col = start.col + 1,
			row = start.row
		}
	}
end

horizontalLine.create = function () 
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 1 do
		local left = half + (i * (size + padding))
		local top = half

		local square = display.newRoundedRect(group , left , top , size , size , 5)
		square.fill = horizontalLine.color
	end

	Shape:addBackground(group)
	group.myName = horizontalLine
	return group
end

horizontalLine.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(horizontalLine , start)
end

horizontalLine.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(horizontalLine , start)
end

horizontalLine.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(horizontalLine , start)
end

return horizontalLine
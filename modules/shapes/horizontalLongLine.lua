local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local horizontalLongLine = {}
horizontalLongLine.name = "horizontalLongLine"
horizontalLongLine.color = {color.hex("#9e430b")}

horizontalLongLine.getCoordinates = function (self , start)
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
			col = start.col + 2,
			row = start.row
		},
		{
			col = start.col + 3,
			row = start.row
		}
	}
end

horizontalLongLine.create = function () 
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 3 do
		local left = half + (i * (size + padding))
		local top = half

		local square = display.newRoundedRect(group , left , top , size , size , 5)
		square.fill = horizontalLongLine.color
	end

	Shape:addBackground(group)
	group.myName = horizontalLongLine
	return group
end

horizontalLongLine.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(horizontalLongLine , start)
end

horizontalLongLine.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(horizontalLongLine , start)
end

horizontalLongLine.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(horizontalLongLine , start)
end

return horizontalLongLine
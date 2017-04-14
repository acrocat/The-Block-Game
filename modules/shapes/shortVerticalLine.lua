local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local shortVerticalLine = {}
shortVerticalLine.name = "shortVerticalLine"
shortVerticalLine.color = {color.hex("#e85e83")}

shortVerticalLine.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
			row = start.row
		},
		{
			col = start.col,
			row = start.row + 1
		}
	}
end

shortVerticalLine.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 1 do
		local top = half + (i * (size + padding))
		local left = half

		local square = display.newRoundedRect(group , left , top , size , size , 5)
		square.fill = shortVerticalLine.color
	end

	Shape:addBackground(group)
	group.myName = shortVerticalLine
	return group
end

shortVerticalLine.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(shortVerticalLine , start)
end

shortVerticalLine.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(shortVerticalLine , start)
end

shortVerticalLine.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(shortVerticalLine , start)
end

return shortVerticalLine
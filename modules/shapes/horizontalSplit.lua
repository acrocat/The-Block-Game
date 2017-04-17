local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local horizontalSplit = {}
horizontalSplit.name = "horizontalSplit"
horizontalSplit.color = {color.hex("#17b262")}

horizontalSplit.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
			row = start.row
		},
		{
			col = start.col + 2,
			row = start.row
		}
	}
end

horizontalSplit.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 2 , 2 do
		local top = half
		local left = half + (i * (size + padding))

		local square = display.newRoundedRect(group , left , top , size , size , 5)
		square.fill = horizontalSplit.color
	end

	Shape:addBackground(group)
	group.myName = horizontalSplit
	return group
end

horizontalSplit.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(horizontalSplit , start)
end

horizontalSplit.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(horizontalSplit , start)
end

horizontalSplit.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(horizontalSplit , start)
end

return horizontalSplit
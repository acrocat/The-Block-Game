local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")

local verticalSplit = {}
verticalSplit.name = "verticalSplit"
verticalSplit.color = {0.8 , 0.4 , 0.4}

verticalSplit.getCoordinates = function (self , start)
	return {
		{
			col = start.col,
			row = start.row
		},
		{
			col = start.col,
			row = start.row + 2
		}
	}
end

verticalSplit.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 2 , 2 do
		local left = half
		local top = half + (i * (size + padding))

		local square = display.newRoundedRect(group , left , top , size , size , 5)
		square.fill = verticalSplit.color
	end

	Shape:addBackground(group)
	group.myName = verticalSplit
	return group
end

verticalSplit.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(verticalSplit , start)
end

verticalSplit.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(verticalSplit , start)
end

verticalSplit.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(verticalSplit , start)
end

return verticalSplit
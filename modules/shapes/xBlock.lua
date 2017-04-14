local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local xBlock = {}
xBlock.name = "xBlock"
xBlock.color = {color.hex("#6bd3d0")}

xBlock.getCoordinates = function (self , start)
	local c = {}

	for x = 1 , 3 do
		for y = 1 , 3 do
			if (x == 2 and y == 2) or (x % 2 ~= 0 and y % 2 ~= 0) then
				table.insert(c , {
					col = start.col + x - 1,
					row = start.row + y - 1	
				})
			end
		end
	end

	return c
end

xBlock.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for x = 1 , 3 do
		for y = 1 , 3 do
			if (x == 2 and y == 2) or (x % 2 ~= 0 and y % 2 ~= 0) then
				local top = half + ((y - 1) * (size + padding))
				local left = half + ((x - 1) * (size + padding))

				local square = display.newRoundedRect(group , left , top  , size , size , 5)
				square.fill = xBlock.color
			end
		end
	end

	Shape:addBackground(group)
	group.myName = xBlock
	return group
end

xBlock.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(xBlock , start)
end

xBlock.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(xBlock , start)
end

xBlock.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(xBlock , start)
end

return xBlock
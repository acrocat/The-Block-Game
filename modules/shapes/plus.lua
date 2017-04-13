local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")

local plus = {}
plus.name = "plus"
plus.color = {0.8,0.8,0.6}

plus.getCoordinates = function (self, start)
	local c = {}

	for x = 1 , 3 do
		for y = 1 , 3 do
			if y == 2 or x == 2 then
				table.insert(c , {
					col = start.col + x - 1,
					row = start.row + y - 1
				})
			end
		end
	end

	return c
end

plus.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for x = 1 , 3 do
		for y = 1 , 3 do
			if y == 2 or x == 2 then
				local top = half + ((y-1) * (size + padding))
				local left = half + ((x-1) * (size + padding))

				local square = display.newRoundedRect(group , left , top , size , size , 5)
				square.fill = plus.color
			end
		end
	end

	Shape:addBackground(group)
	group.myName = plus
	return group
end

plus.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(plus , start)
end

plus.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(plus , start)
end

plus.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(plus , start)
end

return plus
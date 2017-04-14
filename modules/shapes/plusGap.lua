local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local plusGap = {}
plusGap.name = "plusGap"
plusGap.color = {color.hex("#5c7a2e")}

plusGap.getCoordinates = function (self, start)
	local c = {}

	for x = 1 , 3 do
		for y = 1 , 3 do 
			if (x == 2 or y == 2) and not(x==2 and y==2) then
				table.insert(c , {
					col = start.col + x - 1,
					row = start.row + y - 1	
				})
			end
		end
	end

	return c
end

plusGap.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for x = 1 , 3 do
		for y = 1 , 3 do 
			if (x == 2 or y == 2) and not(x==2 and y==2) then
				local top = half + ((y-1) * (size + padding))
				local left = half + ((x-1) * (size + padding))

				local square = display.newRoundedRect(group , left , top , size , size , 5)
				square.fill = plusGap.color
			end
		end
	end

	Shape:addBackground(group)
	group.myName = plusGap
	return group
end

plusGap.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(plusGap , start)
end

plusGap.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(plusGap , start)
end

plusGap.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(plusGap , start)
end

return plusGap
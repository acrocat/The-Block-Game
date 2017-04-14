local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local emptyXBlock = {}
emptyXBlock.name = "emptyXBlock"
emptyXBlock.color = {color.hex("#1c5777")}

emptyXBlock.getCoordinates = function (self , start)
	local c = {}

	for x = 1 , 3 do
		for y = 1 , 3 do
			if (x % 2 ~= 0) and (y % 2 ~= 0) then
				table.insert(c , {
					col = start.col + x - 1,
					row = start.row + y - 1	
				})
			end
		end
	end

	return c
end

emptyXBlock.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for x = 1 , 3 do
		for y = 1 , 3 do
			if (x % 2 ~= 0) and (y % 2 ~= 0) then
				local left = half + ((x - 1) * (size + padding))
				local top = half + ((y - 1) * (size + padding))

				local square = display.newRoundedRect(group , left , top , size , size , 5)
				square.fill = emptyXBlock.color
			end
		end
	end

	Shape:addBackground(group)
	group.myName = emptyXBlock
	return group
end

emptyXBlock.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(emptyXBlock , start)
end

emptyXBlock.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(emptyXBlock , start)
end

emptyXBlock.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(emptyXBlock , start)
end

return emptyXBlock
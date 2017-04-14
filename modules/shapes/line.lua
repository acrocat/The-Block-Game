local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local line = {}
line.name =  "line"
line.color = {color.hex("#ed8a09")}

line.getCoordinates = function (self , start)
	local c = {}

	for i = 0 , 4 do
		table.insert(c , {
			col = start.col,
			row = start.row + i	
		})
	end

	return c
end

line.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 4 do
		local top = half + (i * (size + padding))
		local square = display.newRoundedRect(group , half , top , size , size , 5)
		square.fill = line.color
	end

	Shape:addBackground(group)
	group.myName = line
	return group
end

line.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(line , start)
end

line.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(line , start)
end

line.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(line , start)
end

return line
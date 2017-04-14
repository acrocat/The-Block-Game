local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")
local color = require("modules.color")

local blockHole = {}
blockHole.name = "blockHole"
blockHole.color = {color.hex("#70b231")}

blockHole.getCoordinates = function (self , start)
	local c = {}

	for i = 0 , 2 do
		for y = 0 , 2 do
			-- Ignore the center block
			if y ~= 1 or i ~= 1 then
				table.insert(c , {
					col = start.col + i,
					row = start.row + y	
				})
			end
		end
	end

	return c
end

blockHole.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2
	local padding = Grid.padding

	for i = 0 , 2 do
		for y = 0 , 2 do
			-- Ignore the middle block
			if i ~= 1 or y ~= 1 then
				local top = half + (y * (size + padding))
				local left = half + (i * (size + padding))

				local square = display.newRoundedRect(group , top , left , size , size , 5)
				square.fill = blockHole.color
			end
		end
	end

	Shape:addBackground(group)
	group.myName = blockHole
	return group
end

blockHole.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(blockHole , start)
end

blockHole.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(blockHole , start)
end

blockHole.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(blockHole , start)
end

return blockHole
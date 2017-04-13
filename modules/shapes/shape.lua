local Grid = require("modules.grid")
local inspect = require("modules.inspect")

local shape = {}

shape.drawShadowOnGrid = function (self , refShape , start)
	-- Clear the grid
	Grid.reset()

	local points = refShape:getCoordinates(start)

	for i = 1 , #points do
		local point = points[i]

		Grid:drawShadow(point.col , point.row)
	end
end
shape.markOccupiedOnGrid = function (self , refShape , start)
	local points = refShape:getCoordinates(start)

	for i = 1 , #points do
		local point = points[i]

		Grid:markSquareOccupied(point.col , point.row , refShape.color)
	end
end
shape.checkValidityOnGrid = function (self , refShape , start)
	local points = refShape:getCoordinates(start)

	for i = 1 , #points do
		local point = points[i]

		if Grid:checkValidityOfSquare(point.col , point.row) == false then return false end
	end

	return true
end
shape.addBackground = function (self , shapeGroup)
	local width = shapeGroup.width
	local height = shapeGroup.height

	local centerX = width / 2
	local centerY = height / 2

	local bg = display.newRect(shapeGroup , centerX , centerY , width , height)
	bg.alpha = 0.1
	bg:toBack()
end
return shape
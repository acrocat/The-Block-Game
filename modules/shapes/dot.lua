local Grid = require("modules.grid")
local Shape = require("modules.shapes.shape")

local dot = {}
dot.name = "dot"
dot.color = {0,1,1}

dot.getCoordinates = function (self , start)
	return {{col = start.col , row = start.row}}
end

dot.create = function ()
	local group = display.newGroup()

	local size = Grid.squareSize
	local half = size / 2

	local square = display.newRoundedRect(group , half , half , size , size , 5)
	square.fill = dot.color

	Shape:addBackground(group)
	group.myName = dot
	return group
end

dot.drawShadowOnGrid = function (self , start)
	Shape:drawShadowOnGrid(dot , start)
end

dot.markOccupiedOnGrid = function (self , start)
	Shape:markOccupiedOnGrid(dot , start)
end

dot.checkValidityOnGrid = function (self , start)
	return Shape:checkValidityOnGrid(dot , start)
end

return dot
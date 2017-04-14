local inspect = require("modules.inspect")
local sound = require("modules.sound")

-- Grid Properties
local displayGroup = display.newGroup()
local size = 10
local margin = 5
local padding = 3
local topOffset = 100
local width = display.contentWidth - (margin * 2)
local squareSize = (width - ((size - 1) * padding)) / size

local grid = {}
grid = grid
grid.displayGroup = displayGroup
grid.size = size
grid.margin = margin
grid.padding = padding
grid.width = width
grid.squareSize = squareSize
grid.shadowColor = {0.5}
grid.squareColor = {1,1,1}
grid.squareAlpha = 0.8
grid.topOffset = topOffset
grid.squares = {}

grid.create = function (self) 
	for y = 1 , grid.size do
		for x = 1 , grid.size do
			local position = grid:getPoint(x, y)

			local gridSquare = display.newRoundedRect(grid.displayGroup , position.x , position.y , grid.squareSize , grid.squareSize , 5)

			table.insert(grid.squares , {
				square = gridSquare,
				col = x,	
				row = y,
				occupied = false
			})
		end
	end	

	return grid.displayGroup
end

grid.getPoint = function (self , col , row)
	return {
		x = grid.margin + ((grid.squareSize + grid.padding) * (col - 1)) + (grid.squareSize / 2),
		y = grid.topOffset + ((grid.squareSize + grid.padding) * (row - 1)) + (grid.squareSize / 2)
	}	
end

grid.getSquareAtCoordinates = function (self , col , row)
	if not(col > self.size) and not(row > self.size) then
		local index = ((row - 1) * grid.size) + col

		return grid.squares[index]
	end
end

grid.getClosestSquareToObject = function (self , object)
	local left = object.x
	local top = object.y

	-- Find closest grid block
	local closest = false
	for i = 1 , #grid.squares do
		local square = grid.squares[i]

		if closest == false then
			closest = square
		else
			local function getDistance (square)
				local x = square.square.x - (grid.squareSize / 2) - left
				local y = square.square.y - (grid.squareSize / 2) - top

				return math.sqrt(math.pow(x , 2) + math.pow(y , 2))
			end

			if getDistance(square) < getDistance(closest) then closest = square end
		end
	end

	-- If the distance of the closest square the the origin object is too great,
	-- it will be ignored
	-- Get distance of this object from the object
	local deltax = closest.square.x - left
	local deltay = closest.square.y - top

	local distance = math.sqrt(math.pow(deltay , 2) + math.pow(deltax , 2))

	if distance > grid.squareSize then return false end

	return closest
end

grid.markSquareOccupied = function (self , col , row , color)
	local square = grid:getSquareAtCoordinates(col , row)

	if square then 
		square.occupied = true 
		square.square.fill = color
		square.alpha = 1
	end	
end

grid.reset = function (self , totalClear)
	for i = 1 , #grid.squares do
		local square = grid.squares[i]
		if square.occupied == false or totalClear == true then
			square.square.fill = grid.squareColor
			square.occupied = false
			square.square.alpha = grid.squareAlpha
		end
	end
end

grid.purgeCompletedSets = function (self)
	local function purgreSquare (square)
		transition.to(square.square , {
				time = 100,
				xScale = 0.1,
				yScale = 0.1,
				alpha = grid.squareAlpha,
				onComplete = function () 
					square.square.xScale = 1
					square.square.yScale = 1
					square.square.fill = grid.squareColor
					square.occupied = false
				end
			})
	end
	local function purgeRow (row)
		for col = 1 , grid.size do 
			local square = grid:getSquareAtCoordinates(col , row)

			timer.performWithDelay(25 * col , function() 
				purgreSquare(square)
			end)
		end
	end
	local function purgeCol (col)
		for row = 1 , grid.size do
			local square = grid:getSquareAtCoordinates(col , row)

			timer.performWithDelay(25 * row , function() 
				purgreSquare(square)
			end)
		end
	end

	local rowsToPurge = {}
	local colsToPurge = {}

	-- Check all rows
	for row = 1 , grid.size do 
		local complete = 0
		for col = 1 , grid.size do 
			local square = grid:getSquareAtCoordinates(col , row)

			if square.occupied then complete = complete + 1 end
		end

		if complete == grid.size then table.insert(rowsToPurge , row) end
	end

	-- Check all cols
	for col = 1 , grid.size do 
		local complete = 0
		for row = 1 , grid.size do 
			local square = grid:getSquareAtCoordinates(col , row)

			if square.occupied then complete = complete + 1 end
		end

		if complete == grid.size then table.insert(colsToPurge , col) end
	end

	-- Purge the completed rows
	for i = 1 , #rowsToPurge do purgeRow(rowsToPurge[i]) end
	for i = 1 , #colsToPurge do purgeCol(colsToPurge[i]) end

	-- Clear the board for good measure
	grid:reset(false)

	return (#rowsToPurge + #colsToPurge)
end

grid.drawShadow = function (self , col , row)
	local square = grid:getSquareAtCoordinates(col , row)

	if square and square.occupied == false then 
		square.square.fill = grid.shadowColor 
		square.square.alpha = 1
	end
end

grid.checkValidityOfSquare = function (self , col , row) 
	local square = grid:getSquareAtCoordinates(col , row)

	if square == nil then 
		return false 
	end

	return (square.occupied == false)
end

grid.scanForAvailableSpace = function (self , shape)
	local validLocations = 0

	-- Loop through every square
	for x = 1 , self.size do
		for y = 1 , self.size do
			-- Get the starting point for this check
			local startingSqaure = self:getSquareAtCoordinates(x , y)
			local validAtPoint = true

			-- Get the coordinates for this shape
			local points = shape:getCoordinates(startingSqaure)

			-- Check the validity of each of these points
			for i = 1 , #points do
				local point = points[i]
				if self:checkValidityOfSquare(point.col , point.row) == false then validAtPoint = false end
			end

			if validAtPoint then validLocations = validLocations + 1 end
		end
	end

	return validLocations
end

return grid
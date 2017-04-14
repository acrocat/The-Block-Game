local composer = require("composer")
local scene = composer.newScene()

local Save = require("modules.save")
local inMobi = require("plugin.inMobi")
local Sound = require("modules.sound")

local Grid = require("modules.grid")
local Deck = require("modules.deck")

local inspect = require("modules.inspect")

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local lblScore
local score

-- Scene Lifecycle
function scene:create (event)
	local sceneGroup = self.view

	-- Reset score
	score = 0

	-- Print score label
	lblScore = display.newText("Score: " .. score , centerX , 80)
	lblScore.fill = {0,0,0}	

	-- Create Grid
	Grid:create()

	sceneGroup:insert(Grid.displayGroup)
	sceneGroup:insert(Deck.displayGroup)
	sceneGroup:insert(lblScore)

	Grid.displayGroup:addEventListener("tap" , finishGame)
end

function scene:show (event)
	if event.phase == "will" then
		-- Clear the deck
		Deck:clear()

		-- Populate the deck
		Deck:populate()

		-- Reset the grid
		Grid:reset(true)
	end
end

function shapePan (event)
	local phase = event.phase
	local verticalOffset = 120

	-- Kill any existing transitions
	transition.cancel(event.target)

	if phase == "began" then
		display.currentStage:setFocus(event.target)

		transition.to(event.target , {
			time=100,
			alpha=0.5,
			xScale = 1,
			yScale = 1,
			x=event.x - (event.target.width / 2),
			y=event.y - event.target.height - 30
		})
	elseif phase == "moved" then
		display.currentStage:setFocus(event.target)

		event.target.x = event.x - (event.target.width / 2)
		event.target.y = event.y - event.target.height - 30
		event.target.alpha = 0.5
		event.target.xScale = 1
		event.target.yScale = 1

		local closestSquare = Grid:getClosestSquareToObject(event.target)

		if closestSquare then event.target.myName:drawShadowOnGrid(closestSquare) end
	elseif phase == "ended" then
		local origin = Deck:getOriginForPiece(event.target.tag , event.target)
		display.currentStage:setFocus(nil)

		local closest = Grid:getClosestSquareToObject(event.target)

		if closest and event.target.myName:checkValidityOnGrid(closest) then
			-- Play beep sound
			Sound:pop()

			-- Mark squares as occupied
			event.target.myName:markOccupiedOnGrid(closest)

			Deck:removePiece(event.target.tag)

			-- Remove event listener so the block is here for good
			event.target:removeEventListener("touch" , shapePan)

			-- Remove piece from display
			display.remove(event.target)

			-- Run a purge
			local points = Grid:purgeCompletedSets()
			if points > 0 then Sound:beep() end
			updateScore(points)

			-- If necessary, refill the deck
			if #Deck.pieces == 0 then Deck:populate() end

			if Deck:checkForSpacesInGrid() == false then finishGame() end
		else
			-- Return back to origin
			transition.to(event.target , {
				time= 100,
				xScale = 0.75,
				yScale = 0.75,
				x = origin.x,
				y = origin.y,
				alpha = 1
			})

			Grid:reset(false)
		end
	elseif phase == "cancelled" then
		display.currentStage:setFocus(nil)

		-- Return back to origin
		transition.to(event.target , {
			time = 100,
			xScale = 0.75,
			yScale = 0.75,
			x = origin.x,
			y = origin.y,
			alpha = 1
		})

		Grid:reset(false)
	end
end

function updateScore (pointsToAdd)
	score = score + pointsToAdd
	lblScore.text = "Score: " .. score
end

function finishGame ()
	Save:setHighScore(10)

	-- Load the menu scene
	composer:gotoScene("scenes.mainmenu" , {
		effect = "fade"
	})
end

function adListener (event)
	if event.phase == "init" then
		-- Load the ad
		inMobi.load("banner" , "1490135372226" , {
			width = screenWidth,
			height = 75,
			autoRefresh = true	
		})
	elseif event.phase == "loaded" then
		print("Loaded the ad")

		inMobi.show("1490135372226")
	elseif event.phase == "failed" then
		print("Failed to load the ad")
	end
end
-- Create ad
inMobi.init(adListener , {
	accountId="allany"
})

scene:addEventListener("create" , scene)
scene:addEventListener("show" , scene)

return scene
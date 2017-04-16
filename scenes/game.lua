local composer = require("composer")
local scene = composer.newScene()
local sound = require("modules.sound")

local Save = require("modules.save")
local Sound = require("modules.sound")

local Grid = require("modules.grid")
local Deck = require("modules.deck")

local inspect = require("modules.inspect")

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local starIcon
local lblHighScore

local lblScore
local score

local btnPause

-- Scene Lifecycle
function scene:create (event)
	local sceneGroup = self.view

	-- Reset score
	score = 0

	-- Print high score label
	starIcon = display.newImageRect("images/star.png" , 30 , 30)
	starIcon.x = 20
	starIcon.y = 80

	lblHighScore = display.newText("0" , 50 , 80)
	lblHighScore.fill = {0,0,0}

	-- Print score label
	lblScore = display.newText(score , screenWidth - 45 , 80 , native.systemFontBold)
	lblScore.fill = {0,0,0}	

	-- Pause button
	btnPause = display.newImageRect("images/pause.png" , 30 , 20)
	btnPause.x = centerX
	btnPause.y = lblScore.y
	btnPause:addEventListener("tap" , pause)

	-- Create Grid
	Grid:create()

	sceneGroup:insert(Grid.displayGroup)
	sceneGroup:insert(Deck.displayGroup)
	sceneGroup:insert(lblScore)
	sceneGroup:insert(starIcon)
	sceneGroup:insert(lblHighScore)
	sceneGroup:insert(btnPause)
end

function scene:show (event)
	if event.phase == "will" then
 		-- Reset the score
 		score = 0
 		updateScore(score)

		-- Clear the deck
		Deck:clear()

		-- Populate the deck
		Deck:populate()

		-- Reset the grid
		Grid:reset(true)

		-- Load the high score
		local highScore = Save:getHighScore()
		updateHighScore(highScore)
	elseif event.phase == "did" then
		if inMobi.isLoaded(topBannerId) then inMobi.show(topBannerId) end
	end
end

function scene:hide (event)
	if event.phase == "will" then
		inMobi.hide(topBannerId)
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
				xScale = Deck.pieceScale,
				yScale = Deck.pieceScale,
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
			xScale = Deck.pieceScale,
			yScale = Deck.pieceScale,
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

function updateHighScore (score)
	lblHighScore.text = score
end

function finishGame ()
	-- Load game over screen
	composer:showOverlay("scenes.gameover" , {
		effect = "fade"	,
		time = 300,
		isModal = true,
		params = {
			score = score
		}
	})
end

function loadInterstitialAd ()
	inMobi.load("interstitial" , "1494050761712")
end

function pause ()
	sound:pop()

	composer:showOverlay("scenes.pause" , {
		effect = "fade"	,
		isModal = true
	})
end

function scene:restartGame ()
	Deck:clear()
	Deck:populate()

	Grid:reset(true)

	score = 0
	updateScore(0)
end
function scene:quit ()
	composer.gotoScene("scenes.mainmenu" , {
		effect = "fade",
		time = 300
	})
end



scene:addEventListener("create" , scene)
scene:addEventListener("show" , scene)
scene:addEventListener("hide" , scene)

return scene
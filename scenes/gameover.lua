local composer = require("composer")
local scene = composer.newScene()
local Save = require("modules.save")
local Color = require("modules.color")
local Sound = require("modules.sound")

local lblScore
local btnRestart
local btnQuit

local action = "restart"

function scene:create (event)
	local sceneGroup = self.view

	-- Add bg
	local bg = display.newRect(sceneGroup , display.contentCenterX , display.contentCenterY , display.contentWidth , display.contentHeight)
	bg.fill = {1,1,1}
	bg.alpha = 0.8

	local score = event.params.score

	-- You scored SCORE points!
	local youScored = display.newText(sceneGroup , "You scored " , display.contentCenterX , display.contentCenterY - 75 , native.systemFontBold , 50)
	youScored.fill = {0,0,0}

	lblScore = display.newText(sceneGroup , score , display.contentCenterX , display.contentCenterY , native.systemFontBold , 75)
	lblScore.fill = {0,0,0}

	-- Get the high score
	local highScore = Save:getHighScore()
	if score > tonumber(highScore) then
		-- Save the high score
		Save:setHighScore(score)

		local newHighScore = display.newText(sceneGroup , "New High Score!" , display.contentCenterX , display.contentCenterY + 75 , native.systemFontBold , 25)
		newHighScore.fill = {Color.hex("#edc440")}
	end

	-- Buttons
	local iconSize = 60
	btnQuit = display.newImageRect(sceneGroup , "images/quit.png" , iconSize , iconSize)
	btnQuit.x = btnQuit.width + 20
	btnQuit.y = display.contentHeight - btnQuit.height - 20
	btnQuit:addEventListener("tap" , quit)

	btnRestart = display.newImageRect(sceneGroup , "images/restart.png" , iconSize , iconSize)
	btnRestart.x = display.contentWidth - btnRestart.width - 20
	btnRestart.y = btnQuit.y
	btnRestart:addEventListener("tap" , restart)
end

function scene:show (event)
	if event.phase == "did" then
		ads:showInterstitial()
	end
end

function scene:hide (event)
	if event.phase == "did" then
		if action == "restart" then
			event.parent:restartGame()
		elseif action == "quit" then
			event.parent:quit()
		end
	end
end

function restart ()
	action = "restart"

	hideMenu()
end

function quit ()
	action = "quit"

	hideMenu()
end

function hideMenu ()
	Sound:pop()

	composer:hideOverlay("fade" , 300)
end

scene:addEventListener("create" , scene)
scene:addEventListener("show" , scene)
scene:addEventListener("hide" , scene)

return scene

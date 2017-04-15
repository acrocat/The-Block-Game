local composer = require("composer")
local scene = composer.newScene()
local sound = require("modules.sound")

local btnResume
local btnRestart
local btnQuit

local action = "resume"

function scene:create (event)
	local sceneGroup = self.view

	local buttonSize = 75

	-- Create background
	local bg = display.newRect(sceneGroup , display.contentCenterX , display.contentCenterY , display.contentWidth , display.contentHeight)
	bg.fill = {1,1,1}
	bg.alpha = 0.5

	btnResume = display.newImageRect(sceneGroup , "images/resume.png" , buttonSize , buttonSize)
	btnResume.x = display.contentCenterX
	btnResume.y = display.contentCenterY - 100
	btnResume:addEventListener("tap" , resumeGame)

	btnRestart = display.newImageRect(sceneGroup , "images/restart.png" , buttonSize , buttonSize)
	btnRestart.x = btnResume.x
	btnRestart.y = display.contentCenterY
	btnRestart:addEventListener("tap" , restartGame)

	btnQuit = display.newImageRect(sceneGroup , "images/quit.png" , buttonSize , buttonSize)
	btnQuit.x = btnResume.x
	btnQuit.y = display.contentCenterY + 100
	btnQuit:addEventListener("tap" , quit)
end

function scene:hide (event) 
	local parent = event.parent

	if event.phase == "did" then
		if action == "restart" then 
			parent:restartGame() 
		elseif action == "quit" then
			parent:quit()
		end
	end
end

function resumeGame ()
	action = "resume"

	closeMenu()
end

function restartGame ()
	action = "restart"

	closeMenu()
end

function quit ()
	action = "quit"

	closeMenu()
end

function closeMenu ()
	sound:pop()

	composer:hideOverlay("fade" , 300)
end

scene:addEventListener("create" , scene)
scene:addEventListener("hide" , scene)

return scene
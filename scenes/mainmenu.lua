local Color = require("modules.color")
local composer = require("composer")
local inspect = require("modules.inspect")
local scene = composer.newScene()

-- Scene Life cycle
function scene:create (event)
	local sceneGroup = self.view
	local menuItems = display.newGroup()

	-- Display game logo
	local logo = display.newImageRect(menuItems , "images/logo.png" , 200, 200)
	logo.x = display.contentCenterX
	logo.y = logo.height

	-- Create button to start game
	local btnStart = display.newRoundedRect(menuItems , display.contentCenterX , logo.y + logo.height , 200 , 50 , 10)

	btnStart.fill = {Color.hex("#123123")}
	display.newText(menuItems , "PLAY!" , btnStart.x , btnStart.y , native.systemFontBold)

	btnStart:addEventListener("tap" , function () 
		composer.gotoScene("scenes.game" , {
			effect = "crossFade"	,
			time = 500
		})
	end)

	sceneGroup:insert(menuItems)
end

scene:addEventListener("create" , scene)

-- Read the high score for fun
local Save = require("modules.save")
print(Save:getHighScore())

return scene
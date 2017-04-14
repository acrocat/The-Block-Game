local Color = require("modules.color")
local composer = require("composer")
local inspect = require("modules.inspect")
local scene = composer.newScene()
local save = require("modules.save")

local logo
local btnStart
local btnStartText
local menuItems

-- High score label
local highScoreGroup
local lblHighScore
local startIcon

-- Scene Life cycle
function scene:create (event)
	menuItems = display.newGroup()
	local sceneGroup = self.view

	-- Display game logo
	logo = display.newImageRect(menuItems , "images/main-splash.png" , 200, 300)
	logo.x = display.contentCenterX
	logo.y = 30 + (logo.height / 2)

	-- Create button to start game
	btnStart = display.newRoundedRect(menuItems , display.contentCenterX , logo.y + logo.height , 200 , 50 , 10)

	btnStart.fill = {Color.hex("#123123")}
	btnStartText = display.newText(menuItems , "PLAY!" , btnStart.x , btnStart.y , native.systemFontBold)

	btnStart:addEventListener("tap" , function () 
		composer.gotoScene("scenes.game" , {
			effect = "crossFade",
			time = 500
		})
	end)

	-- Create high score label
	highScoreGroup = display.newGroup()

	starIcon = display.newImageRect(highScoreGroup , "images/star.png" , 40 , 40)
	starIcon.x = display.contentCenterX - 5
	starIcon.y = logo.height + 65

	lblHighScore = display.newText(highScoreGroup , "0" , starIcon.x + 35 , starIcon.y , native.systemFontBold)
	lblHighScore.fill = {0,0,0}

	menuItems:insert(highScoreGroup)

	sceneGroup:insert(menuItems)
end

function scene:show (event)
	if event.phase == "will" then
		-- Update high score label
		local highScore = save:getHighScore()

		setHighScoreLabel(highScore)

		-- Prepare elements for animation
		logo.x = logo.width * -1
		btnStart.x = display.contentWidth + (btnStart.width / 2)
		btnStartText.x = btnStart.x
	elseif event.phase == "did" then
		-- Animate menu items in
		transition.to(logo , {
			x = display.contentCenterX,
			time = 300
		})
		transition.to(btnStart , {
			x = display.contentCenterX ,
			time = 300
		})
		transition.to(btnStartText , {
			x = display.contentCenterX ,
			time = 300
		})
	end
end

function setHighScoreLabel (score)
	lblHighScore.text = score
end

scene:addEventListener("create" , scene)
scene:addEventListener("show" , scene)

return scene
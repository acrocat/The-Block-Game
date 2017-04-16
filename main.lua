local composer = require("composer")
local Color = require("modules.color")
inMobi = require("plugin.inMobi")

topBannerId = "1490135372226"
interstitialAdId = "1494050761712"

math.randomseed(os.time())

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- Set background color to white
display.setDefault("background" , Color.hex("#efefef"))

function adListener (event)
	if event.phase == "init" or event.phase == "closed" then
		-- Load the ad
		inMobi.load("banner" , topBannerId , {
			width = screenWidth,
			height = 75,
			autoRefresh = true
		})

		inMobi.load("interstitial" , interstitialAdId , {
			autoRefresh = true	
		})
	end
end

-- Load ads
inMobi.init(adListener , {
	accountId="allany"
})

-- Load main menu
composer:gotoScene("scenes.mainmenu")
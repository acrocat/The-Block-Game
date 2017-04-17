local composer = require("composer")
local Color = require("modules.color")

ads = require("modules.ads")
ads:init()

math.randomseed(os.time())

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- Set background color to white
display.setDefault("background" , Color.hex("#efefef"))

-- Load main menu
composer:gotoScene("scenes.mainmenu")
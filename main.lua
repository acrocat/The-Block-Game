local composer = require("composer")
local Color = require("modules.color")

math.randomseed(os.time())

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- Set background color to white
display.setDefault("background" , Color.hex("#d7dbe0"))

-- Load main menu
composer:gotoScene("scenes.mainmenu")
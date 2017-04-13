-- Load sounds
local pop = media.newEventSound("sounds/pop1.wav")
local beep = media.newEventSound("sounds/beep2.wav")
local swipe = media.newEventSound("sounds/swipe1.wav")

local sound = {}

sound.pop = function ()
	media.playEventSound(pop)
end

sound.beep = function ()
	media.playEventSound(beep)
end

sound.swipe = function ()
	media.playEventSound(swipe)
end

return sound
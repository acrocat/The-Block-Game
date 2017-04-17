local inMobi = require("plugin.inMobi")
local ads = {}

topBannerId = "1490135372226"
interstitialAdId = "1494050761712"

-- Different ads if we're on android
if system.getInfo("platform") == "android" then
	topBannerId = "1492406418250"
	interstitialAdId = "1490665508447"
end

print("Banner Ad: " .. topBannerId)
print("Interstitial Ad: " .. interstitialAdId)

ads.listener = function (event)
	if event.phase == "init" or event.phase == "closed" then
		ads:loadBanner()
		ads:loadInter()
	end
end

ads.init = function ()
	inMobi.init(ads.listener , {
		accountId="allany"
	})
end

ads.loadBanner = function ()
	inMobi.load("banner" , topBannerId , {
		width = screenWidth,
		height = 75,
		autoRefresh = true
	})
end

ads.loadInter = function ()
	inMobi.load("interstitial" , interstitialAdId , {
		autoRefresh = true	
	})
end

ads.showInterstitial = function ()
	inMobi.show(interstitialAdId)
end

ads.hideInterstitial = function ()
	inMobi.hide(interstitialAdId)

	ads:loadInter()
end

ads.hideBanner = function ()
	inMobi.hide(topBannerId)

	ads:loadBanner()
end

ads.showBanner = function ()
	inMobi.show(topBannerId)
end

return ads
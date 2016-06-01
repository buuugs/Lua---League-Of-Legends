function OnLoad()
Menu()
end
function Menu()
print("Elo Łukasz :) Napisałem dla Ciebie Skin Hacka")
menu = scriptConfig("Skin Changer", "Skin Changer")
menu:addParam("skin", "Enable", SCRIPT_PARAM_ONOFF, true)
menu:addParam("skinlist", "Skin", SCRIPT_PARAM_LIST, 1, {"1","2","3","4","5","6","7","8","9","10","11","12","13"})
menu:setCallback("skin", function (value)
if value then
SetSkin(myHero, menu.skinlist-1)
else
SetSkin(myHero, -1)
end
end)
menu:setCallback("skinlist", function (value)
if menu.skin then
SetSkin(myHero, menu.skinlist-1)
end
end)	
end

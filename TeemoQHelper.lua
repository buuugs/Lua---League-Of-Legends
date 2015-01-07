--[[
Teemo Q Helper By Ajgoreq.
Auto Q in enemy have 200 HP
]]--
function OnLoad()
 
     ConfigAQT = scriptConfig("Teemo Q Helper", "temmoq")
     ConfigAQT:addParam("qshoot", "Q Attack", SCRIPT_PARAM_ONKEYDOWN, false, 32)
     ConfigAQT:addParam("circle", "Draw Q Circle", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("M"))
		      ConfigAQT:addParam("AUTOQ", "Auto Q", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("N"))
   ts = TargetSelector(TARGET_LOW_HP_PRIORITY,580)
end

function OnTick()
AUTOQ()
QHELP()
OnDraw()
end

function QHELP()
if (ConfigAQT.qshoot) then
ts:update()
	if (ts.target ~= nil) then
if (myHero:CanUseSpell(_Q) == READY) then
CastSpell(_Q, ts.target)
end
end
end
end
function OnDraw()
     if (ConfigAQT.circle) then
          DrawCircle(myHero.x, myHero.y, myHero.z, 580, 0xFF00FF)
     end
end

function AUTOQ()
if (ConfigAQT.AUTOQ) then
ts:update()
	if (ts.target ~= nil) then
if (ts.target.health < 100) and (myHero:CanUseSpell(_Q) == READY) then
CastSpell(_Q, ts.target)
  end
 end
end
end

if myHero.charName ~= "Katarina" then return end

require "SxOrbWalk"

AnimTrack = 0

local Wrange = 375
local Erange = 700
local Qrange = 675
local Rrange = 550
local ignite = nil
local iDMG = 0

local ignite, iDMG = nil, 0 
local QREADY, WREADY, EREADY, RREADY = false

function OnLoad()
    StayBelle()
	PrintChat("StayBelle Katarina Loaded")
	IgniteSet()
end

function StayBelle()
	
	
	Config = scriptConfig("StayBelle", "StayBelle")
	
	Config:addSubMenu("Key Settings", "Keys")
		Config.Keys:addParam("combokey", "Combo key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Config.Keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, 67)
	Config.Keys:addParam("farmkey", "Farm On/Off", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("Z"))
	    
	Config:addSubMenu("Combo Settings", "Combo")
		Config.Combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Config.Combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true) 
		Config.Combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true) 
		Config.Combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
		
	Config:addSubMenu("Misc", "Misc")
		Config.Misc:addParam("KSQ", "Auto KS with Q", SCRIPT_PARAM_ONOFF, true)
		Config.Misc:addParam("KSW", "Auto KS with W", SCRIPT_PARAM_ONOFF, true)
		Config.Misc:addParam("KSE", "Auto KS with E", SCRIPT_PARAM_ONOFF, true)
		Config.Misc:addParam("KSIG", "Auto KS using ignite", SCRIPT_PARAM_ONOFF, true)
		
	Config:addSubMenu("Drawings", "Draw")
		Config.Draw:addParam("DrawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("DrawW", "Draw W range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("DrawE", "Draw E range", SCRIPT_PARAM_ONOFF, true)
	
	Config:addSubMenu("Farm", "farm")
	Config.farm:addParam("UseQFarm", "Use Q", SCRIPT_PARAM_ONOFF, false)
	
	
	
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, Erange)
	enemyMinions = minionManager(MINION_ENEMY, ERANGE, player)
    ts.name = "Focus"
	Config:addSubMenu("Target Selector", "TS")
		Config.TS:addTS(ts)
	
	Config:addSubMenu("Orbwalker", "SxOrb")
		SxOrb:LoadToMenu(Config.SxOrb)

end

function OnTick()
	Check()
	IgniteKS()
	ComboKey()
	KSLOAD()
	HarassKey()
	FarmKey()
end

function OnDraw()
	if Config.Draw.DrawQ and QREADY and not myHero.dead then 
		DrawCircle(myHero.x, myHero.y, myHero.z, Qrange, 0x00FF00)
	end
	if Config.Draw.DrawW and WREADY and not myHero.dead then 
		DrawCircle(myHero.x, myHero.y, myHero.z, Wrange, 0x00FF00)
	end
	if Config.Draw.DrawE and EREADY and not myHero.dead then 
		DrawCircle(myHero.x, myHero.y, myHero.z, Erange, 0x00FF00)
	end
end

function Checks()
	ts:update()
	target = ts.target 
	SxOrb:ForceTarget(target)
	
	QREADY = (myHero:CanUseSpell(_Q) == READY)
	WREADY = (myHero:CanUseSpell(_W) == READY) 
	EREADY = (myHero:CanUseSpell(_E) == READY)
	RREADY = (myHero:CanUseSpell(_R) == READY)
  	IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY) 
end

function Combo()
	if ValidTarget(target) then
		if QREADY and Config.Combo.UseQ then 
			if GetDistance(target) <= Qrange then
				CastSpell(_Q, target) 
			end
		end
		if EREADY and Config.Combo.UseE then
			if GetDistance(target) <= Erange then 
				CastSpell(_E, target)
			end
		end
		if WREADY and Config.Combo.UseW then
			if GetDistance(target) <= Wrange then
				CastSpell(_W)
			end
		end
		if RREADY and not QREADY and not WREADY and not EREADY and Config.Combo.UseR then
			if GetDistance(target) <= Rrange then
				CastSpell(_R)
			end
		end
	end
end

function AutoIgnite(enemy)
  	iDmg = ((IREADY and getDmg("IGNITE", enemy, myHero)) or 0)
	if enemy.health <= iDmg and GetDistance(enemy) <= 600 and ignite ~= nil then
		if IREADY then CastSpell(ignite, enemy) end 
	end
end

function IgniteSet()

	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
		ignite = SUMMONER_1 
	elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
		ignite = SUMMONER_2 
	end
end

function ComboKey()
    if Config.Keys.combokey then
		Combo()
	end
	
function IgniteKS()
    	if ValidTarget(target) then
		if Config.Misc.KSIG then
			AutoIgnite(target)
		end
  end
end

function KSLOAD()
    	if ValidTarget(target) then
		if Config.Misc.KSQ then
			KSQ(target)
		end
	
end
   	if ValidTarget(target) then
		if Config.Misc.KSW then
			KSW(target)
		end
	
end
   	if ValidTarget(target) then
		if Config.Misc.KSE then
			KSE(target)
		end
	
end

end

function KSQ(enemy)
	if QREADY and getDmg("Q", enemy, myHero) > enemy.health then 
		if GetDistance(enemy) <= Qrange then 
			CastSpell(_Q, enemy)
		end
	end
end

function KSW(enemy)
	if WREADY and getDmg("W", enemy, myHero) > enemy.health then 
		if GetDistance(enemy) <= Wrange then 
			CastSpell(_W, enemy)
		end
	end
end

function KSE(enemy)
	if EREADY and getDmg("E", enemy, myHero) > enemy.health then 
		if GetDistance(enemy) <= Erange then 
			CastSpell(_E, enemy)
		end
	end
end

function OnAnimation(Unit, Animation)
    if Unit.isMe and (Animation == "Spell4" or Animation == "Spell4_Loop") then
        AnimTrack = GetTickCount() + 50 + GetLatency()
    end
end

function IsChanneling()
    return AnimTrack > GetTickCount()
end

function Farm()
		enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
			if ValidTarget(minion) and QREADY and getDmg("Q", minion, myHero) > minion.health then 
		if GetDistance(minion) <= Qrange then 
			CastSpell(_Q, minion)
		end
   end
  end
 end
end

function FarmKey()
    if Config.Keys.farmkey then
        Farm()
    end
end

function Harass()

	if not target then return end

	if ValidTarget(target) then
if QREADY and GetDistance(target) < Qrange then
			CastSpell(_Q, target)
	    end
	  end
end
end

function HarassKey()
    if Config.Keys.harass then
        Harass()
    end
   end

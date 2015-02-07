-- Lib Updater
local REQUIRED_LIBS = {
	["SxOrbWalk"] = "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"
	}
	local DOWNLOADING_LIBS, DOWNLOAD_COUNT = false, 0

function AfterDownload()
	DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
	if DOWNLOAD_COUNT == 0 then
		DOWNLOADING_LIBS = false
		print("<b><font color=\"#6699FF\">Required libraries downloaded successfully, please reload (double F9).</font>")
	end
end

for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(REQUIRED_LIBS) do
	if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
		require(DOWNLOAD_LIB_NAME)
	else
		DOWNLOADING_LIBS = true
		DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1
		DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
	end
end


if FileExist(LIB_PATH.."SxOrbWalk.lua") then
	SxOrbloaded = true
end

if myHero.charName ~= "Pantheon" then return end
--ScriptStatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("REHFGGEEIIE") 


local Wrange = 600
local Erange = 600
local Qrange = 600
local Rrange = 5500
local ignite = nil
local iDMG = 0

local ignite, iDMG = nil, 0 
local QREADY, WREADY, EREADY, RREADY = false

--[[    Ward Jump       ]]--
local WardTable = {}
local SWard, VWard, SStone, RSStone, Wriggles = 2044, 2043, 2049, 2045, 3154
local SWardSlot, VWardSlot, SStoneSlot, RSStoneSlot, WrigglesSlot = nil, nil, nil, nil, nil
local jumpReady = false
local jumpRange = 700
local wardRange = 600
local jumpDelay = 0

function OnLoad()

    Pantheon()
	PrintChat("Pantheon - This is Sparta")
	IgniteSet()
	end


function Pantheon()
	
	
	Config = scriptConfig("Pantheon - This is Sparta", "Pantheon")
	
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
		if VIP_USER then
		Config:addSubMenu("Packets", "Packets")
		Config.Packets:addParam("QPACK", "Q Packest", SCRIPT_PARAM_ONOFF, false)
		Config.Packets:addParam("WPACK", "W Packest", SCRIPT_PARAM_ONOFF, false)
		end
	Config:addSubMenu("Drawings", "Draw")
		Config.Draw:addParam("DrawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("DrawW", "Draw W range", SCRIPT_PARAM_ONOFF, true)
		Config.Draw:addParam("DrawE", "Draw E range", SCRIPT_PARAM_ONOFF, true)
	
	Config:addSubMenu("Farm", "farm")
	Config.farm:addParam("UseQFarm", "Use Q", SCRIPT_PARAM_ONOFF, true)
	Config.farm:addParam("UseEFarm", "Use E", SCRIPT_PARAM_ONOFF, true)
	
	Config:addSubMenu("Credits", "Credits")
	Config.Credits:addParam("info", " >> Autors : ", SCRIPT_PARAM_INFO, "Ajgoreq")
	Config.Credits:addParam("info2", "", SCRIPT_PARAM_INFO, "Spartan")
	
		Config:addParam("info3", " >> Version ", SCRIPT_PARAM_INFO, "1.6")

	
	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, Qrange)
	enemyMinions = minionManager(MINION_ENEMY, Qrange, myHero, MINION_SORT_MAXHEALTH_DEC)
    ts.name = "Pantheon"
	Config:addSubMenu("Target Selector", "TS")
		Config.TS:addTS(ts)
	
	Config:addSubMenu("Orbwalker", "SxOrb")
		SxOrb:LoadToMenu(Config.SxOrb)

end

function OnTick()
	Checks()
	KSLOAD()
  HarassKey()
 IgniteKS()
 ComboKey()
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
			if VIP_USER and Config.Packets.QPACK then
			Packet("S_CAST", {spellId = _Q, targetNetworkId = target.networkID}):send()
			else
				CastSpell(_Q, target) 
			end
		end
		end
		if WREADY and not QREADY and Config.Combo.UseW then
			if GetDistance(target) <= Wrange then 
			if VIP_USER and Config.Packets.WPACK then
			Packet("S_CAST", {spellId = _W, targetNetworkId = target.networkID}):send()
			else
				CastSpell(_W, target)
			end
 end
 end
		if EREADY and not WREADY and not QREADY and Config.Combo.UseE then
			if GetDistance(target) <= Wrange then
				CastSpell(_E, target.x, target.z)
			end
		end
		if RREADY and not QREADY and not WREADY and not EREADY and Config.Combo.UseR then
			if GetDistance(target) <= Rrange then
				CastSpell(_R, target.x, target.z)
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


function Harass()

if not target then return end

if ValidTarget(target) then
if QREADY and GetDistance(target) < Qrange then
			CastSpell(_Q, target)
	    end
	  end
end

function HarassKey()
    if Config.Keys.harass then
        Harass()
    end
   end
	
	function FarmQ()
		enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
			if Config.farm.UseQFarm then
				if ValidTarget(minion) and GetDistance(minion) <= Qrange and QREADY and getDmg("Q", minion, myHero) > minion.health then
					CastSpell(_Q, minion)
				end
			end
		end
	end

	
		function FarmE()
		enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
			if Config.farm.UseEFarm then
				if ValidTarget(minion) and GetDistance(minion) <= Erange and EREADY and getDmg("E", minion, myHero) > minion.health then
					CastSpell(_E, minion.x, minion.z)
				end
			end
		end
	end
		
	function FarmKey()
			 if Config.Keys.farmkey then
			 FarmQ()
			 FarmE()
			 end
			 end

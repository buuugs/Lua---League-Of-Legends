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

require 'spellDmg'

--[[Slay Belle Katarina]]--



if myHero.charName ~= "Katarina" then return end

local enemyHeroes = GetEnemyHeroes()

local UseQ = StayBelle.comboset.useq

local UseW = StayBelle.comboset.usew

local UseE = StayBelle.comboset.usee

local UseR = StayBelle.comboset.user

local QRANGE = 675

local WRANGE = 375

local ERANGE = QRANGE+25

local RRANGE = 550

local FarmKey = StayBelle.staykatafarm.farmkey

local ComboKey = StayBelle.staycombo

local AutoKSON = StayBelle.autokss.onoffks

function OnLoad()
Menu()
    print("<b><font color=\"#6699FF\">Slay Belle Katarina : Loaded</font>")
    PrintChat("/all Good Luck :D")
   
locals()
end

function OnTick()
Combo()
-------
ts:update()
-------
CoolDown()
-------
Harass()
-------
Farm()
-------
AutoKS()
-------
Ready2(spell)
-------
Ready2
end

function MenuKata()
    StayBelle = scriptConfig("StayKata", "StayKata")
 -----------------------------COMBO-----------------------------------
		 StayBelle:addSubMenu("Combo Settings", "comboset")
     StayBelle.comboset:addParam("useq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 StayBelle.comboset:addParam("usew", "Use W", SCRIPT_PARAM_ONOFF, true)
		 StayBelle.comboset:addParam("usee", "Use E", SCRIPT_PARAM_ONOFF, true)
		 StayBelle.comboset:addParam("user", "Use R", SCRIPT_PARAM_ONOFF, true)
     SxOrb:RegisterHotKey("Fight", StayBelle, "staycombo") 

-------------------------------Farm--------------------------------------
      StayBelle:addSubMenu("Farm", "staykatafarm")
      StayBelle.staykatafarm:addParam("farmkey", "Farm Key", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("Z"))

-------------------------------------------KS--------------------------------------------
      StayBelle:addSubMenu("AutoKS", "autokss")
      StayBelle.autokss:addParam("onoffks", "AutoKS", SCRIPT_PARAM_ONOFF, true)
		 --------------------------------Harass-------------------------------------------
		 StayBelle:addSubMenu("Harass", "harass")
		 StayBelle.harass:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		 StayBelle.harass:addParam("harassQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 --------------------------Circle-------------------------------------------------
		 StayBelle:addSubMenu("Circle", "circle")
     StayBelle.circle:addParam("circleq", "Draw Q Circle", SCRIPT_PARAM_ONOFF, true)
		 StayBelle.circle:addParam("circlew", "Draw W Circle", SCRIPT_PARAM_ONOFF, true)
		 StayBelle.circle:addParam("circlee", "Draw E Circle", SCRIPT_PARAM_ONOFF, true)
		 ---------------------------------------------------------------------------------
		 StayBelle:addSubMenu("OrbWalking", "orbWalking")
		 SxOrb:LoadToMenu(StayBelle.orbWalking, true)
		 StayBelle:addParam("staycombo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		 
		 ts = TargetSelector(TARGET_LESS_CAST, ERANGE, DAMAGE_MAGIC)
         enemyMinions = minionManager(MINION_ENEMY, ERANGE, player)
        ts.name = Katarina
		StayBelle:addTS(ts)
							
end

function Combo()

	local target = ts.target

	if not target then return end

	if ValidTarget(target) then
			if QREADY and GetDistance(target) < QRANGE  and UseQ and ComboKey then
			CastSpell(_Q, target)
		end
	end
		
		if EREADY and WREADY and GetDistance(target) < ERANGE  and UseE and ComboKey then
			CastSpell(_E, target.x, target.z)
		end

		if WREADY and GetDistance(target) < WRANGE  and UseW and ComboKey then
			CastSpell(_W)
		end

		if RREADY and not QREADY and not WREADY and not EREADY and GetDistance(target) < RRANGE  and UseR and ComboKey then
	 		CastSpell(_R)
	 		ulti = true
		end
		
end

function CoolDown()

QREADY = myHero:CanUseSpell(_Q) == READY
WREADY = myHero:CanUseSpell(_W) == READY
EREADY = myHero:CanUseSpell(_E) == READY
RREADY = myHero:CanUseSpell(_R) == READY
end

function Harass()

	local target = ts.target

	if not target then return end

	if ValidTarget(target) then
if QREADY and GetDistance(target) < QRANGE  and Configzedex.harass.harass then
			CastSpell(_Q, target.x, target.z)
	    end
	  end
	end
		
function OnDraw()
     if (StayBelle.circle.circleq) then
          DrawCircle(myHero.x, myHero.y, myHero.z, QRANGE, 0xFF00FF)
     end
		 if (StayBelle.circle.circlew) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, WRANGE, 0xFF00FF)
	 end
	 
		 if (StayBelle.circle.circlee) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, ERANGE, 0xFF00FF)
  end
end

function Farm()
		enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
			if FarmKey then
				if ValidTarget(minion) and minion.health < 50 then
					CastSpell(_Q, minion)
				end
			end
		end
end

function OnAnimation(unit, animationName)
       if unit == myHero then
   if animationName == "Spell4" then
    ulti = true
  else
    ulti = false
  end
 end
end

function AutoKS()
     if AutoKSON and ts.target ~= nil then
   for _, enemy in pairs(enemyHeroes) do
    if not enemy.dead and GetDistance(enemy) < 700 and qweDMG(enemy) > enemy.health then
   if Ready(_Q) and GetDistance(enemy) < 675 then 
       CastSpell(_Q, enemy) 
       end
  if Ready(_E) then 
      CastSpell(_E, enemy)
      end
 if Ready(_W) and GetDistance(enemy) < 375 then
     CastSpell(_W, enemy)
     end
 
   end
  end
  end
end

  function qweDMG(enemy)
  local distanceenemy = GetDistance(enemy)
local qdamage = getDmg("Q",enemy,myHero)
local qdamage2 = getDmg("Q",enemy,myHero,2)
local wdamage = getDmg("W",enemy,myHero)
local edamage = getDmg("E",enemy,myHero)
local combo5 = 0
if Ready(_Q) then
combo5 = combo5 + qdamage
if Ready(_E) then
combo5 = combo5 + qdamage2
end
end
if Ready(_W) then
combo5 = combo5 + wdamage
end
if Ready(_E) then
combo5 = combo5 + edamage
end
return combo5
end

function Ready2(spell)
	if spell ~= nil then 
		return myHero:CanUseSpell(spell) == READY 
	else
		return false
	end
end

-- AutoUpdater
local version = "KataXSerieS"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "ZedeX"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/ZedeXFIX.lua"
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

local ServerData
if autoupdateenabled then
	GetAsyncWebResult(UPDATE_HOST, UPDATE_PATH, function(d) ServerData = d end)
	function update()
		if ServerData ~= nil then
			local ServerVersion
			local send, tmp, sstart = nil, string.find(ServerData, "local version = \"")
			if sstart then
				send, tmp = string.find(ServerData, "\"", sstart+1)
			end
			if send then
				ServerVersion = tonumber(string.sub(ServerData, sstart+1, send-1))
			end

			if ServerVersion ~= nil and tonumber(ServerVersion) ~= nil and tonumber(ServerVersion) > tonumber(version) then
				DownloadFile(UPDATE_URL.."?nocache"..myHero.charName..os.clock(), UPDATE_FILE_PATH, function () print("<font color=\"#FF0000\"><b>"..UPDATE_SCRIPT_NAME..":</b> successfully updated. Reload (double F9) Please. ("..version.." => "..ServerVersion..")</font>") end)     
			elseif ServerVersion then
				print("<font color=\"#FF0000\"><b>"..UPDATE_SCRIPT_NAME..":</b> You have got the latest version: <u><b>"..ServerVersion.."</b></u></font>")
			end		
			ServerData = nil
		end
	end
	AddTickCallback(update)
end


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



--[[Slay Belle Katarina]]--



if myHero.charName ~= "Katarina" then return end


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
		
		if EREADY and WREADY and GetDistance(target) < ERANGE  and Configzedex.comboset.zedexw and Configzedex.combozedex then
			CastSpell(_E, target.x, target.z)
		end

		if WREADY and GetDistance(target) < WRANGE  and Configzedex.combozedex then
			CastSpell(_Q, target.x, target.z)
		end

		if EREADY and GetDistance(target) < 290  and Configzedex.combozedex then
	 		CastSpell(_E)
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
     if (Configzedex.circle.circleq) then
          DrawCircle(myHero.x, myHero.y, myHero.z, QRANGE, 0xFF00FF)
     end
		 if (Configzedex.circle.circlew) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, WRANGE, 0xFF00FF)
	 end
	 
		 if (Configzedex.circle.circlee) then
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
	
	--[[Minion Collsion]]--		
		function minionCollision(target, range)
        for _, minionObjectE in pairs(enemyMinions.objects) do
                if target ~= nil and player:GetDistance(minionObjectE) < range then
                        ex = player.x
                        ez = player.z
                        tx = target.x
                        tz = target.z
                        dx = ex - tx
                        dz = ez - tz
                        if dx ~= 0 then
                                m = dz/dx
                                c = ez - m*ex
                        end
                        mx = minionObjectE.x
                        mz = minionObjectE.z
                        distanc = (math.abs(mz - m*mx - c))/(math.sqrt(m*m+1))
                        if math.sqrt((tx - ex)*(tx - ex) + (tz - ez)*(tz - ez)) > math.sqrt((tx - mx)*(tx - mx) + (tz - mz)*(tz - mz)) then
                                return true
                        end
                end
        end
        return false
end

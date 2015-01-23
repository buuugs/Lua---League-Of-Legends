-- AutoUpdater
local version = "Beta"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "AhriX"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/AhriX.lua"
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
require "Collision"


--[[ahrix By Ajgoreq]]--



if myHero.charName ~= "Ahri" then return end

local QREADY

local WREADY

local EREADY

local RREADY

local QRANGE = 880+50

local WRANGE = 800

local ERANGE = 975

local RRANGE = 450+QRANGE


function OnLoad()
Menu()
                print("<b><font color=\"#6699FF\">AhriX By Ajgoreq : Loaded</font>")
		print("<b><font color=\"#6699FF\">--------------------------------</font>")
		print("<b><font color=\"#6699FF\">-----AhriX: Good Luck-----</font>")
		
   ts = TargetSelector(TARGET_LOW_HP,RRANGE,DAMAGE_MAGIC)
end

function OnTick()
CastSpells()
ts:update()
Ready()
Harass()
enemyMinions:update()
end

function OnDraw()
     if (Configahrix.circle.circleq) then
          DrawCircle(myHero.x, myHero.y, myHero.z, QRANGE, 0xFF00FF)
     end
		 if (Configahrix.circle.circlew) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, WRANGE, 0xFF00FF)
		 end
		 if (Configahrix.circle.circlee) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, ERANGE, 0xFF00FF)
end
end

function Menu()
 Configahrix = scriptConfig("AhriX", "AhriX")
 -----------------------------COMBO-----------------------------------
		 Configahrix:addSubMenu("Combo Settings", "comboset")
                 Configahrix.comboset:addParam("ahrixq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 Configahrix.comboset:addParam("ahrixw", "Use W", SCRIPT_PARAM_ONOFF, true)
		 Configahrix.comboset:addParam("ahrixe", "Use E", SCRIPT_PARAM_ONOFF, true)
		 Configahrix.comboset:addParam("ahrixr", "Use R", SCRIPT_PARAM_ONOFF, true)
	SxOrb:RegisterHotKey("Fight", Configahrix, "comboahrix") 

		 --------------------------------Harass-------------------------------------------
		 Configahrix:addSubMenu("Harass", "harass")
		 Configahrix.harass:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		 Configahrix.harass:addParam("harassQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 --------------------------Circle-------------------------------------------------
		 Configahrix:addSubMenu("Circle", "circle")
     Configahrix.circle:addParam("circleq", "Draw Q Circle", SCRIPT_PARAM_ONOFF, true)
		 Configahrix.circle:addParam("circlew", "Draw W Circle", SCRIPT_PARAM_ONOFF, true)
		 Configahrix.circle:addParam("circlee", "Draw E Circle", SCRIPT_PARAM_ONOFF, true)
		 ---------------------------------------------------------------------------------
		 Configahrix:addSubMenu("OrbWalking", "orbWalking")
		 SxOrb:LoadToMenu(Configahrix.orbWalking, true)
		 Configahrix:addParam("comboahrix", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		 
		 ts = TargetSelector(TARGET_LOW_HP,900+100,DAMAGE_PHYSICAL)
                 enemyMinions = minionManager(MINION_ENEMY, ERANGE, player)
                ts.name = Ahri
		Configahrix:addTS(ts)
							
end

function CastSpells()

ts:update()
	
	local target = ts.target

	if not target then return end

	if ValidTarget(target) then
			if RREADY and GetDistance(target) < RRANGE  and Configahrix.comboset.ahrixr and Configahrix.comboahrix then
			CastSpell(_R, target.x, target.z)
		end
	end
		
		if WREADY and GetDistance(target) < WRANGE  and Configahrix.comboset.ahrixw and Configahrix.comboahrix then
			CastSpell(_W)
		end

		if QREADY and GetDistance(target) < QRANGE  and Configahrix.comboset.ahrixq and Configahrix.comboahrix then
			CastSpell(_Q, target.x, target.z)
		end

		if EREADY and GetDistance(target) < ERANGE  and Configahrix.comboset.ahrixe and Configahrix.comboahrix and not minionCollision(target, ERANGE) then
	 		CastSpell(_E, target.x, target.z)
		end
		
end

function Ready()

QREADY = myHero:CanUseSpell(_Q) == READY
WREADY = myHero:CanUseSpell(_W) == READY
EREADY = myHero:CanUseSpell(_E) == READY
RREADY = myHero:CanUseSpell(_R) == READY
end

function Harass()

ts:update()
	
	local target = ts.target

	if not target then return end

	if ValidTarget(target) then
if QREADY and GetDistance(target) < QRANGE  and Configahrix.harass.harass then
			CastSpell(_Q, target.x, target.z)
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

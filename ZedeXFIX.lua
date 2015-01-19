-- AutoUpdater
local version = "0.01"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "ZedeX"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/ZedeX.lua"
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



--[[ZedeX By Ajgoreq]]--



if myHero.charName ~= "Zed" then return end


local Ulti

local QREADY

local WREADY

local EREADY

local RREADY

local wClone = nil

local rClone = nil

local QRANGE = 900+100

local WRANGE = 550

local ERANGE = 290

local RRANGE = 550


function OnLoad()
Menu()
    print("<b><font color=\"#6699FF\">ZedeX By Ajgoreq : Loaded</font>")
		print("<b><font color=\"#6699FF\">--------------------------------</font>")
		print("<b><font color=\"#6699FF\">-----Zedex: Good Luck-----</font>")
		
   ts = TargetSelector(TARGET_LOW_HP,900+100,DAMAGE_PHYSICAL)
end

function OnTick()
CastSpells()
ts:update()
Ready()
Harass()
end

function OnDraw()
     if (Configzedex.circle.circleq) then
          DrawCircle(myHero.x, myHero.y, myHero.z, 900, 0xFF00FF)
     end
		 if (Configzedex.circle.circlew) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, 550, 0xFF00FF)
		 end
		 if (Configzedex.circle.circlee) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, 290, 0xFF00FF)
end
end

function Menu()
 Configzedex = scriptConfig("ZedeX", "ZedeX")
 -----------------------------COMBO-----------------------------------
		 Configzedex:addSubMenu("Combo Settings", "comboset")
     Configzedex.comboset:addParam("zedezq", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 Configzedex.comboset:addParam("zedexw", "Use W", SCRIPT_PARAM_ONOFF, true)
		 Configzedex.comboset:addParam("zedexe", "Use E", SCRIPT_PARAM_ONOFF, true)
		 Configzedex.comboset:addParam("zedexr", "Use R", SCRIPT_PARAM_ONOFF, true)
	SxOrb:RegisterHotKey("Fight", Configzedex, "combozedex") 

		 --------------------------------Harass-------------------------------------------
		 Configzedex:addSubMenu("Harass", "harass")
		 Configzedex.harass:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		 Configzedex.harass:addParam("harassQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
		 --------------------------Circle-------------------------------------------------
		 Configzedex:addSubMenu("Circle", "circle")
     Configzedex.circle:addParam("circleq", "Draw Q Circle", SCRIPT_PARAM_ONOFF, true)
		 Configzedex.circle:addParam("circlew", "Draw W Circle", SCRIPT_PARAM_ONOFF, true)
		 Configzedex.circle:addParam("circlee", "Draw E Circle", SCRIPT_PARAM_ONOFF, true)
		 ---------------------------------------------------------------------------------
		 Configzedex:addSubMenu("OrbWalking", "orbWalking")
		 SxOrb:LoadToMenu(Configzedex.orbWalking, true)
		 Configzedex:addParam("combozedex", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		 
		 ts = TargetSelector(TARGET_LOW_HP,900+100,DAMAGE_PHYSICAL)
                ts.name = Zed
								Configzedex:addTS(ts)
							
end

function CastSpells()

ts:update()
	
	local target = ts.target

	if not target then return end

	if ValidTarget(target) then
			if RREADY and GetDistance(target) < RRANGE  and Configzedex.comboset.zedexr and Configzedex.combozedex then
			CastSpell(_R, target)
		end
	end
		
		if WREADY and GetDistance(target) < WRANGE  and Configzedex.comboset.zedexw and Configzedex.combozedex then
			CastSpell(_W, target.x, target.z)
		end

		if QREADY and GetDistance(target) < QRANGE  and Configzedex.combozedex then
			CastSpell(_Q, target.x, target.z)
		end

		if EREADY and GetDistance(target) < 290  and Configzedex.combozedex then
	 		CastSpell(_E)
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
if QREADY and GetDistance(target) < QRANGE  and Configzedex.harass.harass then
			CastSpell(_Q, target.x, target.z)
		    end
		  end
		end

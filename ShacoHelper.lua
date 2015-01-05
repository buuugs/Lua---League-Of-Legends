local version = "0.01"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "ShacoHelper"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/ShacoHelper.lua"
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

if myHero.charName ~= "Shaco" then return end

function OnLoad()
Menu()
    print("<b><font color=\"#6699FF\">Shaco-Helper By Ajgoreq : Loaded</font>")
		print("<b><font color=\"#6699FF\">--------------------------------</font>")
		print("<b><font color=\"#6699FF\">-----ShacoHelper: Good Luck-----</font>")
   ts = TargetSelector(TARGET_LOW_HP_PRIORITY,625)
end

function OnTick()
CastSpells()
end

function OnDraw()
     if (ConfigShac.circle.circleq) then
          DrawCircle(myHero.x, myHero.y, myHero.z, 400, 0xFF00FF)
     end
		 if (ConfigShac.circle.circlew) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, 425, 0xFF00FF)
		 end
		 if (ConfigShac.circle.circlee) then
		 DrawCircle(myHero.x, myHero.y, myHero.z, 625, 0xFF00FF)
end
end

function Menu()
 ConfigShac = scriptConfig("Shaco Helper", "ShacoHelp")
		 ConfigShac:addSubMenu("Keys", "keys")
     ConfigShac.keys:addParam("shacoe", "Cast E", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		 ConfigShac.keys:addParam("shacow", "Cast W", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		 ConfigShac.keys:addParam("shacoq", "Invisibility", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("Z"))
		 ConfigShac:addSubMenu("Circle", "circle")
     ConfigShac.circle:addParam("circleq", "Draw Q Circle", SCRIPT_PARAM_ONOFF, true)
		 ConfigShac.circle:addParam("circlew", "Draw W Circle", SCRIPT_PARAM_ONOFF, true)
		 ConfigShac.circle:addParam("circlee", "Draw E Circle", SCRIPT_PARAM_ONOFF, true)
		 
end

function CastSpells()
	if ConfigShac.keys.shacoe and myHero:CanUseSpell(_E) == READY then
		ts:update()
		if ts.target then
			CastSpell(_E, ts.target)
		end
	end
	if ConfigShac.keys.shacoq and myHero:CanUseSpell(_Q) == READY then
		CastSpell(_Q, mousePos.x, mousePos.z)
	end
	if ConfigShac.keys.shacow and myHero:CanUseSpell(_W) == READY then
		CastSpell(_W, mousePos.x, mousePos.z)
	end
end

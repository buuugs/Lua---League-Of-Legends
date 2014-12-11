local version = "0.03"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "PotionActivator"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/PotionActivator.lua"
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

local hpPot   = function() return GetInventorySlotItem(2003) end
local manaPot = function() return GetInventorySlotItem(2004) end

function OnTick()
	if (myHero:CanUseSpell(hpPot()) == READY) and myHero.health < 200 then
		CastSpell(hpPot)
	end

	if (myHero:CanUseSpell(manaPot()) == READY) and myHero.mana < 200 then
		CastSpell(manaPot)
	end
end

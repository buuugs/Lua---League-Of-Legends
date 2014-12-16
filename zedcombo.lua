local version = "0.01"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "ZedCombo"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/zedcombo.lua"
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

if myHero.charName ~= "Zed" then return end

function OnLoad()
     ts = TargetSelector(TARGET_LOW_HP_PRIORITY,625)
     Config = scriptConfig("Zed By Ajgoreq Beta", "zedajgoreq")
     Config:addParam("combozed", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
     Config:addParam("usespellrzed", "Use R to combo", SCRIPT_PARAM_ONOFF, true)
     Config:addParam("circlezed", "Draw Circle", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("M"))
end


function OnTick()
     ts:update()
     if (ts.target ~= nil) then
          if (Config.combozed) then
               if (myHero:CanUseSpell(_R) == READY) then
                    if (Config.usespellrzed) then
                         CastSpell(_R, ts.target)
                    end
										end
										end
										end
					if (myHero:CanUseSpell(_W) == READY) then
                    CastSpell(_W, ts.target)
               end
               if (myHero:CanUseSpell(_Q) == READY) then
                    CastSpell(_Q, ts.target)
               end
               if (myHero:CanUseSpell(_E) == READY) then
                    CastSpell(_E, ts.target)
               end
			   
               end
function OnDraw()
     if (Config.circlezed) then
          DrawCircle(myHero.x, myHero.y, myHero.z, 900, 0xFF00FF)
		  DrawCircle(myHero.x, myHero.y, myHero.z, 550, 0xFF00FF)
		  DrawCircle(myHero.x, myHero.y, myHero.z, 290, 0xFF00FF)
		  DrawCircle(myHero.x, myHero.y, myHero.z, 625, 0xFF00FF)
end
end

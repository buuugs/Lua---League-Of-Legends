local version = "9.0"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "SlayBelleKatarina"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/SlayBelleKatarina.lua"
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
["SxOrbWalk"] = "https://raw.github.com/Superx321/BoL/master/common/SxOrbWalk.lua"
}
local DOWNLOADING_LIBS, DOWNLOAD_COUNT = false, 0

function AfterDownload()
DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
if DOWNLOAD_COUNT == 0 then
DOWNLOADING_LIBS = false
print(" Required libraries downloaded successfully, please reload (double F9).")
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

if myHero.charName ~= "Katarina" then return end

local e = {}
--ScripttStatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("WJMLQIIKJLL") 
--
AnimTrack = 0
lastE = 0
eDelay = 3500 -- 3,5 seconds



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
 

IgniteSet()
Variables()

AddMsgCallback(CustomOnWndMsg)
	AddDrawCallback(CustomOnDraw)		
	AddProcessSpellCallback(CustomOnProcessSpell)
	AddTickCallback(CustomOnTick)
	
for i, enemy in ipairs(GetEnemyHeroes()) do
		table.insert(e, enemy)
	end
end

function StayBelle()


Config = scriptConfig("Katarina - SlayBelle By Igoreeeku", "SlayBelle")

Config:addSubMenu("Key Settings", "Keys")
Config.Keys:addParam("combokey", "Combo key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
Config.Keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, 67)
Config.Keys:addParam("farmkey", "Farm On/Off", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("Z"))

Config:addSubMenu("Combo Settings", "Combo")
Config.Combo:addParam("UseQ", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.Combo:addParam("UseW", "Use W", SCRIPT_PARAM_ONOFF, true) 
Config.Combo:addParam("UseE", "Use E", SCRIPT_PARAM_ONOFF, true) 
Config.Combo:addParam("UseR", "Use R", SCRIPT_PARAM_ONOFF, true)
Config.Combo:addParam("UseEDel", "Humanizer", SCRIPT_PARAM_ONOFF, true)

Config:addSubMenu("Misc", "Misc")
Config.Misc:addParam("KSQ", "Auto KS with Q", SCRIPT_PARAM_ONOFF, true)
Config.Misc:addParam("KSW", "Auto KS with W", SCRIPT_PARAM_ONOFF, true)
Config.Misc:addParam("KSE", "Auto KS with E", SCRIPT_PARAM_ONOFF, true)
Config.Misc:addParam("KSIG", "Auto KS using ignite", SCRIPT_PARAM_ONOFF, true)
if VIP_USER then
Config:addSubMenu("Packets", "Packets")
Config.Packets:addParam("QPACK", "Q Packets", SCRIPT_PARAM_ONOFF, false)
Config.Packets:addParam("WPACK", "W Packets", SCRIPT_PARAM_ONOFF, false)
Config.Packets:addParam("EPACK", "E Packets", SCRIPT_PARAM_ONOFF, false)
end
Config:addSubMenu("Drawings", "Draw")
Config.Draw:addParam("drawDD", "Draw Dmg Text", SCRIPT_PARAM_ONOFF, true)
Config.Draw:addParam("DrawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
Config.Draw:addParam("DrawW", "Draw W range", SCRIPT_PARAM_ONOFF, true)
Config.Draw:addParam("DrawE", "Draw E range", SCRIPT_PARAM_ONOFF, true)

Config:addSubMenu("Farm", "farm")
Config.farm:addParam("UseQFarm", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.farm:addParam("UseWFarm", "Use W", SCRIPT_PARAM_ONOFF, false)

Config:addSubMenu("Credits", "Credits")

Config.Credits:addParam("info", " >> Autor : ", SCRIPT_PARAM_INFO, "Igoreeeku")
Config.Credits:addParam("info8", " >> Tester : ", SCRIPT_PARAM_INFO, "Venemo")


Config:addParam("info4", " >> Version ", SCRIPT_PARAM_INFO, "8.0")


ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, Erange)
enemyMinions = minionManager(MINION_ENEMY, Qrange, myHero, MINION_SORT_MAXHEALTH_DEC)
ts.name = "Belle"
Config:addSubMenu("Target Selector", "TS")
Config.TS:addTS(ts)

Config:addSubMenu("Orbwalker", "SxOrb")
SxOrb:LoadToMenu(Config.SxOrb)

	Config.Keys:permaShow("combokey")
  Config.Keys:permaShow("harass")
	Config.Keys:permaShow("farmkey")

end

function OnTick()

Checks()
IgniteKS()
Human()
KillSteal()

killstring = {}
	-----Combo-----
	if Config.Keys.combokey then
	ts:update()
	Combo()
	end
	----Harass-----
	if Config.Keys.harass then
	Harass()
	end
	---Farm-----
	if Config.Keys.farmkey then
	Farm()
	end

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


function Variables()

allyHeroes = GetAllyHeroes()
enemyHeroes = GetEnemyHeroes()
enemyMinions = minionManager(MINION_ENEMY, Erange, player, MINION_SORT_HEALTH_ASC)
allyMinions = minionManager(MINION_ALLY, Erange, player, MINION_SORT_HEALTH_ASC)

killstring = {}
end

function Checks()

target = ts.target 
SxOrb:ForceTarget(target)
allyMinions:update()

QREADY = (myHero:CanUseSpell(_Q) == READY)
WREADY = (myHero:CanUseSpell(_W) == READY) 
EREADY = (myHero:CanUseSpell(_E) == READY)
RREADY = (myHero:CanUseSpell(_R) == READY)
IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY) 
end

function Combo()

	if ValidTarget(target) then
	
CastQ()
CastE()
CastW()
CastR()
	end
end

function CastQ()
				if QREADY and Config.Combo.UseQ then 
		if GetDistance(target) <= Qrange then
	if VIP_USER and Config.Packets.QPACK then
	Packet("S_CAST", {spellId = _Q, targetNetworkId = target.networkID}):send()
	else
	CastSpell(_Q, target) 
			end
		end
	end
end

function CastW()
	if WREADY and Config.Combo.UseW then
	if GetDistance(target) <= Wrange then
	if VIP_USER and Config.Packets.WPACK then
	Packet("S_CAST", {spellId = _W, targetNetworkId = target.networkID}):send()
	else
		CastSpell(_W)
			end
		end
	end
end
function CastE()
			if EREADY and Config.Combo.UseE then
		if GetDistance(target) <= Erange then 
	if VIP_USER and Config.Packets.EPACK then
	Packet("S_CAST", {spellId = _E, targetNetworkId = target.networkID}):send()
	else
	CastSpell(_E, target)
			end
		end
	end
end

function CastR()
		if RREADY and not QREADY and not WREADY and not EREADY and Config.Combo.UseR then
	if GetDistance(target) <= Rrange then
	CastSpell(_R)
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



function IgniteKS()
if ValidTarget(target) then
if not RREADY then
if Config.Misc.KSIG then
AutoIgnite(target)
		end
	end
end
end

function KillSteal()
	for i, enemy in ipairs(e) do
	if not RREADY then 
		if ValidTarget(enemy) and GetDistance(enemy) < 700 then
		if Config.Misc.KSQ then
			if QReady and getDmg("Q", enemy, myHero) > enemy.health then
				CastSpell(_Q, enemy)
				end
			end
			if Config.Misc.KSW then
			if WReady and getDmg("W", enemy, myHero) > enemy.health then
				CastSpell(_W)
				end
			end
				if Config.Misc.KSE then
			if EReady and getDmg("E", enemy, myHero) > enemy.health then
				CastSpell(_E, enemy)
				end
			end
		end
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

function Harass()

if not target then return end

if ValidTarget(target) then
if QREADY and GetDistance(target) < Qrange then
CastSpell(_Q, target)
		end
	end
end

function Farm()
enemyMinions:update()
		for i, minion in ipairs(enemyMinions.objects) do
	if Config.farm.UseQFarm then
	if ValidTarget(minion) and GetDistance(minion) <= Qrange and QREADY and getDmg("Q", minion, myHero) > minion.health then
CastSpell(_Q, minion)
			end
		end
	end
	
	for i, minion in ipairs(enemyMinions.objects) do
if Config.farm.UseWFarm then
if ValidTarget(minion) and GetDistance(minion) <= Wrange and WREADY and getDmg("W", minion, myHero) > minion.health then
CastSpell(_W)
			end
		end
	end
end



function getHitBoxRadius(target)
return GetDistance(target.minBBox, target.maxBBox)/2
end


function Human()

if lastE + eDelay > GetTickCount() then
lastE = GetTickCount()
Combo()
	end
end

function DmgCalc()
	for i=1, heroManager.iCount do
		local enemy = heroManager:GetHero(i)
			if enemy ~= nil and ValidTarget(enemy) then
			local hp = enemy.health
			local iDmg = (50 + (20 * myHero.level))
			local qDmg = getDmg("Q", enemy, myHero)
			local eDmg = getDmg("E", enemy, myHero)
			local rDmg = getDmg("R", enemy, myHero)
			if hp > (qDmg+eDmg+iDmg) then
				killstring[enemy.networkID] = "Harass Him!!!"
			elseif hp < qDmg then
				killstring[enemy.networkID] = "Q Kill!"
			elseif hp < eDmg then
				killstring[enemy.networkID] = "E Kill!"
			elseif hp < rDmg then
				killstring[enemy.networkID] = "R Kill!"
            elseif hp < (iDmg) then
                killstring[enemy.networkID] = "Ignite Kill!"
			elseif hp < (qDmg+iDmg) then
				killstring[enemy.networkID] = "Q+Ignite Kill!"
			elseif hp < (eDmg+iDmg) then
				killstring[enemy.networkID] = "E+Ignite Kill!"
			elseif hp < (rDmg+iDmg) then
				killstring[enemy.networkID] = "R+Ignite Kill!"
			elseif hp < (qDmg+eDmg) then
                killstring[enemy.networkID] = "Q+E Kill!"
			elseif hp < (qDmg+rDmg) then
				killstring[enemy.networkID] = "Q+R Kill!"
			elseif hp < (eDmg+rDmg) then
				killstring[enemy.networkID] = "E+R Kill!"
			elseif hp < (qDmg+eDmg+rDmg) then
				killstring[enemy.networkID] = "Q+E+R Kill!"
			elseif hp < (qDmg+eDmg+iDmg) then
                killstring[enemy.networkID] = "Q+E+Ignite Kill!"
			elseif hp < (qDmg+eDmg+rDmg+iDmg) then
				killstring[enemy.networkID] = "Q+E+R+Ignite Kill!"
			end
		end
	end
end

function CustomOnDraw()
		if Config.Draw.drawDD then
			DmgCalc()
			for _, enemy in ipairs(GetEnemyHeroes()) do
				if ValidTarget(enemy, 100000) and killstring[enemy.networkID] ~= nil then
					local pos = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
					DrawText(killstring[enemy.networkID], 20, pos.x - 35, pos.y - 40, 0xFFFFFF00)
				end
			end
		end
	end

-- Lib Updater
local REQUIRED_LIBS = {
["SxOrbWalk"] = "https://raw.githubus...n/SxOrbWalk.lua"
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
--ScriptStatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("SFIGGMFKFEF") 
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

--[[ Ward Jump ]]--
local WardTable = {}
local SWard, VWard, SStone, RSStone, Wriggles = 3040, 2043, 2049, 2045, 3154
local SWardSlot, VWardSlot, SStoneSlot, RSStoneSlot, WrigglesSlot = nil, nil, nil, nil, nil
local jumpReady = false
local jumpRange = 700
local wardRange = 600
local jumpDelay = 0

function OnLoad()

StayBelle()
 print("<b><font color=\"#FF001E\">>>>..::Slay Belle Katarina::..<<<<</font></b>")
IgniteSet()
Variables()
for i, enemy in ipairs(GetEnemyHeroes()) do
		table.insert(e, enemy)
	end

for i = 0, objManager.maxObjects, 1 do
local object = objManager:GetObject(i)
if WardCheck(object) then table.insert(WardTable, object) end
end 
end

function StayBelle()


Config = scriptConfig("Katarina - SlayBelle Rework By Ajgoreq", "SlayBelle")

Config:addSubMenu("Key Settings", "Keys")
Config.Keys:addParam("combokey", "Combo key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
Config.Keys:addParam("harass", "Harass Key", SCRIPT_PARAM_ONKEYDOWN, false, 67)
Config.Keys:addParam("farmkey", "Farm On/Off", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("Z"))
Config.Keys:addParam("wardjump", "Ward Jump", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("G"))

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
Config.Packets:addParam("QPACK", "Q Packest", SCRIPT_PARAM_ONOFF, false)
Config.Packets:addParam("EPACK", "E Packest", SCRIPT_PARAM_ONOFF, false)
end
Config:addSubMenu("Drawings", "Draw")
Config.Draw:addParam("DrawQ", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
Config.Draw:addParam("DrawW", "Draw W range", SCRIPT_PARAM_ONOFF, true)
Config.Draw:addParam("DrawE", "Draw E range", SCRIPT_PARAM_ONOFF, true)

Config:addSubMenu("Farm", "farm")
Config.farm:addParam("UseQFarm", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.farm:addParam("UseWFarm", "Use W", SCRIPT_PARAM_ONOFF, false)

Config:addSubMenu("Credits", "Credits")
Config.Credits:addParam("info", " >> Autor : ", SCRIPT_PARAM_INFO, "Ajgoreq")

Config:addParam("info4", " >> Version ", SCRIPT_PARAM_INFO, "7.8")


ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, Erange)
enemyMinions = minionManager(MINION_ENEMY, Qrange, myHero, MINION_SORT_MAXHEALTH_DEC)
ts.name = "Belle"
Config:addSubMenu("Target Selector", "TS")
Config.TS:addTS(ts)

Config:addSubMenu("Orbwalker", "SxOrb")
SxOrb:LoadToMenu(Config.SxOrb)

end

function OnTick()
Checks()
IgniteKS()
Human()
Jump()
--[[ Ward Jump ]]--
--[[ if jumpReady == true then
JumpReady()
end]]
if Config.Keys.wardjump then
if GetTickCount() >= SkillWard.lastJump then
JumpCheck()
end
moveToCursor()
local WardPos = GetDistanceSqr(mousePos) <= Erange * Erange and mousePos or getMousePos()
wardJump(WardPos.x, WardPos.z)

	end
	-----Combo-----
	if Config.Keys.combokey then
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


function moveToCursor()
if GetDistance(mousePos) then
local moveToPos = myHero + (Vector(mousePos) - myHero):normalized()*300
myHero:MoveTo(moveToPos.x, moveToPos.z)
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
Wards = {}
allyHeroes = GetAllyHeroes()
enemyHeroes = GetEnemyHeroes()
enemyMinions = minionManager(MINION_ENEMY, Erange, player, MINION_SORT_HEALTH_ASC)
allyMinions = minionManager(MINION_ALLY, Erange, player, MINION_SORT_HEALTH_ASC)

SkillWard = {range = 600, lastJump = 0, itemSlot = nil }
JungleMobs = {}
end

function Checks()
ts:update()
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
		CastSpell(_W)
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
if Config.Misc.KSIG then
AutoIgnite(target)
		end
	end
end

function KillSteal()
	for i, enemy in ipairs(e) do
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
------------------------------------Ward Jump-------------------------------------------
--[[ Ward Jump ]]--
function WardCheck(object)
return object and object.valid and (string.find(object.name, "Ward") ~= nil or string.find(object.name, "Wriggle") ~= nil)
end

--[[function JumpReady()
if jumpReady == true then
for i,object in ipairs(WardTable) do
if object ~= nil and object.valid and math.sqrt((object.x-mousePos.x)^2+(object.z-mousePos.z)^2) < 150 then
CastSpell(_E, object)
jumpReady = false
end
end
end]]

function wardJump(x, y)
--->
if EREADY then
local Jumped = false
local WardDistance = 300
for _, ally in pairs(allyHeroes) do
if ValidTarget(ally, Erange, false) and ally ~= nil then
if GetDistanceSqr(ally, mousePos) <= WardDistance*WardDistance then
CastSpell(_E, ally)
Jumped = true
SkillWard.lastJump = GetTickCount() + 2000
end
end
end
for _, minion in pairs(allyMinions.objects) do
if ValidTarget(minion, Erange, false) and minion ~= nil then
if GetDistanceSqr(minion, mousePos) <= WardDistance*WardDistance then
CastSpell(_E, minion)
Jumped = true
SkillWard.lastJump = GetTickCount() + 2000
end
end
end
for _, minion in pairs(enemyMinions.objects) do
if ValidTarget(minion, Erange, false) and minion ~= nil then
if GetDistanceSqr(minion, mousePos) <= WardDistance*WardDistance then
CastSpell(_E, minion)
Jumped = true
SkillWard.lastJump = GetTickCount() + 2000
end
end
end
if next(Wards) ~= nil then
for i, obj in pairs(Wards) do 
if obj.valid then
MousePos = getMousePos()
if GetDistanceSqr(obj, MousePos) <= WardDistance*WardDistance then
CastSpell(_E, obj)
Jumped = true
SkillWard.lastJump = GetTickCount() + 2000
end
end
end
end

--[[if not Jumped and GetTickCount() >= SkillWard.lastJump then
if Items.TrinketWard.ready then
SkillWard.itemSlot = ITEM_7
elseif Items.RubySightStone.ready then
SkillWard.itemSlot = rstSlot
elseif Items.SightStone.ready then 
SkillWard.itemSlot = ssSlot
elseif Items.SightWard.ready then
SkillWard.itemSlot = swSlot
elseif Items.VisionWard.ready then
SkillWard.itemSlot = vwSlot
end

if SkillWard.itemSlot ~= nil then
CastSpell(SkillWard.itemSlot, x, y)
Jumped = true
SkillWard.lastJump = GetTickCount() + 2000
SkillWard.itemSlot = nil
end
end]]
end
---<
end

function JumpCheck()
local x = mousePos.x
local z = mousePos.z
local dx = x - player.x
local dz = z - player.z
local rad1 = math.atan2(dz, dx)

SWardSlot = GetInventorySlotItem(SWard)
VWardSlot = GetInventorySlotItem(VWard)
SStoneSlot = GetInventorySlotItem(SStone)
RSStoneSlot = GetInventorySlotItem(RSStone)
WrigglesSlot = GetInventorySlotItem(Wriggles)

if RSStoneSlot ~= nil and CanUseSpell(RSStoneSlot) == READY then
wardSlot = RSStoneSlot
elseif SStoneSlot ~= nil and CanUseSpell(SStoneSlot) == READY then
wardSlot = SStoneSlot
elseif SWardSlot ~= nil then
wardSlot = SWardSlot
elseif VWardSlot ~= nil then
wardSlot = VWardSlot
elseif WrigglesSlot ~= nil then
wardSlot = WrigglesSlot

end

if wardSlot ~= nil then
local dx1 = jumpRange*math.cos(rad1)
local dz1 = jumpRange*math.sin(rad1)
local x1 = x - dx1
local z1 = z - dz1
if EREADY and math.sqrt(dx*dx + dz*dz) <= 600 then
CastSpell(wardSlot, mousePos.x, mousePos.z)
SkillWard.lastJump = GetTickCount() + 2000
--wardSlot= nil
		end
	end
end

function OnCreateObj(obj)
if WardCheck(object) then table.insert(WardTable, object) end

if obj.valid and (string.find(obj.name, "Ward") ~= nil or string.find(obj.name, "Wriggle") ~= nil or string.find(obj.name, "Trinket")) then 
Wards[#Wards+1] = obj
end
end
function OnDeleteObj(obj)
for i, ward in pairs(Wards) do
if not ward.valid or (obj.name == ward.name and obj.x == ward.x and obj.z == ward.z) then
table.remove(Wards, i)
end
end
end

function getMousePos(range)
local temprange = range or SkillWard.range
local MyPos = Vector(myHero.x, myHero.y, myHero.z)
local MousePos = Vector(mousePos.x, mousePos.y, mousePos.z)

return MyPos - (MyPos - MousePos):normalized() * SkillWard.range
end
function Jump()
if RSStoneSlot ~= nil and CanUseSpell(RSStoneSlot) == READY then
wardSlot = RSStoneSlot
elseif SStoneSlot ~= nil and CanUseSpell(SStoneSlot) == READY then
wardSlot = SStoneSlot
elseif SWardSlot ~= nil then
wardSlot = SWardSlot
elseif VWardSlot ~= nil then
wardSlot = VWardSlot
elseif WrigglesSlot ~= nil then
wardSlot = WrigglesSlot

end

if wardSlot ~= nil then
if EREADY then
CastSpell(wardSlot, mousePos.x, mousePos.z)
SkillWard.lastJump = GetTickCount() + 2000
--wardSlot= nil
		end
	end
	end

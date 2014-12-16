if myHero.charName ~= 'Zed' then return end

	Spells = 	{
		Q = {key = _Q, name = 'Razor Shuriken',   range = 900, ready = false, data = nil},
		W = {key = _W, name = 'Living Shadow',       range = 550 , ready = false, data = nil},
		E = {key = _E, name = 'Shadow Slash',          range = 290, ready = false, data = nil},
		R = {key = _R, name = 'Death Mark', range = 625, ready = false, data = nil}
						}
	TS = TargetSelector(TARGET_LESS_CAST_PRIORITY, 500, DAMAGE_PHYSICAL, true)
	TS.name = 'Zed'
	
function OnLoad()
     ts = TargetSelector(TARGET_LOW_HP_PRIORITY,625)
     Config = scriptConfig("Zed By Ajgoreq Beta", "zedajgoreq")
     Config:addParam("combozed", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
     Config:addParam("usespellrzed", "Use R to combo", SCRIPT_PARAM_ONOFF, true)
     Config:addParam("circlezed", "Draw Circle", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("M"))
end	
	
function OnTick()

	Target = GetTarget()
	
		for _, spell in pairs(Spells) do
			spell.ready = myHero:CanUseSpell(spell.key) == READY
			spell.data  = myHero:GetSpellData(spell.key)
		end
		
	Combo()
              
end

function Combo()
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy, Spells.R.range) and (myHero:CanUseSpell(_R) == READY) then
      CastSpell(_R, enemy)
    end
		if ValidTarget(enemy, Spells.W.range) and (myHero:CanUseSpell(_W) == READY) then
      CastSpell(_W, enemy)
    end
		if ValidTarget(enemy, Spells.Q.range) and (myHero:CanUseSpell(_Q) == READY) then
     CastSpell(_Q, enemy)
    end
		if ValidTarget(enemy, Spells.E.range) and (myHero:CanUseSpell(_E) == READY) then
      CastSpell(_E, enemy)
    end				
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


function GetTarget()
	TS:update()
		if TS.target ~= nil and not TS.target.dead and TS.target.type  == myHero.type and TS.target.visible then
			return TS.target
		end
end


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

weak_caster_ai = {
	on_attacked = function(mob, attacker, level)
		local flatdam = mob.maxHealth * 0.05
        mob.attacker = attacker.ID
        mob:sendHealth(flatdam, attacker.critChance)
	end,
	move = function(mob, target, level)
		if target ~= nil then
			if mob.m ~= target.m then
				mob.target = 0
			end
		end
		if mob.registry["para_tick"] == 1 and mob.paralyzed == true then
			mob.registry["para_tick"] = mob.registry["para_tick"] + 1
		end
		if(mob.registry["para_tick"] == 5) then
			mob.paralyzed = false
			mob.sendStatus()
		end
		if (os.time() % 2 <= 0 and distanceSquare(mob, target, 20) and mob.paralyzed == false) then
			local pick_spell = math.random(1, 2)
			if (pick_spell == 1) then
				if (mob.target > 0) then
--					mob:talk(0, mob.name .. ": ** summons power **")
					if (level == 0) then
--						vex.cast(mob, target)
					else
--						scourge.cast(mob, target)
					end
				end
			else
				if (mob.target > 0) then
					mob:talk(0, mob.name .. ": ** summons power **")
					if (level == 0) then
						ion.cast(mob, target)
					elseif (level == 1) then
						call_lightning.cast(mob, target)
					else
						thunder_touch_mage.cast(mob, target)
					end
				end
			end
        end
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target, switch)
		if target ~= nil then
			if mob.m ~= target.m then
				mob.target = 0
			end
		end
		mob_ai_basic.attack(mob, target)
	end,

	after_death = function(mob)
		mob.paralyzed = false
		mob.sleep = 1
		mob.state = 1
	end
}



spellsword_ai = {
	move = function(mob, target, level)
		if target ~= nil then
			if mob.m ~= target.m then
				mob.target = 0
			end
		end
		if (os.time() % 2 <= 0 and distanceSquare(mob, target, 20) and mob.paralyzed == false) then
			local pick_spell = math.random(1, 2)
			if (pick_spell == 1) then
				if (mob.target > 0) then
--					mob:talk(0, mob.name .. ": ** summons power **")
					if (level == 0) then
--						vex.cast(mob, target)
					else
--						scourge.cast(mob, target)
					end
				end
			else
				if (mob.target > 0) then
					mob:talk(0, mob.name .. ": DIE, FOOL.")
					if (level == 0) then
						ion.cast(mob, target)
					elseif (level == 1) then
						call_lightning.cast(mob, target)
					else
						thunder_touch_spellsword.cast(mob, target)
					end
				end
			end
        end
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target, switch)
		if target ~= nil then
			if mob.m ~= target.m then
				mob.target = 0
			end
		end
		if (os.time() % 2 <= 0 and distanceSquare(mob, target, 20) and mob.paralyzed == false) then
			local pick_spell = math.random(1, 2)
			if (pick_spell == 1) then
				if (mob.target > 0) then
--					mob:talk(0, mob.name .. ": ** summons power **")
					if (level == 0) then
--						vex.cast(mob, target)
					else
--						scourge.cast(mob, target)
					end
				end
			else
				if (mob.target > 0) then
					mob:talk(0, mob.name .. ": DIE, FOOL.")
					if (level == 0) then
						ion.cast(mob, target)
					elseif (level == 1) then
						call_lightning.cast(mob, target)
					else
						thunder_touch_spellsword.cast(mob, target)
					end
				end
			end
        end
		mob_ai_basic.attack(mob, target)
	end,

	after_death = function(mob, player)
		if(player.registry["sstrial"] == 4) then
			player.registry["sstrialkk"] = player.registry["sstrialkk"] + 1
			player:sendMinitext(""..player.registry["sstrialkk"])
		end
		mob.paralyzed = false
		mob.sleep = 1
		mob.state = 1
	end
}
bard_palace_ai = {

	on_attacked = function(mob, attacker, level)
		local flatdam = mob.maxHealth * 0.05
        mob.attacker = attacker.ID
        mob:sendHealth(flatdam, attacker.critChance)
	end,
	on_spawn = function(mob)
		mob.paralyzed = true
		local randy = math.random(1000,3000)
		mob:setDuration("paralyze_mage",randy)
		mob:sendStatus()
	end,
	on_healed = function(mob, healer)
		if(healer.registry["bardq"] >= 22 and healer.registry["bardq"] < 50) then
			healer.registry["bardq"] = healer.registry["bardq"] + 1
		end
		if(healer.registry["bardq"] == 50) then
			healer.registry["bardq"] = 55
			healer:sendMinitext("Thank you for saving me!")
		end
		if(healer.registry["bardq"] == 55) then
			healer.registry["bardq"] = 55
			healer:sendMinitext("Thank you for saving us!")
			mob:sendHealth(10000000, 100)
			healer:warp(752, 91, 75)
--			bard_palace_ai.after_death(mob)
		end
		mob_ai_basic.on_healed(mob, healer)
	end,

	move = function(mob, target)
		rand = math.random(1,10)
		if rand == 1 then
			mob:talk(1, mob.name .. ":Help me please!!")
		end

	end,
	after_death = function(mob)
		mob.paralyzed = false
		mob.sleep = 1
		mob.state = 1
	end,
}

bard_palace_ai_evil = {


	on_attacked = function(mob, attacker, level)
		local flatdam = mob.maxHealth * 0.001
        mob.attacker = attacker.ID
		mob:sendHealth(flatdam, attacker.critChance)
	end,
	on_spawn = function(mob)
		mob.paralyzed = true
		local randy = math.random(1000,3000)
		mob:setDuration("paralyze_mage",randy)
		mob.attacker = attacker.ID
		mob:sendStatus()
	end,

	move = function(mob, target)
		if target ~= nil then
			if mob.m ~= target.m then
				mob.target = 0
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
	end,
}
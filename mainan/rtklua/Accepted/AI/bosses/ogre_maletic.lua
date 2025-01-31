ogre_maletic = {
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
		setMapRegistry(mob.m, "lastDeathMaletic", os.time())
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,

	move = function(mob, target)
		if (mob.health > mob.baseHealth *.15) then
			mob_ai_basic.move(mob, target)
		else
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()
			mob:move()
			mob:move()
		end
	end,

	attack = function(mob, target)
		if (mob.health > mob.baseHealth *.15) then
			mob_ai_basic.attack(mob, target)
		else
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()
			mob:move()
			mob:move()
		end
	end
}

ogre_citelam = {
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
		setMapRegistry(mob.m, "lastDeathCitelam", os.time())
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,

	move = function(mob, target)
		if (mob.health > mob.baseHealth *.15) then
			mob_ai_basic.move(mob, target)
		else
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()
			mob:move()
			mob:move()
		end
	end,

	attack = function(mob, target)
		if (mob.health > mob.baseHealth *.15) then
			mob_ai_basic.attack(mob, target)
		else
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()
			mob:move()
			mob:move()
		end
	end
}



yahada = {
	on_spawn = function(mob)
		mob:warp(522,8,3)
	end,

	on_healed = function(mob,healer)
		mob_ai_basic.on_healed(mob,healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	move = function(mob, target)
		spellsword_ai.move(mob, target, 2)
	end,
	attack = function(mob, target)
		spellsword_ai.attack(mob, target, 0)
	end,
	after_death = function(mob, player)
		if(player.registry["sstrial"] == 4) then
			player.registry["sstrialkk"] = 1
			player:sendMinitext(""..player.registry["sstrialkk"])
		end
		spellsword_ai.after_death(mob)
	end,
}
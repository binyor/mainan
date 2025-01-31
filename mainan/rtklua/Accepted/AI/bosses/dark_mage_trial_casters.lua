dark_mage_trial_casters = {
	on_spawn = function(mob)
		mob.paralyzed = true
		local randy = math.random(1000,3000)
		mob:setDuration("paralyze_mage",randy)
		mob:sendStatus()
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		weak_caster_ai.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		weak_caster_ai.move(mob, target, 2)
	end,
	attack = function(mob, target)
		weak_caster_ai.attack(mob, target, 0)
	end,
	after_death = function(mob, player)
		if(player.registry["onbmquest"] >= 1) then
			player.registry["bmquestkillcount"] = player.registry["bmquestkillcount"] + 1
			player:sendMinitext(""..player.registry["bmquestkillcount"])
		end
		weak_caster_ai.after_death(mob)
	end
}
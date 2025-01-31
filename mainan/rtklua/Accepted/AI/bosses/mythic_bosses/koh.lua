koh = {
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		mob_ai_mythic.move(mob, target, 2)
	end,

	attack = function(mob, target)
		mob_ai_mythic.attack(mob, target, 0)
	end,
	after_death = function(mob)
		mob_ai_mythic.after_death(mob)
	end
}


kunoichi = {
	attack = function(mob, target)
		if mob.health <= math.ceil(mob.maxHealth * 0.15) then
			local rand1 = math.rand(0,3)
			mob.side = rand1
			mob.move()
			mob.move()
			mob.move()
			return 0
		end
		mob_ai_mythic.attack(mob, target, 0)
	end,
	move = function(mob, target)
		if mob.health <= math.ceil(mob.maxHealth * 0.15) then
			local rand1 = math.rand(0,3)
			mob.side = rand1
			mob.move()
			mob.move()
			mob.move()
			return
		end
		mob_ai_mythic.move(mob, target, 2)
	end


}
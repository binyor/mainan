knight_frank = {

	on_spawn = function(mob)
		mob.newMove = 2000
		mob.baseMove = mob.newMove
		mob.side = 2
		mob:updateState()
		mob:talk(0, "King Frank: Good evening, Sir Alcheon. Are we ready to depart?")
	end,

	on_healed = function(mob, healer)
	end,

	on_attacked = function(mob, attacker)
	end,

	move = function(mob, target)
		if mob.y == 28 then
			mob:talk(0, "King Frank: Let's be on our way!")
			mob.side = 2
			mob:sendSide()
		elseif mob.y == 32 then
			mob:talk(0, "King Frank: It's a beautiful night tonight. I am really looking forward to the feast.")
		elseif (mob.y == 46 and mob.x == 49) then
			mob:talk(0, 'King Frank yelps in a panic and says "Protect me!"')
			mob.newMove = 1000
			mob.baseMove = mob.newMove
			mob:updateState()
			mob.side = 3
			mob:sendSide()
		end
		if mob.x ~= 22 then
			mob:move()
		end
	end,

	attack = function(mob, target)
	end,

	after_death = function(mob, block)
	end
}
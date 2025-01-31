knight_alcheon = {

	on_spawn = function(mob)
		mob.newMove = 2000
		mob.baseMove = mob.newMove
		mob:updateState()
		mob:talk(0, "Alcheon: Let's prepare for the king's arrival. Stay vigilant.")
	end,

	on_healed = function(mob, healer)
	end,

	on_attacked = function(mob, attacker)
	end,

	move = function(mob, target)
		if mob.y < 29 then
			if mob.x < 48 then
				mob.side = 1
			else
				mob.side = 2
			end
		elseif mob.y == 28 then
			mob:talk(0, "Alcheon: The King will be here in a moment, get ready Squire.")
			mob.newMove = 3000
			mob.baseMove = mob.newMove
			mob:updateState()
		elseif mob.y == 29 then
			mob:talk(0, "Alcheon: All preparations have been made, your highness.")
			mob.newMove = 2000
			mob.baseMove = mob.newMove
			mob:updateState()
		elseif mob.y == 38 then
			mob:talk(0, "Alcheon: I agree my king, but it is far too quiet this evening.")
		elseif mob.y == 41 then
			mob:talk(0, "Alcheon: Squire, ready your blade. I have a bad feeling. Stay by my side, your highness.")
		elseif mob.y == 44 then
			mob:talk(0, "Alcheon looks to the east and the west, scanning the area.")
		elseif (mob.y == 47 and mob.x == 48) then
			mob:talk(0, "Alcheon: Ambush!! To arms, squire! Follow me, my lord and we will get you to safety!")
			mob.newMove = 1000
			mob.baseMove = mob.newMove
			mob:updateState()
			mob.side = 3
			mob:sendSide()
		elseif (mob.x == 46 and mob.y == 47) then
			mob:talk(0, "Alcheon: Squire, take care of these ogres, I'll protect the king!")
			mob.side = 3
		end
		if mob.x > 22 then
			mob:sendSide()
			mob:move()
		end
	end,

	attack = function(mob, target)
	end,

	after_death = function(mob, block)
	end
}
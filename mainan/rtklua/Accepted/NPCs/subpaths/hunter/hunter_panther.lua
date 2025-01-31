hunter_panther = {
	on_healed = function(mob, healer)
		mob.attacker = healer.ID
		mob:sendHealth(healer.damage, healer.critChance)
		healer.damage = 0
	end,

	on_attacked = function(mob, attacker)
		if (mob:hasDuration("snare") == true and mob.blind == true) then
			mob.attacker = attacker.ID
			mob:sendHealth(attacker.damage, attacker.critChance)
			attacker.damage = 0
		end
	end,

	move = function(mob, target)
		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end

		local found
		local moved = true
		local oldside = mob.side
		local checkmove = math.random(0, 10)

		mob.returning = false
		mob.state = MOB_HIT

		if (mob.owner == 0 or mob.owner > 1073741823) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end

		local owner = mob:getBlock(mob.owner)
		mob.target = owner.ID
		mob.attacker = mob.owner
		local threat = threat.getHighestThreat(mob)
		target:setThreat(mob.ID, threat + damage)		

		if (target ~= nil) then

			if (not mob.snare and not mob.blind) then
				moved = FindCoords(mob, target)
			end

			if (mob.blind) then
				if distanceSquare(mob, target, 0) then
					moved = FindCoords(mob, target)
				else
					return
				end
			end

			--if ((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
			--	mob.state = MOB_HIT
			--end
		end

		if (found == true) then
			mob.newMove = 0
			mob.deduction = mob.deduction + 1
			mob.returning = false
		end
	end,

	attack = function(mob, target)
		if (mob.paralyzed or mob.sleep ~= 1) then
			return
		end
		
		--mob:talk(2, "attack")
		local moved = false

		if (target) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end

			if (not mob.snare and not mob.blind) then
				moved = FindCoords(mob, target)
			end
			if (mob.blind) then
				if distanceSquare(mob, target, 0) then
					moved = FindCoords(mob, target)
				else
					return
				end
			end

			--mob:talk(2, "attack "..target.ID)
			if moved == true then
				FindCoords(mob, target)
			else
				FindCoords(mob, target)
				FindCoords(mob, target)
			end

			if (moved) then
				--We are right next to them, so attack!

				mob:attack(target.ID)
			else
				mob.state = MOB_ALIVE
			end
		else
			mob.state = MOB_ALIVE
		end
	end,

	after_death = function(mob)
		local owner = mob:getBlock(mob.owner)
		if owner.registry["hunterq"] == 14 then
			owner.registry["hunterq"] = 15
		end
		mob.sleep = 1
		mob.paralyzed = false
		mob.state = 1
	end
}



hunter_celebrate = {

	on_spawn = function(mob)
		local rand = math.random(1,7)
		mob.look = 221
		if rand == 1 then
			mob.look =  1345
		elseif rand == 2 then
			mob.look = 1346
		elseif rand == 3 then
			mob.look = 1706
		elseif rand == 4 then
			mob.look = 683
		elseif rand == 6 then
			mob.look = 603
		else
			mob.look = 221
		end
		mob:updateState()
		local rand2 = math.random(1,10)
		if rand2 == 1 then
			mob:talk(1,mob.name..": Woohoo! Welcome!")
		end
		if rand2 == 2 then
			mob:talk(1,mob.name..": Congratulations!")
		end
		if rand2 == 3 then
			mob:talk(0,mob.name..": Horrah~")
		end
		if mob.x == 17 and mob.y == 10 then
			mob.side = 2
			mob.sendSide()
		end
		if mob.x == 15 and mob.y == 11 then
			mob.side = 2
			mob.sendSide()
		end
		if mob.x == 14 and mob.y == 13 then
			mob.side = 1
			mob.sendSide()
		end
		if mob.x == 15 and mob.y == 15 then
			mob.side = 0
			mob.sendSide()
		end
		if mob.x == 20 and mob.y == 13 then
			mob.side = 3
			mob.sendSide()
		end
		if mob.x == 19 and mob.y == 11 then
			mob.side = 2
			mob.sendSide()
		end
		mob.move()
	end

}
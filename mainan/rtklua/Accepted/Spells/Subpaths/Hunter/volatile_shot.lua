volatile_shot = {
	cast = function(player)
		if not player:canCast(1, 1, 0) then
			return
		end
		if player:carnageSpell() then
            return
        end
		local baseCost = 1000			
		if (player.magic < baseCost) then
			player:sendMinitext("Not enough mana.")
			return
		end		
		if (player:getEquippedItem(0).class ~= 24) then
			player:removeMagic(1000)
			player:sendMinitext("You can't shoot without a bow")
			return
		end
		local pass
		local hit = 0
		local mob = getTargetRanged(player,BL_MOB, 7)
		if (mob ~= nil) then
			mob = mob[1]
		end
		local pc = getTargetRanged(player,BL_PC, 7)
		if (pc ~= nil) then
			pc = pc[1]
		end
		local maxDist = 1
		local around
		local target
		local aether = 24000
		
		if (mob ~= nil) and (pc ~= nil) then
			local distMob = distance(player, mob)
			local distPc = distance (player, pc)
			if (distMob > distPc) then
				maxDist = distPc
				target = pc
			else
				maxDist = distMob
				target = mob
			end
			for i = 1, maxDist do
				pass = getPassFacing(player, player.side, i)
				if (pass == false)  then
					--hit = 0
					break--fizzle
				end
				if (i == maxDist) then
					hit = 1
				end
			end
		elseif (mob ~= nil) then
			maxDist = distance(player, mob)
			for i = 1, maxDist do
				pass = getPassFacing(player, player.side, i)
				if (pass == false)  then
					--hit = 0
					break--fizzle
				end
				if (i == maxDist) then
					hit = 1
					target = mob
				end
			end
		elseif (pc ~= nil) then
			maxDist = distance(player, pc)
			for i = 1, maxDist do
				pass = getPassFacing(player, player.side, i)
				if (pass == false)  then
					--hit = 0
					break--fizzle
				end
				if (i == maxDist) then
					hit = 1
					target = pc
				end
			end
		end

		if (hit == 1) then
			local damage = player.maxMagic * 2
			local damage2 = player.maxMagic * 1.5
			local cost1 = player.maxMagic * 0.75	
			if (baseCost > cost1) then
				cost1 = baseCost
			end
			local cost = 0
			local maxDamage = 0
			target.attacker = player.ID
			for i = 1, 5 do
				if (target:removeHealthExtend(damage / i, 1, 1, 1, 1, 2) < target.health) then
					cost = cost1 / i
					maxDamage = damage / i
					break
				else
					if (i == 5) then
						cost = cost1 / i
						maxDamage = damage / i
					end
				end
			end
			
			if (player.gmLevel > 0) then
				--player:talk(3, "Mana cost: "..cost.." Main damage: "..maxDamage.." Smoke Dmg: "..damage2)
			end

			
			if (target.blType == BL_PC) then
				if (player:canPK(target)) then
					target:sendMinitext(player.name.." hits you with volatile shot!")
					target:removeHealthExtend(maxDamage, 1, 1, 1, 1, 0)
				else
					cost = baseCost
				end
			
			elseif (target.blType == BL_MOB) then
				local threat = threat.getHighestThreat(target)
				player:setThreat(target.ID, threat + damage)
				target:removeHealthExtend(maxDamage, 1, 1, 1, 1, 0)
			end
			target:sendAnimation(195)
			target:sendStatus()
			around = getTargetsAround(target,BL_ALL)
		

			--do graphics aether etc stuff
			if (around ~= nil) then
				--local damage2 = maxDamage / #around
				for i = 1, #around do
					if around[i].blType ~= BL_ITEM and around[i].blType ~= BL_NPC
					and around[i].state ~= 1 then
						around[i].attacker = player.ID
						around[i]:sendAnimation(292)
						if (around[i].blType == BL_PC) then
							if (player:canPK(around[i])) then
								around[i]:sendMinitext(player.name.." hits you with volatile shot!")
								around[i]:removeHealthExtend(damage2/2, 1, 1, 1, 1, 0)
							end
						elseif (around[i].blType == BL_MOB) then
							local threat = threat.getHighestThreat(around[i])
							player:setThreat(around[i].ID, threat + damage)
							around[i]:removeHealthExtend(damage2, 1, 1, 1, 1, 0)
						end
						around[i]:sendStatus()
					end
				end				
			end
			if player.side == 0 then
				player:throw(player.x, target.y, 6, 26, 1)
			end
			if player.side == 1 then
				player:throw(target.x, player.y - 1, 7, 26, 1)
			end
			if player.side == 2 then
				player:throw(player.x, target.y, 8, 26, 1)
			end
			if player.side == 3 then
				player:throw(target.x, player.y - 1, 9, 26, 1)
			end
			
			player:sendAction(3, 200)
			player:removeMagic(cost)
			player:talk(2,"~FWOOSSH~!")
		end
		player:setAether("volatile_shot", aether)
	end
}
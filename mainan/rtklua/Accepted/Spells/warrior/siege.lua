siege_warrior = {
	cast = function(player)
		local x = {}
		local y = {}
		local s = player.side
		local sound = 60
		local magic = 8000
		local spellName = "Siege"
		local damage = player.health * 1.875 + (player.magic / 2)

		if player:hasDuration("chin_baek_ho_ryung") then
			damage = math.ceil(damage * 1.875)
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
        end

		if (side == 0) then
			y = -1
		elseif (side == 1) then
			x = 1
		elseif (side == 2) then
			y = 1
		elseif (side == 3) then
			x = -1
		else
			return
		end

		local landed = 0
		local targetX = player.x + x
		local targetY = player.y + y
		local targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_MOB)

		if (#targets > 0) then
			local netDamage = targets[1]:calculateNetDamage(damage, 1, 1, 1, 1, 0, 1)
			local overflowDamage = netDamage - targets[1].health

			global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			landed = 1

			Overflow.Cast(
				player,
				overflowDamage,
				targetX,
				targetY,
				spellFX
			)
		end

		targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_PC)

		if (#targets > 0) then
			local worked = global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			if (worked == 2) then
				targets[1]:sendMinitext(player.name .. " cast " .. spellNames[alignmentIndex] .. " on you.")
				landed = 1
			end
		end

		if (landed == 1) then
			if(player.pvp == 1) then
				player.health = math.ceil(player.health*0.25)
			else
				if (alignmentIndex > 2) then
					-- Ming-Ken or Ohaeng
					player.health = math.ceil(player.health * 0.10)
				else
					-- Unaligned or Kwi-Sin
					player.health = 10
				end
			end
		end

		player:sendStatus()
		player:sendMinitext("You cast " .. spellNames[alignmentIndex] .. ".")
    end,
    
	requirements = function(player)
		local l = 99
		local i = {49031, 49025, 0}
		local ia = {1, 1, 600000}
		local d = "A large attack that deals damage to an enemy."
		return l, i, ia, d
	end
}

souls_freedom = {
	cast = function(player)
		local x = {}
		local y = {}
		local s = player.side
		local sound = 60
		local magic = 8000
		local spellName = "Soul's Freedom"
		local damage = player.health * 1.875 + (player.magic / 2)

		if player:hasDuration("chin_baek_ho_ryung") then
			damage = math.ceil(damage * 1.875)
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
        end

		if (side == 0) then
			y = -1
		elseif (side == 1) then
			x = 1
		elseif (side == 2) then
			y = 1
		elseif (side == 3) then
			x = -1
		else
			return
		end

		local landed = 0
		local targetX = player.x + x
		local targetY = player.y + y
		local targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_MOB)

		if (#targets > 0) then
			local netDamage = targets[1]:calculateNetDamage(damage, 1, 1, 1, 1, 0, 1)
			local overflowDamage = netDamage - targets[1].health

			global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			landed = 1

			Overflow.Cast(
				player,
				overflowDamage,
				targetX,
				targetY,
				spellFX
			)
		end

		targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_PC)

		if (#targets > 0) then
			local worked = global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			if (worked == 2) then
				targets[1]:sendMinitext(player.name .. " cast " .. spellNames[alignmentIndex] .. " on you.")
				landed = 1
			end
		end

		if (landed == 1) then
			if(player.pvp == 1) then
				player.health = math.ceil(player.health*0.25)
			else
				if (alignmentIndex > 2) then
					-- Ming-Ken or Ohaeng
					player.health = math.ceil(player.health * 0.10)
				else
					-- Unaligned or Kwi-Sin
					player.health = 10
				end
			end
		end

		player:sendStatus()
		player:sendMinitext("You cast " .. spellNames[alignmentIndex] .. ".")
    end,
    
	requirements = function(player)
		local l = 99
		local i = {49031, 49025, 0}
		local ia = {1, 1, 600000}
		local d = "A large attack that deals damage to an enemy."
		return l, i, ia, d
	end
}

lifes_end = {
	cast = function(player)
		local x = {}
		local y = {}
		local s = player.side
		local sound = 60
		local magic = 8000
		local spellName = "Life's End"
		local damage = player.health * 1.875 + (player.magic / 2)

		if player:hasDuration("chin_baek_ho_ryung") then
			damage = math.ceil(damage * 1.875)
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
        end

		if (side == 0) then
			y = -1
		elseif (side == 1) then
			x = 1
		elseif (side == 2) then
			y = 1
		elseif (side == 3) then
			x = -1
		else
			return
		end

		local landed = 0
		local targetX = player.x + x
		local targetY = player.y + y
		local targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_MOB)

		if (#targets > 0) then
			local netDamage = targets[1]:calculateNetDamage(damage, 1, 1, 1, 1, 0, 1)
			local overflowDamage = netDamage - targets[1].health

			global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			landed = 1

			Overflow.Cast(
				player,
				overflowDamage,
				targetX,
				targetY,
				spellFX
			)
		end

		targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_PC)

		if (#targets > 0) then
			local worked = global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			if (worked == 2) then
				targets[1]:sendMinitext(player.name .. " cast " .. spellNames[alignmentIndex] .. " on you.")
				landed = 1
			end
		end

		if (landed == 1) then
			if(player.pvp == 1) then
				player.health = math.ceil(player.health*0.25)
			else
				if (alignmentIndex > 2) then
					-- Ming-Ken or Ohaeng
					player.health = math.ceil(player.health * 0.10)
				else
					-- Unaligned or Kwi-Sin
					player.health = 10
				end
			end
		end

		player:sendStatus()
		player:sendMinitext("You cast " .. spellNames[alignmentIndex] .. ".")
    end,
    
	requirements = function(player)
		local l = 99
		local i = {49031, 49025, 0}
		local ia = {1, 1, 600000}
		local d = "A large attack that deals damage to an enemy."
		return l, i, ia, d
	end
}

winters_chill = {
	cast = function(player)
		local x = {}
		local y = {}
		local s = player.side
		local sound = 60
		local magic = 8000
		local spellName = "Winter's Chill"
		local damage = player.health * 1.875 + (player.magic / 2)

		if player:hasDuration("chin_baek_ho_ryung") then
			damage = math.ceil(damage * 1.875)
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
        end

		if (side == 0) then
			y = -1
		elseif (side == 1) then
			x = 1
		elseif (side == 2) then
			y = 1
		elseif (side == 3) then
			x = -1
		else
			return
		end

		local landed = 0
		local targetX = player.x + x
		local targetY = player.y + y
		local targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_MOB)

		if (#targets > 0) then
			local netDamage = targets[1]:calculateNetDamage(damage, 1, 1, 1, 1, 0, 1)
			local overflowDamage = netDamage - targets[1].health

			global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			landed = 1

			Overflow.Cast(
				player,
				overflowDamage,
				targetX,
				targetY,
				spellFX
			)
		end

		targets = player:getAliveObjectsInCell(map, targetX, targetY, BL_PC)

		if (#targets > 0) then
			local worked = global_attack.cast(
				player,
				targets[1],
				damage,
				0,
				spellFX
			)

			if (worked == 2) then
				targets[1]:sendMinitext(player.name .. " cast " .. spellNames[alignmentIndex] .. " on you.")
				landed = 1
			end
		end

		if (landed == 1) then
			if(player.pvp == 1) then
				player.health = math.ceil(player.health*0.25)
			else
				if (alignmentIndex > 2) then
					-- Ming-Ken or Ohaeng
					player.health = math.ceil(player.health * 0.10)
				else
					-- Unaligned or Kwi-Sin
					player.health = 10
				end
			end
		end

		player:sendStatus()
		player:sendMinitext("You cast " .. spellNames[alignmentIndex] .. ".")
    end,
    
	requirements = function(player)
		local l = 99
		local i = {49031, 49025, 0}
		local ia = {1, 1, 600000}
		local d = "A large attack that deals damage to an enemy."
		return l, i, ia, d
	end
}

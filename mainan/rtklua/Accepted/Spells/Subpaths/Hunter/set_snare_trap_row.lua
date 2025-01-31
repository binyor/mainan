set_snare_trap_row = {
	cast = function(player)
		--if player.gmLevel ~= 99 then player:sendMinitext("Under construction!") return end
		local dist = 2
		local magic = 150 * (dist * 2)
		local duration = 75000
		if not player:canCast(1, 1, 0) then
			return
		end
		if player:carnageSpell() then
            return
        end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		if player.pvp == 1 then
			player:setAether("set_snare_trap_row",30000)
		else
			player:setAether("set_snare_trap_row",2000)
		end
		
		local line = line_side(player, dist)
		
		for i = 1, #line do
			player:addNPC(
				"ScourgeTrapNpc",
				player.m,
				line[i][1],
				line[i][2],
				2,
				0,
				0,
				player.ID
			)
		end

		player.magic = player.magic - magic
		player:playSound(0)
		player:sendStatus()
		player:sendAction(6, 35)

		player:sendMinitext("You set a row of traps!")
	end,

	requirements = function(player)
		local level = 99
		local items = {"fine_rabbit_meat", 0}
		local itemAmounts = {100, 3500}
		local description = "Set a row of snare traps."
		return level, items, itemAmounts, description
	end
}

ScourgeTrapNpc = {
	click = function(block, npc)

		if (block.blType == BL_PC) then
			if block.state == 1 then
				return
			end
			if not block:canPK(block) then
				return
			end
			block:sendMinitext("You stepped on a trap!")
			if block:checkIfCast(protections) then
				return
			end
--		elseif block.blType == BL_MOB then
--			return
		end
		scourge_hunter.cast(block)
		block:sendAnimation(1)
		removeTrapItem(npc)
		npc:delete()
	end,

	endAction = function(npc, owner)
		removeTrap(npc)
	end,

	uncast = function(block)
	end
}

scourge_hunter = {
	cast = function(block)
		local duration = 75000

		if (block.blType == BL_PC) then
			if not block:canPK(block) then
				return
			end
			block:sendStatus()
		end

		if (block:hasDuration("scourge_hunter") == true) then
			block:setDuration("scourge_hunter", 0)
			block:setDuration("scourge_hunter", duration)
		else
			if block.cursed == 0 then
				block:setDuration("scourge_hunter", duration)
			else
				block:sendAnimation(1)
				return
			end
		end

		block.armor = block.armor + 50
		block.cursed = 1
		block:sendStatus()
		block:sendAnimation(1)
	end,

	recast = function(block)
		block.armor = block.armor + 50
		block.cursed = 1
		block:sendStatus()
	end,

	while_cast = function(block)
		block:sendAnimation(34)
	end,

	uncast = function(block)
		block.armor = block.armor - 50
		block.cursed = 0
		block:sendStatus()
	end
}
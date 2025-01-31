set_snare_trap = {
	cast = function(player)
		--if player.gmLevel ~= 99 then player:sendMinitext("Under construction!") return end
		local magic = 120
		local duration = 75000
		if not player:canCast(1, 1, 0) then
			return
		end

		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		player:addNPC(
			"SnareTrapNpc",
			player.m,
			player.x,
			player.y,
			2,
			0,
			0,
			player.ID
		)

		player.magic = player.magic - magic
		player:playSound(0)
		player:sendStatus()
		player:sendAction(6, 35)

		player:sendMinitext("You set a trap!")
	end,

	requirements = function(player)
		local level = 33
		local items = {"fine_rabbit_meat", 0}
		local itemAmounts = {2, 350}
		local description = "Set a snare trap."
		return level, items, itemAmounts, description
	end
}

SnareTrapNpc = {
	click = function(block, npc)

		if (block.blType == BL_PC) then
			if block.state == 1 then
				return
			end
			if not block:canPK(block) then
				return
			end
			block:sendMinitext("You stepped on a trap!")
			removeTrapItem(npc)
			npc:delete()
			if block:checkIfCast(protections) then
				return
			end
			snare.cast(block)
			return
		elseif block.blType == BL_MOB then
			snare.cast(block)
			removeTrapItem(npc)
			npc:delete()
			return
		end
	end,

	endAction = function(npc, owner)
		removeTrap(npc)
	end,

	recast = function(block)
		
	end,

	while_cast = function(block)
		
	end,

	uncast = function(block)
	end
}


snare = {
	cast = function(block)
		local duration = 75000

		if (block.blType == BL_PC) then
			if not block:canPK(block) then
				return
			end
			block:sendStatus()
		end

		if (block:hasDuration("snare") == true) then
			block:setDuration("snare", 0)
			block:setDuration("snare", duration)
		else
			if block.cursed == 0 then
				block:setDuration("snare", duration)
			else
				block:sendAnimation(1)
				return
			end
		end

		block.armor = block.armor + 20
		block.cursed = 1
		block:sendStatus()
		block:sendAnimation(1)
	end,

	recast = function(block)
		block.armor = block.armor + 20
		block.cursed = 1
		block:sendStatus()
	end,

	while_cast = function(block)
		block:sendAnimation(34)
	end,

	uncast = function(block)
		block.armor = block.armor - 20
		block.cursed = 0
		block:sendStatus()
	end,

	requirements = function(player)
		local level = 33
		local items = {}
		local itemAmounts = {}
		local description = "Used to morph into different animals. If you choose to join an alignment, your morph changes into 1 specific morph."
		return level, items, itemAmounts, description
	end
}

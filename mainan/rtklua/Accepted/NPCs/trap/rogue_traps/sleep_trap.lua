SleepTrapNpc = {
	click = function(block, npc)
		local animation = 2

		if (block.blType == BL_PC) then
			if block.state == 1 then
				return
			end
			if not block:canPK(block) then
				return
			end
			if (block.state == 1) then
				return
			end
			block:sendMinitext("You stepped on a trap!")
			block:sendAnimation(2)
		end

		block.attacker = npc.owner
		sleep_trap.cast(block)
		removeTrapItem(npc)
		npc:delete()
	end,

	endAction = function(npc, owner)
		removeTrap(npc)
	end,
}

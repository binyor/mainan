light = {
	cast = function(player, target)
		local magicCost = player.maxMagic *.1
		local duration = 300000
		local aether = 150000
		local anim = 135
		local sound = 708

		if not player:canCast(1, 1, 0) then
			return
		end
		if player.magic < magicCost then
			notEnoughMP(player)
			return
		end
		if target:hasDuration("light") then
			alreadyCast(player)
			return
		end

		--if target.blType == BL_MOB or target.state == 1 then invalidTarget(player) return end

		if target.blType == BL_PC then
			player:sendAction(6, 20)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:sendAnimation(anim)
			player:playSound(sound)
			player:setAether("light", aether)
			target:setDuration("light", duration)
			target:calcStat()
			player:sendMinitext("Anda mengeluarkan Light pada " .. target.name)
			if target.ID ~= player.ID then
				target:sendMinitext(player.name .. " mengeluarkan Light pada Anda")
			end
		end
	end,

	while_cast_250 = function(player)
		local anim = 135
		player:sendAnimation(anim)
	end,

	requirements = function(player)
		local level = 5
		local item = {0}
		local amounts = {50}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Sebuah mantra untuk menerangi jalan Anda."
		return level, item, amounts, desc
	end
}

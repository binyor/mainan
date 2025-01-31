gm_dispell = {
	cast = function(player, target)
		if (player.gmLevel < 1) then
			player:sendMinitext("Anda tidak mengerti cara menggunakan mantra ini.")
			return
		end

		--target:flushDurationRange(1, 10000)
		target:flushDuration(5)
		target:sendStatus()
		target:sendAnimation(10)
		player:playSound(34)

		--13
		if (player.ID ~= target.ID) then
			target:sendMinitext("GM " .. player.name .. " menggunakan Dispell pada Anda.")
		end
		player:sendMinitext("Anda menghapus status " .. target.name .. ".")
		player:sendAction(6, 35)
	end
}

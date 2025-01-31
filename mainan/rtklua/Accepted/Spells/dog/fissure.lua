fissure = {
	cast = function(player, target)
		local spellName = "Fissure"
		local damage = 1000
		local x = {0, -1, 0, 1, 0}
		local y = {0, 0, -1, 0, 1}

		if not player:canCast(1, 1, 0) then
			return
		end
		if (player.magic < 120) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		player.magic = player.magic - 120
		player:sendStatus()

		for i = 1, 5 do
			local hits = target:getObjectsInCell(
				target.m,
				target.x + x[i],
				target.y + y[i],
				BL_MOB
			)
			if #hits > 0 then
				global_zap.cast(player, hits[1], damage, 0, 34)
			end
			hits = target:getObjectsInCell(
				target.m,
				target.x + x[i],
				target.y + y[i],
				BL_PC
			)
			if #hits > 0 then
				local worked = global_zap.cast(player, hits[1], damage, 0, 34)
				if worked == 2 then
					target:sendMinitext(player.name .. " menggunakan " .. spellName .. " ke kamu.")
				end
			end
		end

		player:sendMinitext("Anda menggunakan " .. spellName .. ".")
		player:sendAction(6, 35)
	end,

	requirements = function(player)
		local level = 60
		local items = {"amber", "amethyst", "quartz", "topaz"}
		local itemAmounts = {1, 1, 1, 1}
		local description = "Ledakkan musuh Anda dengan letusan lava."
		return level, items, itemAmounts, description
	end
}

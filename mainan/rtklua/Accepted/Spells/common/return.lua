return_spell = {
	cast = function(player)
		local magic = 30
		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		if player.warpOut == 0 then
			player:sendMinitext("Tidak berfungsi di sini.")
			return
		end

		if player.m == 666 then
			return
		end
		if player:canPK(player) then
			player:sendMinitext("Gagal.")
			return
		end
		if player.m == 3010 or player.m == 3011 or player.m == 33 then
			player:sendMinitext("Gagal.")
			return
		end
		if player.m == 3042 then
			player:sendMinitext("Gagal.")
			return
		end
		if (player.m >= 3034 and player.m <= 3039) then
			player:sendMinitext("Gagal.")
			return
		end

		player:returnFunc()
	end,

	requirements = function(player)
		local level = 32
		local items = {"acorn", 0}
		local itemAmounts = {30, 50}
		local description = "Mengembalikan Anda ke kota asal."
		return level, items, itemAmounts, description
	end
}

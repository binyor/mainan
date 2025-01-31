spot_traps = {
	cast = function(player)
		local magic = 100
		if not player:canCast(1, 1, 0) then
			return
		end

		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		player.magic = player.magic - magic
		player:playSound(0)
		player:setAether("spot_traps", 6000)
		seeSpotTraps(player)
		player:sendStatus()
		player:sendAction(6, 35)
	end,

	requirements = function(player)
		local level = 60
		local items = {}
		local itemAmounts = {}
		local description = "Menandai jebakan di tanah dan menandainya dengan belati besi. Belati akan tetap muncul di layar selama yang kamu inginkan, tetapi akan hilang setelah kamu logout. Mantra ini mendeteksi jebakan seperti jebakan peledak, dart, dan kilat."
		return level, items, itemAmounts, description
	end
}

dragons_harness_warrior = {
	cast = function(player)
		local magic = 10000
		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end
		if player:checkIfCast(enchants) or player.enchant > 1 then
			player:sendMinitext("This spell is already active.")
			return
		end

		player:sendMinitext("Your weapon shines with holy light.")
		player.magic = player.magic - magic
		player.enchant = 8
		player:sendStatus()
		player:sendAction(6, 35)
	end,
	recast = function(player)
		player.enchant = 8
	end,
	uncast = function(player)
		player.enchant = 1
	end,
	requirements = function(player)
		local level = 99
		local items = {0}
		local itemAmounts = {80000}
		local description = "Infuses your weapon with extremely strong energy."
		return level, items, itemAmounts, description
	end
}

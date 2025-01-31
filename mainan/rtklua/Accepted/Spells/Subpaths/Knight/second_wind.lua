second_wind = {
	cast = function(player)

		local aethers = 1800000
		local magicCost = 10000
		local health = player.maxHealth

		if (not player:canCast(1, 1, 0)) then
			return
		end
		if player:carnageSpell() then
            return
        end
		if (player.magic < magicCost) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		player.magic = player.magic - magicCost
		player:sendAction(6,20)
		player:setAether("second_wind", aethers)

		player:playSound(112)
		player:sendAnimation(441)

		player.attacker = player.ID
		player:addHealthExtend(health, 0, 0, 0, 0, 0)

		player:sendStatus()
		player:sendMinitext("You feel fully restored.")

	end,

		requirements = function(player)
		local level = 99
		local items = {"red_potion", "mountain_ginseng", 0}
		local itemAmounts = {2, 5, 100000}
		local description = "Fully restore your vitality."
		return level, items, itemAmounts, description
	end
}
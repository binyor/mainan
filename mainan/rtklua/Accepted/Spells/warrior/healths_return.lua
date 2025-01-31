healths_return_warrior = {
	cast = function(player)
		local spellName = "Health's Return"
		if not player:canCast(1, 1, 0) then
			return
		end
		local worked = global_heal.cast(player, player, 1200, 1000, 0)
		if worked == 1 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {Item("mountain_ginseng").id, 0}
		local itemAmounts = {5, 50000}
		local description = "An improved self-heal spell."
		return level, items, itemAmounts, description
	end
}

mending_of_the_soul_warrior = {
	cast = function(player)
		local spellName = "Mending of the Soul"
		if not player:canCast(1, 1, 0) then
			return
		end
		local worked = global_heal.cast(player, player, 1200, 1000, 1)
		if worked == 1 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {Item("mountain_ginseng").id, 0}
		local itemAmounts = {5, 50000}
		local description = "An improved self-heal spell."
		return level, items, itemAmounts, description
	end
}

spirits_salvation_warrior = {
	cast = function(player)
		local spellName = "Spirit's Salvation"
		if not player:canCast(1, 1, 0) then
			return
		end
		local worked = global_heal.cast(player, player, 1200, 1000, 2)
		if worked == 1 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {Item("mountain_ginseng").id, 0}
		local itemAmounts = {5, 50000}
		local description = "An improved self-heal spell."
		return level, items, itemAmounts, description
	end
}

gift_of_life_warrior = {
	cast = function(player)
		local spellName = "Gift of Life"
		if not player:canCast(1, 1, 0) then
			return
		end
		local worked = global_heal.cast(player, player, 1200, 1000, 3)
		if worked == 1 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {Item("mountain_ginseng").id, 0}
		local itemAmounts = {5, 50000}
		local description = "An improved self-heal spell."
		return level, items, itemAmounts, description
	end
}

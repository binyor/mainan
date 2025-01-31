spark_mage = {
	cast = function(player, target)
		local spellName = "Spark"
		if not player:canCast(1, 1, 0) then
			return
		end
		local damage = 15 + math.floor(player.level / 2) + math.floor((player.will + 3) / 4)
		local worked = global_zap.cast(player, target, damage, 20, 11)
		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end,

	requirements = function(player)
		local level = 9
		local items = {Item("acorn").id, Item("book").id, 0}
		local itemAmounts = {10, 1, 10}
		local description = "A weak elemental attack."
		return level, items, itemAmounts, description
	end
}

glimpse_of_the_void_mage = {
	cast = function(player, target)
		local spellName = "Glimpse of the Void"
		if not player:canCast(1, 1, 0) then
			return
		end
		local damage = 15 + math.floor(player.level / 2) + math.floor((player.will + 3) / 4)
		local worked = global_zap.cast(player, target, damage, 20, 1)
		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end,

	requirements = function(player)
		local level = 9
		local items = {Item("acorn").id, Item("book").id, 0}
		local itemAmounts = {10, 1, 10}
		local description = "A weak elemental attack."
		return level, items, itemAmounts, description
	end
}

bolt_mage = {
	cast = function(player, target)
		local spellName = "Bolt"
		if not player:canCast(1, 1, 0) then
			return
		end
		local damage = 15 + math.floor(player.level / 2) + math.floor((player.will + 3) / 4)
		local worked = global_zap.cast(player, target, damage, 20, 2)
		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end,

	requirements = function(player)
		local level = 9
		local items = {Item("acorn").id, Item("book").id, 0}
		local itemAmounts = {10, 1, 10}
		local description = "A weak elemental attack."
		return level, items, itemAmounts, description
	end
}

natures_ire_mage = {
	cast = function(player, target)
		local spellName = "Nature's Ire"
		if not player:canCast(1, 1, 0) then
			return
		end
		local damage = 15 + math.floor(player.level / 2) + math.floor((player.will + 3) / 4)
		local worked = global_zap.cast(player, target, damage, 20, 3)
		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end,

	requirements = function(player)
		local level = 9
		local items = {Item("acorn").id, Item("book").id, 0}
		local itemAmounts = {10, 1, 10}
		local description = "A weak elemental attack."
		return level, items, itemAmounts, description
	end
}





enchantblade_zap = {
	cast = function(player, target)
		local spellName = "Enchant Blade Zap"
		local damage = 50 + math.floor(player.maxMagic * .1)
		local worked = global_zap.cast(player, target, damage, 20, 0)
--[[		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
		end
]]
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end,

	requirements = function(player)
		local level = 100
		local items = {Item("acorn").id, Item("book").id, 0}
		local itemAmounts = {10, 1, 10}
		local description = "A weak elemental attack."
		return level, items, itemAmounts, description
	end
}
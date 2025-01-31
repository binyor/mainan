chance_rogue = {
	cast = function(player)
		local magicCost = 1000
		local aether = 62000
		local duration = 3000
		if player.gmLevel > 0 then
			aether = 0
		end

		if player.money < 170 then
			player:sendMinitext("Your pockets aren't deep enough!")
			return
		end

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		player.registry["chanceX"] = 0
		player.registry["chanceY"] = 0
		player.registry["chanceGoldAmount"] = 0

		player:sendAction(6, 35)
		player.magic = player.magic - magicCost
		player.money = player.money - 170
		player:sendStatus()
		player:sendMinitext("You cast Chance.")
		player:setDuration("chance_rogue",duration)
		player:setAether("chance_rogue", 62000)
	end,

	while_cast = function(player)
		player:sendAnimation(259)
	end,

	uncast = function(player)
		if (math.random(1,100) > 45) then
			invoke.cast(player)
		else
			dishearten.cast(player,player)
		end
		player.registry["chanceX"] = 0
		player.registry["chanceY"] = 0
		player.registry["chanceGoldAmount"] = 0
	end,

	after_drop_gold_while_cast = function(player)
		player:talk(0,"hit")
		local goldAmount = 0
		local groundItems = player:getObjectsInCell(player.m,player.x,player.y,BL_ITEM)

		if #groundItems > 0 then
			for i = 1, #groundItems do
				if player:canLoot(groundItems[i]) and groundItems[i].id <= 3 then
					-- gold
					goldAmount = goldAmount + groundItems[i].amount
				end
			end
		else
			return
		end

		player.registry["chanceGoldAmount"] = player.registry["chanceGoldAmount"] + goldAmount

		if player.registry["chanceGoldAmount"] >= 170 then
			local rand = math.random(1, 100)
			if (rand > 45) then
				invoke.cast(player)
			else
				dishearten.cast(player, player)
			end
			player.registry["chanceX"] = 0
			player.registry["chanceY"] = 0
		end
		if player.registry["chanceGoldAmount"] == 170 then
			groundItems[1]:delete()
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {0}
		local itemAmounts = {200000}
		local description = "Take a chance to cast Invoke or Dishearten."
		return level, items, itemAmounts, description
	end
}

randomness_rogue = {
	cast = function(player)
		local magicCost = 1000
		local aether = 62000
		local duration = 3000
		if player.gmLevel > 0 then
			aether = 0
		end

		if player.money < 170 then
			player:sendMinitext("Your pockets aren't deep enough!")
			return
		end

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		player.registry["chanceX"] = 0
		player.registry["chanceY"] = 0
		player.registry["chanceGoldAmount"] = 0

		player:sendAction(6, 35)
		player.magic = player.magic - magicCost
		player.money = player.money - 170
		player:sendStatus()
		player:sendMinitext("You cast Chance.")
		player:setDuration("randomness_rogue",duration)
		player:setAether("randomness_rogue", 62000)
	end,

	while_cast = function(player)
		player:sendAnimation(259)
	end,

	uncast = function(player)
		if (math.random(1,100) > 45) then
			invoke.cast(player)
		else
			dishearten.cast(player,player)
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {0}
		local itemAmounts = {200000}
		local description = "Take a chance to cast Invoke or Dishearten."
		return level, items, itemAmounts, description
	end
}

natures_choice_rogue = {
	cast = function(player)
		local magicCost = 1000
		local aether = 62000
		local duration = 3000
		if player.gmLevel > 0 then
			aether = 0
		end

		if player.money < 170 then
			player:sendMinitext("Your pockets aren't deep enough!")
			return
		end

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		player.registry["chanceX"] = 0
		player.registry["chanceY"] = 0
		player.registry["chanceGoldAmount"] = 0

		player:sendAction(6, 35)
		player.magic = player.magic - magicCost
		player.money = player.money - 170
		player:sendStatus()
		player:sendMinitext("You cast Chance.")
		player:setDuration("natures_choice_rogue",duration)
		player:setAether("natures_choice_rogue", 62000)
	end,

	while_cast = function(player)
		player:sendAnimation(259)
	end,

	uncast = function(player)
		if (math.random(1,100) > 45) then
			invoke.cast(player)
		else
			dishearten.cast(player,player)
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {0}
		local itemAmounts = {200000}
		local description = "Take a chance to cast Invoke or Dishearten."
		return level, items, itemAmounts, description
	end
}

trial_by_fire_rogue = {
	cast = function(player)
		local magicCost = 1000
		local aether = 62000
		local duration = 3000
		if player.gmLevel > 0 then
			aether = 0
		end

		if player.money < 170 then
			player:sendMinitext("Your pockets aren't deep enough!")
			return
		end

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		player.registry["chanceX"] = 0
		player.registry["chanceY"] = 0
		player.registry["chanceGoldAmount"] = 0

		player:sendAction(6, 35)
		player.magic = player.magic - magicCost
		player.money = player.money - 170
		player:sendStatus()
		player:sendMinitext("You cast Chance.")
		player:setDuration("trial_by_fire_rogue",duration)
		player:setAether("trial_by_fire_rogue", 62000)
	end,

	while_cast = function(player)
		player:sendAnimation(259)
	end,

	uncast = function(player)
		if (math.random(1,100) > 45) then
			invoke.cast(player)
		else
			dishearten.cast(player,player)
		end
	end,

	requirements = function(player)
		local level = 99
		local items = {0}
		local itemAmounts = {200000}
		local description = "Take a chance to cast Invoke or Dishearten."
		return level, items, itemAmounts, description
	end
}

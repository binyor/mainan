jesters_performance = {
	cast = function(player)
		if (not player:canCast(1, 1, 0)) then
			return
		end
		local aether = 150000
		if player.gmLevel > 0 then
			aether = 1
		end
		if player.pvp == 1 then
			player:sendMinitext("That's too far..")
			return
		end
		player:removeDuras(lesserFuries)

		local cunlevel = player.registry["jesters_performance"]
		if cunlevel < 0 or cunlevel > 6 then
			cunlevel = 0
		end
		if (player:hasDuration("jesters_performance") == true and cunlevel == 1) then
			-- cast cunning 2
			if (player.magic < 4200) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 4200
			player:setAether("jesters_performance", aether)
			player:sendAnimation(115)
			player:sendAction(22, 3000)
			player:playSound(705)
			player:sendMinitext("[Act II] You juggle your blades, increasing accuracy.")
			player.registry["jesters_performance"] = 2
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("jesters_performance") == true and cunlevel == 2) then
			-- cast cunning 3
			if (player.magic < 15634) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 15634
			player:setAether("jesters_performance", aether)
			player:sendAnimation(115)
			player:playSound(705)
			player:sendMinitext("[Act 3] You dance, increasing speed.")
			player.registry["jesters_performance"] = 3
			player:sendAction(6, 35)
			player:sendAction(22, 3000)
			player:calcStat()
		elseif (player:hasDuration("jesters_performance") == true and cunlevel == 3) then
			-- cast cunning 4
			if (player.magic < 46658) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 46658
			player:setAether("jesters_performance", aether)
			player:sendAnimation(115)
			player:playSound(705)
			player:sendMinitext("[Act 4] Your bloodlust grows during the show..")
			player.registry["jesters_performance"] = 4
			player:sendAction(6, 35)
			player:sendAction(22, 3000)
			player:calcStat()
		elseif (player:hasDuration("jesters_performance") == true and cunlevel == 4) then
			-- cast cunning 5
			if (player.magic < 117667) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 117667
			player:setAether("jesters_performance", aether)
			player:sendAnimation(115)
			player:playSound(705)
			player:sendMinitext("[Act 5] Your hands shake in anticipation for the grand finale.")
			player.registry["jesters_performance"] = 5
			player:sendAction(6, 35)
			player:sendAction(22, 3000)
			player:calcStat()
		elseif (player:hasDuration("jesters_performance") == true and cunlevel == 5) then
			-- cast cunning 6 TESTING ONLY
			if (player.magic < 265000) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 265000
			player:setAether("jesters_performance", aether)
			player:sendAnimation(115)
			player:playSound(705)
			player:sendMinitext("[Act 6]")
			player.registry["jesters_performance"] = 6
			player:sendAction(6, 35)
			player:sendAction(22, 3000)
			player:calcStat()
		elseif (player:hasDuration("jesters_performance") == false) then
			if (player.magic < 3000) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player:setDuration("wolfs_fury_rogue", 0)
			player:setDuration("tigers_fury_rogue", 0)
			player:setDuration("serpents_fury", 0)
			player:setDuration("baekhos_rage_rogue", 0)
			player.magic = player.magic - 3000
			player:sendAnimation(115)
			player:playSound(705)
			player:setDuration("jesters_performance", 938000)
			player:setAether("jesters_performance", aether)
			player:sendMinitext("[Act 1] You sharpen your blades.")
			player.registry["jesters_performance"] = 1
			player:sendAction(6, 35)
			player:sendAction(22, 3000)
			player:calcStat()
		else
			player:sendMinitext("You have reached your max potential.")
		end
	end,

	recast = function(player)
		local cunlevel = player.registry["jesters_performance"]
		local deduction = 0
		if cunlevel <= 1 then
			player.rage = 6
		end
		if cunlevel == 2 then
			player.rage = 7
			deduction = 0.08
			player.backstab = true
			player.flank = false
		end
		if cunlevel == 3 then
			player.rage = 9
			deduction = 0.16
			player.backstab = false
			player.flank = true
		end
		if cunlevel == 4 then
			player.rage = 10
			deduction = 0.24
			player.backstab = true
			player.flank = true
		end
		if cunlevel == 5 then
			player.rage = 12
			deduction = 0.32
			player.backstab = true
			player.flank = true
		end
		if cunlevel >= 6 then
			player.rage = 14
			deduction = 0.4
			player.backstab = true
			player.flank = true
		end

		if not player:checkIfCast(sanctuaries) then
			player.deduction = player.deduction - deduction
		end
		player:sendStatus()
	end,
	uncast = function(player)
		player.rage = 1
		player.backstab = false
		player.flank = false
		player.registry["jesters_performance"] = 0
		if not player:checkIfCast(sanctuaries) then
			player.deduction = 1
		end
		player:sendStatus()
	end,

	requirements = function(player)
		local level = 99
		local items = {
			Item("blood").id,
			Item("baekho_key").id,
			Item("lucky_silver_coin").id,
			0
		}
		local itemAmounts = {1, 1, 1, 50000}
		local description = "Increase your power with a grand performance."

		if (Config.freeNpcSubpathsEnabled) then
			items = {}
			itemAmounts = {}
		end

		return level, items, itemAmounts, description
	end
}

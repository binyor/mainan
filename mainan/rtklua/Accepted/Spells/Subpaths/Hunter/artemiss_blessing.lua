artemiss_blessing = {
	cast = function(player)
		if (not player:canCast(1, 1, 0)) then
			return
		end
		local aether = 150000
		if player.gmLevel > 0 then
			aether = 1
		end
		if player:carnageSpell() then
            return
        end
		player:removeDuras(lesserFuries)

		local cunlevel = player.registry["artemiss_blessing"]
		if cunlevel < 0 or cunlevel > 6 then
			cunlevel = 0
		end
		if (player:hasDuration("artemiss_blessing") == true and cunlevel == 1) then
			-- cast cunning 2
			if (player.magic < 4200) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 4200
			player:setAether("artemiss_blessing", aether)
			player:sendAnimation(231)
			player:playSound(705)
			player:sendMinitext("You pray to the goddess of the hunt for a boost. [Blessing 2]")
			player.registry["artemiss_blessing"] = 2
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("artemiss_blessing") == true and cunlevel == 2) then
			-- cast cunning 3
			if (player.magic < 15634) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 15634
			player:setAether("artemiss_blessing", aether)
			player:sendAnimation(231)
			player:playSound(705)
			player:sendMinitext("Artemis blesses you with her wisdom. [Blessing 3]")
			player.registry["artemiss_blessing"] = 3
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("artemiss_blessing") == true and cunlevel == 3) then
			-- cast cunning 4
			if (player.magic < 46658) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 46658
			player:setAether("artemiss_blessing", aether)
			player:sendAnimation(229)
			player:playSound(705)
			player:sendMinitext("You become one with nature, displaying your true skills. [Blessing 4]")
			player.registry["artemiss_blessing"] = 4
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("artemiss_blessing") == true and cunlevel == 4) then
			-- cast cunning 5
			if (player.magic < 117667) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 117667
			player:setAether("artemiss_blessing", aether)
			player:sendAnimation(229)
			player:playSound(705)
			player:sendMinitext("You're ferocity is equal to a brown bear. [Blessing 5]")
			player.registry["artemiss_blessing"] = 5
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("artemiss_blessing") == true and cunlevel == 5) then
			-- cast cunning 6 TESTING ONLY
			if (player.magic < 265000) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player.magic = player.magic - 265000
			player:setAether("artemiss_blessing", aether)
			player:sendAnimation(229)
			player:playSound(705)
			player:sendMinitext("You are one with nature.")
			player.registry["artemiss_blessing"] = 6
			player:sendAction(6, 35)
			player:calcStat()
		elseif (player:hasDuration("artemiss_blessing") == false) then
			if (player.magic < 3000) then
				player:sendMinitext("You do not have enough mana.")
				return
			end
			player:setDuration("wolfs_fury_rogue", 0)
			player:setDuration("tigers_fury_rogue", 0)
			player:setDuration("serpents_fury", 0)
			player:setDuration("baekhos_rage_rogue", 0)
			player.magic = player.magic - 3000
			player:sendAnimation(225)
			player:playSound(705)
			player:setDuration("artemiss_blessing", 938000)
			player:setAether("artemiss_blessing", aether)
			player:sendMinitext("You prepare for the hunt. [Blessing 1]")
			player.registry["artemiss_blessing"] = 1
			player:sendAction(6, 35)
			player:calcStat()
		else
			player:sendMinitext("You have reached your max potential.")
		end
	end,

	recast = function(player)
		local cunlevel = player.registry["artemiss_blessing"]
		local deduction = 0
		if cunlevel <= 1 then
			player.rage = 6
		end
		if cunlevel == 2 then
			player.rage = 7
			deduction = 0.08
--			player.backstab = true
--			player.flank = false
		end
		if cunlevel == 3 then
			player.rage = 9
			deduction = 0.16
--			player.backstab = false
--			player.flank = true
		end
		if cunlevel == 4 then
			player.rage = 10
			deduction = 0.24
--			player.backstab = true
--			player.flank = true
		end
		if cunlevel == 5 then
			player.rage = 12
			deduction = 0.32
--			player.backstab = true
--			player.flank = true
		end
		if cunlevel >= 6 then
			player.rage = 14
			deduction = 0.4
--			player.backstab = true
--			player.flank = true
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
		player.registry["artemiss_blessing"] = 0
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
		local description = "Increase your power with your bottle of rum."

		if (Config.freeNpcSubpathsEnabled) then
			items = {}
			itemAmounts = {}
		end

		return level, items, itemAmounts, description
	end
}

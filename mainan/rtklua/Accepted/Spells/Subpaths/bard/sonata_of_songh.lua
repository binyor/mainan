sonata_of_songh = {
	cast = function(player)
--		if player.gmLevel < 99 then
--			player:sendMinitext("Currently disabled.")
--			return 0
--		end
		local duration = 200000
		local magicCost = math.ceil(player.maxMagic * 0.4)
		if (not player:canCast(1, 1, 0)) then
			return
		end
		if player:carnageSpell() then
            return
        end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		if (player:hasDuration("sonata_of_songh") == true) then
			if player.name == "Maze" then
				player:sendMinitext("You already have that active, stupid!")
			else
				player:sendMinitext("You already have that active!")
			end
			return
		end
		if (player.pvp == 1) then
			player:setAether("sonata_of_songh", 60000)
		end


		--[[ if player.name == "Maze" then
			player:sendAction(9, 20)
			player:talk(0,"Maze: Sonata.... of SONGH!!!!")
			player:sendAnimation(162)
		end ]]


		player:sendAction(6,20)
		player:sendMinitext("You cast Sonata of Songh~")
		player:playSound(5)
		player.magic = player.magic - magicCost
		player:sendStatus()

		local partyMember
		for i = 1, #player.group do 
			if (Player(player.group[i])) then
				partyMember = Player(player.group[i])
				if((partyMember.state ~= 1) and (partyMember.m == player.m))then
				 if (partyMember:checkIfCast(hardarmors)) then
						partyMember:setDuration("harden_armor",0)
						partyMember:setDuration("harden_armor_poet",0)
						partyMember:setDuration("thicken_skin_poet",0)
						partyMember:setDuration("shield_of_life_poet",0)
						partyMember:setDuration("elemental_armor_poet",0)
						partyMember:setDuration("harden_armor_mage",0)
						partyMember:setDuration("thicken_skin_mage",0)
						partyMember:setDuration("shield_of_life_mage",0)
						partyMember:setDuration("elemental_armor_mage",0)
						partyMember:setDuration("sonata_of_songh",0)
					end
					if partyMember:checkIfCast(sanctuaries) then
						partyMember:setDuration("sacred_symphony",0)
						partyMember:setDuration("sacred_verse",0)
						partyMember:setDuration("sanctuary",0)
						partyMember:setDuration("sanctuary_mage",0)
						partyMember:setDuration("protect_soul_mage",0)
						partyMember:setDuration("guard_life_mage",0)
						partyMember:setDuration("magic_shield_mage",0)
						partyMember:setDuration("sanctuary_poet",0)
						partyMember:setDuration("protect_soul_poet",0)
						partyMember:setDuration("guard_life_poet",0)
						partyMember:setDuration("magic_shield_poet",0)
					end
					partyMember:setDuration("sonata_of_songh", duration)
					partyMember:sendAction(22, 50)
					partyMember:sendAnimation(630, 2)
					if partyMember.id ~= player.id then
--						player:sendMinitext("You play a wonderful melody.")
						partyMember:sendMinitext(player.name .. " casts Sonata of Songh~")
						partyMember:calcStat()
					end
				end
			end
		end
		player:calcStat()
	end,

	while_cast = function(block)
	end,
	
	recast = function(target)
        target.deduction = target.deduction -.5
		target.armor = target.armor - 10
		target.dam = target.dam + 15
		target:sendStatus()
	end,
	
	uncast = function(target)
        target.deduction = target.deduction +.5
		target.armor = target.armor + 10
		target.dam = target.dam - 15
		target:sendStatus()
	end,

	requirements = function(player)
		local level = 75
		local items = {Item("scroll").id, Item("ink").id}
		local itemAmounts = {1, 1}
		local desc = "Buffs an ally with an invigorating song!"
		return level, items, itemAmounts, desc
	end
}
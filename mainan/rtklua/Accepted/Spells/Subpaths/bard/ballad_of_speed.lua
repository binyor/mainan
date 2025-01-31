ballad_of_speed = {
	cast = function(player)
		local duration = 5000
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
		if (player:hasDuration("ballad_of_speed") == true) then
			player:sendMinitext("You already have that active!")
			return
		end


		player:sendAction(6,20)
		player:sendMinitext("You cast Ballad of Speed~")
		player:playSound(5)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:calcStat()
		player:setAether("ballad_of_speed",45000)
		if player.pk == 1 then
			player:setAether("ballad_of_speed",180000)
		end
		local partyMember
		for i = 1, #player.group do 
			if (Player(player.group[i])) then
				partyMember = Player(player.group[i])
				if((partyMember.state ~= 1) and (partyMember.m == player.m)) then
					if partyMember:checkIfCast(speedbuffs) then
						partyMember:setDuration("ballad_of_speed",0)
					end
					partyMember:setDuration("ballad_of_speed", duration)
					partyMember:sendAnimation(636, 2)
					if partyMember.id ~= player.id then
						player:sendMinitext("You play a wonderful melody.")
						partyMember:sendMinitext(player.name .. " casts Ballad of Speed~")
					end
				end
			end
			partyMember:calcStat()
		end
	end,

	while_cast = function(block)
	end,
	
	recast = function(target)
		target.speed = 45
		target:updateState()
	end,
	
	uncast = function(target)
		target.speed = 90
		target:updateState()
		target:calcStat()
	end,

	requirements = function(player)
		local level = 75
		local items = {Item("scroll").id, Item("ink").id}
		local itemAmounts = {1, 1}
		local desc = "Buffs an ally with an invigorating song!"
		return level, items, itemAmounts, desc
	end
}
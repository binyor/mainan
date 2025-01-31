vampiric_plague = {
	cast = function(player, target)
		if (math.random(1,100000) == 1) then
			botcheck.init(player)
			return
		end
		
		local magicCost = 150

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end

		if (target.blType == BL_PC) then
			player:sendMinitext("It doesn't work.")
			return
		end

		if target:checkIfCast(venoms) then
			player:sendMinitext("Another spell of this type is already cast.")
			return
		end

		player:sendAction(6, 35)
		player:playSound(24)
		player.magic = player.magic - magicCost
		player:sendMinitext("You cast Vampiric Plague.")
		player:sendStatus()

		if (target.blType == BL_MOB) then
			local duration = 30000
			target:setDuration("vampiric_plague",duration)
			target:sendAnimation(454)
			target.attacker = player.ID
			target.registry["plague_damage"] = math.ceil(player.maxMagic * 0.015 + player.maxHealth * 0.015)
			target.registry["plague_attacker"] = player.ID
		end
	end,

    while_cast = function(target)
        if (not target) then return end
        if (target.health <= 1) then
            target:sendAnimation(454)
            target:removeHealth(0)
            return
        end

        local damage = target.registry["plague_damage"]
        local attacker = target.registry["plague_attacker"]
        if (not attacker) then
            target:setDuration("vampiric_plague",0)
            return
        end

        local player = Player(attacker)
        if (not player) then
            target:setDuration("vampiric_plague",0)
            return
        end

        if (damage > 100000) then
            damage = 100000
        elseif (damage < 1) then
            damage = 1
        end

        if (damage >= target.health ) then
            damage = target.health
        end

        if (target.blType == BL_PC and player:canPK(target)) then
            target.attacker = player.ID
            target:removeHealthExtend(damage, 0, 0, 0, 0, 0)
            target:sendAnimation(454)
        elseif (target.blType == BL_MOB) then
            target:removeHealth(damage)
            target:sendAnimation(454)
			for i=1, #player.group do
				if (Player(player.group[i])) then
					local groupMember = Player(player.group[i])
					if (groupMember and groupMember.state == 0 and groupMember.m == target.m) then
						--groupMember:addHealth(math.ceil(damage*0.05),1)
						groupMember.registry["plague_heal"] = groupMember.registry["plague_heal"] + math.ceil(damage*0.05)
					end
				end
            end
        end
	end,
	
 	while_passive = function(player)
		for i=1, #player.group do
			if (Player(player.group[i])) then
				local groupMember = Player(player.group[i])
				if groupMember.registry["plague_heal"] > 0 then
					if (groupMember and groupMember.state ~= 1 and groupMember.m == player.m) then
						groupMember:addHealth(groupMember.registry["plague_heal"],1)
						groupMember.registry["plague_heal"] = 0
						groupMember:sendAnimation(397)
					end
				end
			end
		end
	end, 

	recast = function(target)
	end,

	uncast = function(target)
	end,

	requirements = function(player)
		local level = 59
		local items = {Item("surge").id,0}
		local itemAmounts = {1, 50000}
		local description = "Poisons target for random amount of time. Does 1000 damage a second."
		return level, items, itemAmounts, description
	end
}

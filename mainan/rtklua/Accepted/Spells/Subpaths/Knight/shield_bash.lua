shield_bash = {
	cast = function(player)

		local aethers = 22000
		local damage = math.ceil(player.health * 1.25)
		local magicCost = 1500

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

		if (player:hasDuration("chin_baek_ho_ryung")) then
			damage = math.ceil(damage * 1.5)
		end

		player.magic = player.magic - magicCost
		player:setAether("shield_bash", aethers)
		player:sendAction(1, 30)
		player:talk(2, "~*SLAM*~~!")

		local landed = 0

		local targetpc = getTargetFacing(player, BL_PC)
		local targetmob = getTargetFacing(player, BL_MOB)

		if targetpc ~= nil and player:canPK(targetpc) then
			global_attack.cast(player, targetpc, damage, 0, 307)
			targetpc:sendMinitext(player.name .. " bashed you with their shield.")
			targetpc:sendAnimation(597,2)
			landed = 1
		end
		if targetmob ~= nil then
			targetmob:sendAnimation(597,2)
			global_attack.cast(player, targetmob, damage, 0, 307)
			landed = 1
		end

		if (landed == 1) then
				player:sendAnimation(597,2)
				player.health = math.ceil(player.health * 0.42)
		end

		player:sendStatus()
		player:sendMinitext("You cast Shield Bash.")
		player:setDuration("shield_block", 4000)

	end,

	while_cast = function(block)
	end,

	requirements = function(player)
		local level = 99
		local items = {"dragons_liver", "yellow_amber", "electra", 0}
		local itemAmounts = {2, 10, 2, 75000}
		local description = "Bash your opponent with a shield that deals damage to an enemy and temporarily prevents damage."
		return level, items, itemAmounts, description
	end
}

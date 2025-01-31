hunters_mark = {
    cast = function(player, target)
        local duration = 30000
        local magicCost = 100
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

        if (target.state == 1) then
            player:sendMinitext("Can't hunt dead..")
            return
        end
        if (target.blType == BL_MOB or target.blType == BL_PC) then
            if player.pvp == 1 then
                player:setAether("hunters_mark",40000)
            else
                player:setAether("hunters_mark",3000)
            end
            player:setDuration("hunters_mark",30000)
			player:selfAnimationXY(player.ID, 361, target.x, target.y)
            player.registry["mark_target"] = target.ID
            player:sendMinitext("Target acquired: "..target.name)
        end
    end,

    uncast = function(player, caster)
        caster.registry["mark_target"] = 0
    end,
    

    requirements = function(player)
		local level = 55
		local items = {Item("amethyst").id, Item("gold_acorn").id, 0}
		local itemAmounts = {10, 10, 10000}
		local description = "Mark a target, dealing increased damage and lowers suspicion."
		return level, items, itemAmounts, description
    end
}
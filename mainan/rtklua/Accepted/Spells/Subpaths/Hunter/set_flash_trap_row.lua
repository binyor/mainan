set_flash_trap_row = {
	cast = function(player)
		local dist = 2
		local magic = 320 * (dist * 2)
		local aether = 20000 * dist
		if not player:canCast(1, 1, 0) then
			return
		end
		if player:carnageSpell() then
            return
        end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		if player:canPK(player) then
			player:setAether("set_flash_trap_row", aether)
		end

		local line = line_side(player, dist)
		
		for i = 1, #line do
			player:addNPC("FlashTrapNpc", player.m, line[i][1], line[i][2], 2, 0, 0, player.ID)
		end

		player.magic = player.magic - magic
		player:playSound(0)
		player:sendStatus()
		player:sendAction(6, 35)

		player:sendMinitext("You set a row of traps!")
	end,

	requirements = function(player)
		local level = 55
		local items = {"fine_rabbit_meat", 0}
		local itemAmounts = {1, 250}
		local description = "Set a row of flash traps."
		return level, items, itemAmounts, description
	end
}
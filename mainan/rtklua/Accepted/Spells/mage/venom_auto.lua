venom_auto = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7
		local magicCost = 60
		if (player.magic < magicCost) then
			player:sendMinitext("Not enough mana.")
			return
		end
		player.magic = player.magic - magicCost

		if player.x < 8 then
			maxX = maxX + (8 - player.x)
		end

		if player.y < 8 then
			maxY = maxY + (8 - player.y)
		end

		if player.x > getMapXMax(player.m) - 8 then
			maxX = maxX + 9 - (getMapXMax(player.m) - player.x)
		end

		if player.y > getMapYMax(player.m) - 8 then
			maxY = maxY + 9 - (getMapYMax(player.m) - player.y)
		end

		for x = 0, maxX do
			for y = 0, maxY do
				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms)then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x + x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms)then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y + y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms)then
						table.insert(castable, mob[1])
						break
					end
				end

				local mob = player:getObjectsInCell(
					player.m,
					player.x - x,
					player.y - y,
					BL_MOB
				)

				if #mob > 0 then
					if not mob[1]:checkIfCast(venoms)then
						table.insert(castable, mob[1])
						break
					end
				end
			end

			if #castable > 0 then
				break
			end
		end

		if #castable > 0 then
			if player.alignment == 1 then
				corruption_mage.cast(player, castable[1])
			elseif player.alignment == 2 then
				snake_bite_mage.cast(player, castable[1])
			elseif player.alignment == 3 then
				spirits_leech_mage.cast(player, castable[1])
			else
				venom_mage.cast(player, castable[1])
            end
        else
			player:sendMinitext("No targets available.")
			player:setAether("venom_auto", 300)
		end
	end,

	requirements = function(player)
		local level = 70
		local items = {"red_potion",0}
		local itemAmounts = {2, 15000}
		local description = "Allows you to cast venom more easily."
		return level, items, itemAmounts, description
	end
}

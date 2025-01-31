magis_bane_mage = {
	cast = function(player)
		local castable = {}
		local maxX = 8
		local maxY = 7

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
					if not mob[1]:checkIfCast(curses) or mob[1].cursed == 0 then
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
					if not mob[1]:checkIfCast(curses) or mob[1].cursed == 0 then
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
					if not mob[1]:checkIfCast(curses) or mob[1].cursed == 0 then
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
					if not mob[1]:checkIfCast(curses) or mob[1].cursed == 0 then
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
				deaths_face_mage.cast(player, castable[1])
			elseif player.alignment == 2 then
				unnatural_selection_mage.cast(player, castable[1])
			elseif player.alignment == 3 then
				flaw_mage.cast(player, castable[1])
			else
				vex_mage.cast(player, castable[1])
            end
        else
			player:sendMinitext("No targets available.")
			player:setAether("magis_bane",300)
		end
	end,

	requirements = function(player)
		local level = 80
		local items = {"cursed_ring", "angels_tear", 0}
		local itemAmounts = {1, 1, 10000}
		local description = "Curses the nearest uncursed target with +30 AC."
		return level, items, itemAmounts, description
	end
}

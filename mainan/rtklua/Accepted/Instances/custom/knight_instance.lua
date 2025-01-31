knight_instance_quest = {
	quest = function(maps, owner)
		local player = Player(owner)
		local guitext = ""

		if player.quest["knightq"] == 5 then
			if player.registry["knight_instance"] == 0 then
				player.registry["knight_instance"] = 1
				player.registry["knight_quest_time"] = os.time()

				player:spawn(813, 46, 27, 1)

				setMapAttribute(maps[1], "light", 15)
				setMapAttribute(maps[1], "indoor", 1)
				setMapAttribute(maps[1], "warpOut", 0)
				player:flushKills("southern_ogre")
				player:refresh()
				player:updateState()
			end

			if player.registry["knight_instance"] == 1 then
				if (os.time() > player.registry["knight_quest_time"] + 9) then
					player:spawn(814, 49, 28, 1)
					player.registry["knight_instance"] = 2
				end
			end

			if player.registry["knight_instance"] == 2 then
				if (os.time() > player.registry["Knight_quest_time"] + 44) then
					player:spawn(156, 45, 44, 1)
					player:spawn(156, 53, 44, 1)
					player:spawn(156, 53, 49, 1)
					player.registry["knight_instance"] = 3
				end
			end

			if player.registry["knight_instance"] == 3 then
				if player:killCount("southern_ogre") >= 3 then
					player.registry["knight_quest_time"] = os.time()
					player.registry["knight_instance"] = 4
				end
			end

			if player.registry["knight_instance"] == 4 then
				if (os.time() >= player.registry["knight_quest_time"] + 5) then
					player:msg(
						0,
						"Alcheon(Knight): Good work squire, the king is safe. We have some planning to do. Come speak with me again.",
						player.ID
					)
					local mobs = player:getObjectsInMap(
						player.m,
						BL_MOB
					)
					if #mobs > 0 then
						for g = 1, #mobs do
							mobs[g]:delete()
							mobs[g] = nil
						end
					end
					player:warp(752, 49, 47)
					player.registry["knight_instance"] = 5
				end
			end
		end
	end,
}
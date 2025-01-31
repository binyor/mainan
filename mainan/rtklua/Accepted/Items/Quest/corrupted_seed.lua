corrupted_seed = {
	on_drop = function(player, item)
		if player.mapTitle ~= "Mythic Nexus" then
			return
		end
		if (player.x >= 28 and player.x <= 32 and player.y >= 30 and player.y <= 35) and player.quest["blackmage_trial_of_repudiation"] == 1 then
			player:removeItem("corrupted_seed", 1)
			player.quest["blackmage_trial_complete"] = 1
			player.registry["seedplanted"] = 1
			player:sendAnimation(198, 5)
			player:sendAnimation(196, 5)
			player:sendMinitext("As you place the acorn upon the ground, it quickly disintegrates. The dust remnants swirl, twisting and teeming in all directions, towards all corners of the Nexus.")
		end
	end
}


crude_spellsword = {
	on_drop = function(player, item)
		if player.mapTitle ~= "Dae Shore" then
			return
		end
		if (player.x >= 76 and player.x <= 78 and player.y >= 8 and player.y <= 17) and player.registry["sstrial"] == 3 then
			player.registry["sstrial"] = 4
			player.registry["oncleansing"] = 0
			player:sendAnimation(590, 5)
			player:sendAnimation(589, 5)
			player:sendMinitext("As you dip the blade in the water, you see the spirits of the sea wash over it.")
		end
	end
}

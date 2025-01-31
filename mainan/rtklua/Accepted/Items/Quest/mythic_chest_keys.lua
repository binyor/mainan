rooster_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Rooster1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rooster1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

rooster_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


		if (npc.yname == "Rooster2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rooster2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

rooster_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


	 	if (npc.yname == "Rooster3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rooster3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}



horse_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Horse1chest" and npc.side == 2 then
				player:removeItemSlot(player.invSlot, 1, 9)
				Horse1chest.open(player, npc)
				if(npc.side == 1) then
			player:sendMinitext("It's already unlocked.")
		end
		end
	end
}

horse_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

			if (npc.yname == "Horse2chest" and npc.side == 2) then
				player:removeItemSlot(player.invSlot, 1, 9)
				Horse2chest.open(player,npc)
		if(npc.side == 1) then
			player:sendMinitext("It's already unlocked.")
		end
		end
	end
}

horse_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}
		local chests = {"Horse1chest","Horse2chest"}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

			if (npc.yname == "Horse3chest" and npc.side == 2) then
				player:removeItemSlot(player.invSlot, 1, 9)
				Horse3chest.open(player,npc)
		if(npc.side == 1) then
			player:sendMinitext("It's already unlocked.")
		end
		end
	end
}



rabbit_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Rabbit1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rabbit1chest.open(player, npc)
		if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


rabbit_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Rabbit2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rabbit2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

rabbit_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Rabbit3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rabbit3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}



monkey_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Monkey1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Monkey1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

monkey_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Monkey2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Monkey2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


monkey_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Monkey3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Monkey3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}




dog_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Dog1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dog1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

dog_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


		if (npc.yname == "Dog2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dog2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

dog_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


		if (npc.yname == "Dog3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dog3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}




rat_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Rat1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rat1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

rat_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Rat2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rat2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

rat_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Rat3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Rat3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


ox_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Ox1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Ox1chest.open(player, npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

ox_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Ox2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Ox2chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

ox_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Ox3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Ox3chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}



pig_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Pig1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Pig1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

pig_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Pig2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Pig2chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

pig_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if (npc.yname == "Pig3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Pig3chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


snake_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)

		if npc.yname == "Snake1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Snake1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


snake_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


		if (npc.yname == "Snake2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Snake2chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

snake_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)


		if (npc.yname == "Snake3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Snake3chest.open(player,npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}



sheep_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if npc.yname == "Sheep1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Sheep1chest.open(player, npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

sheep_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if (npc.yname == "Sheep2chest" and npc.side == 2) then
		player:removeItemSlot(player.invSlot, 1, 9)
		Sheep2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

sheep_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if (npc.yname == "Sheep3chest" and npc.side == 2) then
		player:removeItemSlot(player.invSlot, 1, 9)
		Sheep3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}



tiger_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if npc.yname == "Tiger1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Tiger1chest.open(player, npc)
	    if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}

tiger_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if (npc.yname == "Tiger2chest" and npc.side == 2) then
		player:removeItemSlot(player.invSlot, 1, 9)
		Tiger2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}
 
tiger_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if npc.yname == "Tiger3chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Tiger3chest.open(player, npc)
	    if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}




dragon_master_key = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if npc.yname == "Dragon1chest" and npc.side == 2 then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dragon1chest.open(player, npc)	
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


dragon_master_key2 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if (npc.yname == "Dragon2chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dragon2chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}


dragon_master_key3 = {
	use = function(player)
		local t = {graphic = convertGraphic(2454, "item"), color = 0}

--		if player.m ~= 1307 then
--			player:sendMinitext("You can't use this here.")
--			return
--		end

		local npc = getTargetFacing(player, BL_NPC)
		
		if (npc.yname == "Dragon3chest" and npc.side == 2) then
			player:removeItemSlot(player.invSlot, 1, 9)
			Dragon3chest.open(player,npc)
	if(npc.side == 1) then
		player:sendMinitext("It's already unlocked.")
	end
	end
end
}
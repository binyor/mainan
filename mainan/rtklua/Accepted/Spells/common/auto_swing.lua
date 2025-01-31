auto_swing = {
	cast = function(player)
		if not player:canCast(1, 1, 0) then
			return
		end
	
		if (not player:hasDuration("auto_swing")) then
			if player.registry["display_auto_swing"] == 0 then
				player:setDuration("auto_swings",0)
				player:setDuration("auto_swing", 9999999)
			elseif player.registry["display_auto_swing"] == 1 then
				if (not player:hasDuration("auto_swings")) then
					player:setDuration("auto_swing",0)
					player:setDuration("auto_swings",9999999)
					return
				else
					player:setDuration("auto_swings",0)
				end
			end
		else
			player:setDuration("auto_swing", 0)
		end
	end,
	
	while_cast_500 = function(player)
		if (math.random(1,100000) == 1) and (player.state ~= 3) then
			botcheck.init(player)
		end
		if (player.state ~= 0 and player.state ~= 2) then 
			player:setDuration("auto_swing", 0)
			return
		 end
		 local weapon = player:getEquippedItem(EQ_WEAP)
		 if weapon ~= nil then
			 if (weapon.class == 24) then
				 bowAttack(player)
			 else
				 swing2(player)
			 end
		 else
			 swing2(player)
		 end
		player:sendAction(1, 30)
	end,
	
}


auto_swings = {
	while_cast_500 = function(player)
		if (math.random(1,100000) == 1) and (player.state ~= 3) then
			botcheck.init(player)
		end
	
		if (player.state ~= 0 and player.state ~= 2) then 
			player:setDuration("auto_swings", 0)
			return
		end
		local weapon = player:getEquippedItem(EQ_WEAP)
		if weapon ~= nil then
			if (weapon.class == 24) then
				bowAttack(player)
			else
				swing2(player)
			end
		else
			swing2(player)
		end
		player:sendAction(1, 30)
	end,

}
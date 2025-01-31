shot_gun = {
	onEquip = function(player)
		player.registry["damage_shotgun"] = 1
	end,

	onUnequip = function(player)
		player.registry["damage_shotgun"] = 0
	end,


	on_swing = function(player)
		player.registry["damage_shotgun"] = player.registry["damage_shotgun"] + 1
		shot_gun.cast(player)
	end,

	cast = function(player)
		local m = player.m
		local x = player.x
		local y = player.y
		local s = player.side
		local dam = 1
		local mob
		local pc
		local threat
		local weap = player:getEquippedItem(EQ_WEAP)
		local d = player.registry["damage_shotgun"]

		if not player:canAction(1, 1, 0) then
			return
		end
		if not player:canCast(1, 1, 0) then
			return
		end

		player:playSound(59)
		player:playSound(371)
		player:playSound(351)

		for i = 1, 7 do
			mob = getTargetFacing(player, BL_MOB, 0, i)
			pc = getTargetFacing(player, BL_PC, 0, i)

			if mob ~= nil then
				mob:sendAnimation(303)
				mob.attacker = player.ID
				mob.target = player.ID
				if(mob.yname == "thanksgiving_turkey") then
					local turkdam2 = math.ceil(mob.maxHealth * 0.03)
					threat = mob:removeHealthExtend(turkdam2, 0, 0, 0, 0, 0)
					player:addThreat(mob.ID, threat)
					mob:removeHealthExtend(1000, 1, 1, 1, 1, 2)
				end
				threat = mob:removeHealthExtend(1, 1, 1, 1, 1, 0)
				player:addThreat(mob.ID, threat)
				mob:removeHealthExtend(100, 1, 1, 1, 1, 2)
			elseif (pc ~= nil) then
				if (pc.m == 32103) then
					pc.attacker = player.ID
					pc:removeHealth(pc.maxHealth*0.2)
				else
					pc:talk(0,""..pc.name..": Ouch!")
				end
				return
			end

			if s == 0 then
				if getPass(m, x, y - i) > 0 then
					player:sendAnimationXY(302, x, y - i)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 1 then
				if getPass(m, x + i, y) > 0 then
					player:sendAnimationXY(302, x + i, y)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 2 then
				if getPass(m, x, y + i) > 0 then
					player:sendAnimationXY(302, x, y + i)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 3 then
				if getPass(m, x - i, y) > 0 then
					player:sendAnimationXY(302, x - i, y)
					player:playSound(347)
					player:playSound(348)
					return
				end
			end
		end
	end
}






artemiss_bow = {
	onEquip = function(player)
		player.registry["damage_shotgun"] = 1
	end,

	onUnequip = function(player)
		player.registry["damage_shotgun"] = 0
	end,


	on_swing = function(player)
		player.registry["damage_shotgun"] = player.registry["damage_shotgun"] + 1
		artemiss_bow.cast(player)
	end,

	cast = function(player)
		local m = player.m
		local x = player.x
		local y = player.y
		local s = player.side
		local dam = 1
		local mob
		local pc
		local threat
		local weap = player:getEquippedItem(EQ_WEAP)
		local d = player.registry["damage_shotgun"]

		if not player:canAction(1, 1, 0) then
			return
		end
		if not player:canCast(1, 1, 0) then
			return
		end

		player:playSound(59)
		player:playSound(371)
		player:playSound(351)
		local Ingr = player.enchant
		local Dam = player.dam
		local Mgt = player.might
		local Rage = player.rage
		local Inv = 3
		local Crit = 1
	
		if (not player:canCast(1, 1, 0)) then
			return
		end
		local S = math.random(player.minSDam, player.maxSDam)
		damage = (s / 2 * Ingr + Dam * 2.5 + Mgt / 8 + class) * rage * invisible * critical
		for i = 1, 7 do
			mob = getTargetFacing(player, BL_MOB, 0, i)
			pc = getTargetFacing(player, BL_PC, 0, i)

			if mob ~= nil then
				mob:sendAnimation(303)
				mob.attacker = player.ID
				mob.target = player.ID
				threat = mob:removeHealthExtend(1, 1, 1, 1, 1, 0)
				player:addThreat(mob.ID, threat)
				mob:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			elseif (pc ~= nil) then
				if (pc.m == 32103) then
					pc.attacker = player.ID
					pc:removeHealth(pc.maxHealth*0.2)
				else
					pc:talk(0,""..pc.name..": ow")
				end
				return
			end

			if s == 0 then
				if getPass(m, x, y - i) > 0 then
					player:sendAnimationXY(302, x, y - i)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 1 then
				if getPass(m, x + i, y) > 0 then
					player:sendAnimationXY(302, x + i, y)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 2 then
				if getPass(m, x, y + i) > 0 then
					player:sendAnimationXY(302, x, y + i)
					player:playSound(347)
					player:playSound(348)
					return
				end
			elseif s == 3 then
				if getPass(m, x - i, y) > 0 then
					player:sendAnimationXY(302, x - i, y)
					player:playSound(347)
					player:playSound(348)
					return
				end
			end
		end
	end
}

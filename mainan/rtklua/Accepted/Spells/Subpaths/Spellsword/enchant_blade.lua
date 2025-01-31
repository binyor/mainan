enchant_blade = {



	cast = function(player)
		if (not player:canCast(1, 1, 0)) then
			return
		end

		local aethers = 120000
		local duration = 938000

		if player.gmLevel ~= 0 then
			aethers = 1
		end
		if player:carnageSpell() then
            return
        end
		player:removeDuras(lesserFuries)

		if (player:hasDuration("enchant_blade") == true and player.rage == 8) then
			-- cast rage2
			if (player.magic < 7200) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player.rage = 14
			player.magic = player.magic - 7200
			player:sendAnimation(501)
			player:playSound(705)
			player:sendMinitext("Energy pours into your weapon.")
			player:sendAction(6, 35)
			player.registry["chungryongragelevel"] = 2
			player:setAether("enchant_blade", aethers)

			player:calcStat()
		elseif (player:hasDuration("enchant_blade") == true and player.rage == 14) then
			-- cast rage3
			if (player.magic < 18050) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player.rage = 20
			player.magic = player.magic - 18050
			player:sendAnimation(501)
			player:playSound(705)
			player:sendMinitext("Your weapon is pure ethereal rage.")
			player.registry["chungryongragelevel"] = 3
			player:setAether("enchant_blade", aethers)

			player:sendAction(6, 35)

			--player.armor = player.armor + 5
			player:calcStat()
		elseif (player:hasDuration("enchant_blade") == true and player.rage == 20) then
			-- cast rage4
			if (player.magic < 33800) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player.rage = 26
			player.magic = player.magic - 33800
			player:sendAnimation(501)
			player:playSound(705)
			player:sendMinitext("Destruction's rage is unlocked.")
			player:sendAction(6, 35)
			player.registry["chungryongragelevel"] = 4
			player:setAether("enchant_blade", aethers)

			--player.armor = player.armor + 15
			player:calcStat()
		elseif (player:hasDuration("enchant_blade") == true and player.rage == 26) then
			-- cast rage5
			if (player.magic < 72200) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player.rage = 36
			player.magic = player.magic - 72200
			player:sendAnimation(501)
			player:playSound(705)
			player:sendMinitext("Your weapon is phasing through reality.")
			player:sendAction(6, 35)
			player.registry["chungryongragelevel"] = 5
			player:setAether("enchant_blade", aethers)

			--player.armor = player.armor + 30
			player:calcStat()
		elseif (player:hasDuration("enchant_blade") == true and player.rage == 36) then
			-- cast rage6
			if (player.magic < 145800) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player.rage = 81

			--player.magic = player.magic - 145800
			player.magic = 0
			player:sendAnimation(501)
			player:playSound(705)
			player:sendMinitext("You feel the hand of destruction guiding you.")
			player:sendAction(6, 35)
			player.registry["chungryongragelevel"] = 6
			player:setAether("enchant_blade", aethers)

			--player.armor = player.armor + 50
			player:calcStat()
		elseif (player:hasDuration("enchant_blade") == false) then
			if (player.magic < 2000) then
				player:sendMinitext("You do not have enough mana.")
				return
			end

			player:removeDuras(furies)
			player.rage = 8
			player.magic = player.magic - 2000
			player:sendAnimation(501)
			player:playSound(705)
			player.registry["chungryongragelevel"] = 1

			-- setting this to calculate the end ac and vita
			player:setDuration("enchant_blade", duration)
			player:setAether("enchant_blade", aethers)
			player:sendMinitext("You enchant your weapon with magic.")
			player:sendAction(6, 35)
			player:calcStat()
		end
	end,

	recast = function(player)
		-- added to handle if player dc and/or logs off and back on

		local rage = 1
		local armor = 0

		if (player.registry["chungryongragelevel"] == 1) then
			rage = 8
		end
		if (player.registry["chungryongragelevel"] == 2) then
			rage = 14
		end
		if (player.registry["chungryongragelevel"] == 3) then
			rage = 20
			armor = 5
		end
		if (player.registry["chungryongragelevel"] == 4) then
			rage = 26
			armor = 15
		end
		if (player.registry["chungryongragelevel"] == 5) then
			rage = 36
			armor = 30
		end
		if (player.registry["chungryongragelevel"] == 6) then
			rage = 81
			armor = 50
		end

		player.rage = rage
		player.armor = player.armor + armor
		player:sendStatus()
	end,

	uncast = function(player)
		player.rage = 1
		player.registry["energyShield"] = 0
		if (player.registry["chungryongragelevel"] == 1) then
			player.health = player.health *.8
		end
		if (player.registry["chungryongragelevel"] == 2) then
			player.health = player.health *.8
		end
		if (player.registry["chungryongragelevel"] == 3) then
			player.health = player.health *.8
			player.armor = player.armor - 5
		end
		if (player.registry["chungryongragelevel"] == 4) then
			player.health = player.health *.6
			player.armor = player.armor - 15
		end
		if (player.registry["chungryongragelevel"] == 5) then
			player.health = player.health *.4
			player.armor = player.armor - 30
		end
		if (player.registry["chungryongragelevel"] == 6) then
			player.health = player.health *.1
			player.armor = player.armor - 50
		end
		player.registry["chungryongragelevel"] = 0
		player:sendStatus()
	end,

	passive_on_swing = function(player)
		local strikeChance = 0
		local paraChance = 0
		local shieldGain = math.ceil(player.maxMagic * 0.05)
		local shieldChance = 0
		local shieldCap = math.ceil(player.maxMagic * 0.50)
		if(player.rage >= 8) then
			paraChance = math.random(1,18)
		end
		if(player.rage >= 14) then
			strikeChance = math.random(1,18)
		end
		if(player.rage >= 20) then
			paraChance = math.random(1,12)
		end
		if(player.rage >= 26) then
			strikeChance = math.random(1,8)
		end
		if(player.rage >= 36) then
			shieldChance = math.random(1,4)
		end
		if(player.rage >= 81) then
			local randchan = math.random(1,40)
			if randchan == 1 then
				local hfCost = 100000
				if player.magic >= hfCost then
					local mapstruck = player:getObjectsInArea(BL_MOB)
					--local struck
					local struck = {}
					local hit
					if mapstruck ~= nil then
						if #mapstruck > 0 then
							for i=1, #mapstruck do
								--if(distance(player,mapstruck[i] < 8)) then
								if (distance(player,mapstruck[i]) < 8) then
									table.insert(struck,mapstruck[i])
								end
							end
							if #struck > 0 then --new check
								for p=1, #struck do
									if struck[p].isBoss == 1 then
										hit = struck[p]
										break--when it finds a boss, stop looking for other mobs
									end
									hit = struck[math.random(1,#struck)]
								end
							end
						end
					end
					if hit ~= nil then
						player.magic = player.magic - hfCost
						local hfDamage = math.ceil((player.maxHealth * 0.42) + (player.maxMagic * 1.69))
						player:throw(hit.x,hit.y, 1268, 1, 1)
						hit:sendAnimation(591)
						hit.attacker = player.ID
						hit:removeHealthExtend(hfDamage, 1, 1, 1, 1, 0)
						player:addThreat(hit.ID, hfDamage)
						player:talk(2,"BEGONE HERETIC!")
						player:sendMinitext("Your sword bursts with magical energy.")
						player:calcStat()
					end
				else
					player:sendMinitext("You try to expend spirit, but lack the energy..")
				end
			end
		end
		if not player.backstab and not player.flank or not player.extendHit then
			local pc = getTargetFacing(player, BL_PC)
			local mob = getTargetFacing(player, BL_MOB)
			if mob ~= nil then
				if shieldChance == 1 then
					player.registry["energyShield"] = player.registry["energyShield"] + shieldGain
					if player.registry["energyShield"] >= shieldCap then
						player.registry["energyShield"] = shieldCap
					end
					player:guitext("Energy shield +" ..player.registry["energyShield"].. " ")
					player:sendAnimation(488)
				end
				if (paraChance == 1) and (mob.isBoss == 0) then
					paralyze_spellsword.cast(player, mob)
				end
				if strikeChance == 1 then
					enchantblade_zap.cast(player, mob)
				end
			end
			if pc ~= nil then
				if strikeChance == 1 then
					enchantblade_zap.cast(player, pc)
				end
			end
		else
			local flankTargets = {}
			local backstabTargets = {}
			if player.backstab then
				backstabTargets = getTargetsBackstab(player, BL_MOB)
			end
			if player.flank then
				flankTargets = getTargetsFlank(player, BL_MOB)
			end
			if #backstabTargets > 0 then
				for i = 1, #backstabTargets do
					if paraChance == 1 and backstabTargets[i].isBoss == 0 then
						paralyze_spellsword.cast(player, backstabTargets[i]) 
					end
					if strikeChance == 1 then
						enchantblade_zap.cast(player, backstabTargets[i])
					end
				end
			end
			if #flankTargets > 0 then
				for i = 1, #flankTargets do
					if paraChance == 1 and flankTargets[i].isBoss == 0 then
						paralyze_spellsword.cast(player, flankTargets[i])
					end
					if strikeChance == 1 then
						enchantblade_zap.cast(player, flankTargets[i])
					end
				end
			end
			if (#backstabTargets == 0) and (#flankTargets == 0) then
				local x = {-1, -1,  0,  0,  1,  1, -2,  2}
				local y = {-1,  1,  2, -2, -1,  1,  0,  0}
				for i=1, #x do
					local hit = player:getObjectsInCell(player.m, player.x+x[i], player.y+y[i], BL_MOB)
					for j=1, #hit do
						if(player.rage >= 8) then
							paraChance = math.random(1,18)
						end
						if(player.rage >= 14) then
							strikeChance = math.random(1,18)
						end
						if(player.rage >= 20) then
							paraChance = math.random(1,12)
						end
						if(player.rage >= 26) then
							strikeChance = math.random(1,8)
						end

						if strikeChance == 1 then enchantblade_zap.cast(player, hit[j]) end
						if (hit[j].isBoss == 0) and (paraChance == 1) then paralyze_spellsword.cast(player,hit[j]) end

					end
				end
			end
			if shieldChance == 1 then
				player.registry["energyShield"] = player.registry["energyShield"] + shieldGain
				if player.registry["energyShield"] >= shieldCap then
					player.registry["energyShield"] = shieldCap
				end
				player:guitext("Energy shield +" ..player.registry["energyShield"].. " ")
				player:sendAnimation(488)
			end
		end
	end,






	requirements = function(player)
		local level = 99
		local items = {
			Item("ice_sabre").id,
			Item("flamefang").id,
			Item("frozen_spear").id,
			Item("spike").id,
			Item("dark_dagger").id,
			Item("dark_amber").id,
			Item("yellow_amber").id,
			0
		}
		local itemAmounts = {1, 1, 1,1,1,100,60, 50000}
		local description = "Fury with incremental power increase."

		if (Config.freeNpcSubpathsEnabled) then
			items = {}
			itemAmounts = {}
		end

		return level, items, itemAmounts, description
	end
}

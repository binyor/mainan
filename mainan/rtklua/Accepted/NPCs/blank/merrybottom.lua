merrybottom_the_elf = {

	click = async(function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		player:dialogSeq({t,"What a rude person, don't you know what day it is?"}, 0)
		
	end),

	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
		if string.match(speech, "merry christmas") or  string.match(speech, "merry xmas") or
		string.match(speech, "feliz navidad") or string.match(speech, "feliz navidad") or
		string.match(speech, "selamat hari natal") then
			npc:talk(0, npc.name..": Merry Christmas to you too, "..player.name..".")
			npc:talk(0, npc.name..": Come aboard if you want to come to the North Pole, but beware,")
			npc:talk(0, npc.name..": it's dangerous this time of year.")
			if npc.gameRegistry["xmas_2020"] < 1 then
				npc:talk(0, npc.name..": The elves are still stressed out.")
			end
			if player.level < 99 then
				--npc:talk(0, player.name.." is pre 99 tier.")
				player:warp(8400, 65, 65)
			elseif ((player.baseHealth < 160000) and (player.baseMagic < 80000)) then
				--npc:talk(0, player.name.." is 99 tier.")
				player:warp(8412, 65, 65)
			elseif ((player.baseHealth < 320000) and (player.baseMagic < 160000)) then
				player:warp(8450, 65, 65)
				--npc:talk(0, player.name.." is Il san tier.")
			else--Ee san+
				player:warp(8424, 65, 65)
			end
			player:sendMinitext("Merrybottom sends you on his boat to the North Pole.")
		end
	end)
}

santa_claus = {
	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID







		
		if string.match(speech, "merry christmas") or  string.match(speech, "merry xmas") or
		string.match(speech, "feliz navidad") or string.match(speech, "feliz navidad") or
		string.match(speech, "selamat hari natal") then
			
			if npc.gameRegistry["xmas_2020"] < 1 then
				local elfleft = math.ceil(25 - core.gameRegistry["xmas_2020_count"])
--				npc:talk(0, npc.name..": Sorry "..player.name..", we still need more candy canes.")
				npc:talk(0, npc.name..": Sorry, "..player.name..". "..elfleft.." elves still need help before I can give out gifts!")
				return
			end
			if player.quest["stressed_elf"] < 2 then
				npc:talk(0, npc.name..": Sorry "..player.name..", Christmas is about giving, not taking.")
				return
			end
			if player.quest["stressed_elf"] >= 3 then
				npc:talk(0, npc.name..": Move along "..player.name..", you've already gotten one.")
				return
			end
			local rarity = 0
			npc:talk(0, npc.name..": Ho ho ho! Merry Christmas to you too, "..player.name..".")
			npc:talk(0, npc.name..": Here is your gift!")
			local randRarity = math.random(200)
			if randRarity == 1 then
				rarity = 1
				--legendaries
			elseif randRarity < 21 then
				--rares
				rarity = 2
			else
				--what I'm getting D:
				rarity = 3
			end
			local loot = {{"sun_tigress","sun_tiger_mail","sun_drapery","ice_gown","ice_robes","ice_garb","sun_mantle","sun_clothes","sun_armor_dress","holiday_turtle_shell","experience_envelope_pack_30_days","flameblade"},
			{"experience_envelope_pack_7_days","rich_fortune","shee_lee_ring","floating_ring_of_substratum","jeweled_ring_of_substratum","small_ring_of_substratum","malevolent_bow","enchanted_blood","enchanted_surge","enchanted_charm","enchanted_spike","random_mount_i","random_mount_ii","qui_hyang"},
			{"blood","spike","charm","surge","steelthorn","jolt_trident","frozen_spear","flamefang","key_to_wind","key_to_thunder","military_fork","whisper_bracelet","purified_water","sen_glove","tao_stone","winter_scepter","big_axe","plain_yellow_bracelet","plain_white_bracelet","plain_dark_bracelet","plain_amber_bracelet","wand_of_fire","ambrosia","trunks","bikini","coal","jolly_stocking","gum_drop_stocking","merrybottom_stocking","cupcake_stocking","broom_stick","random_faerie_wings_box"}}
			
			local reward = loot[rarity][math.random(#loot[rarity])]
			if rarity == 1 then
				broadcast(-1, npc.name..": "..player.name.." just got a "..string.gsub(reward, "_", " ").."!")
			end
			npc:talk(0, npc.name..": "..player.name.." just got a "..string.gsub(reward, "_", " ").."!")
			player:addItem(reward, 1)
			player:sendAnimation(335)
			player.quest["stressed_elf"] = 3
		end
	end)

}

cupcake_the_elf = {
    click = async(function(player,npc)

        local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
        player.npcGraphic = t.graphic
        player.npcColor = t.color
        player.dialogType = 0
        player.lastClick = npc.ID
    
		local quest = player.quest["stressed_elf"]
    
        if quest == 0 then
            player:dialogSeq({t,"Merry Christmas, "..player.name.."!","As you can see, the elves are real upset.. We're SOOO behind on presents!","And when presents are behind, Santa takes it out on us.."},1)

			local elfFirst = {"Johnny","Blitz","Twinkle","Wayne","Zippy","Louie","Cockle","Rumpert","George","Gregg","Happy","Frothy","Michael","Grint","Buddy","Randy","Chuck","Nutmeg","Jack","Pop","Gil","Lanthy"}
			local elfLast = {"Merrybottom","Cupcake","Twinkle-toe","Claus","Peppermint","Butterscotch","Smores","Sprinklepie"}	
			target = elfFirst[math.random(#elfFirst)].." "..elfLast[math.random(#elfLast)]
			player.registryString["elf"] = target
			player.quest["stressed_elf"] = 1	
            player:dialogSeq({t,"Want to help us out!?",
			target.." is looking exhausted, would you mind finding him some candy canes to help get him back to work?",
			"If we don't finish soon, Santa won't be happy.. and we don't want that.\n\n**flinches**",
			"--Use [[U]] to interact with the candy cane and the elf.--"},0)
--			player.registryString["elf"] = target
--			player.quest["stressed_elf"] = 1
		elseif quest == 1 then
			target = player.registryString["elf"]
		    player:dialogSeq({t,"Want to help us out!?",
			target.." is looking exhausted, would you mind finding him some candy canes to help get him back to work?",
			"If we don't finish soon, Santa won't be happy.. and we don't want that.\n\n**flinches**",
			"--Use [[U]] to interact with the candy cane and the elf.--"},0)
		elseif quest == 2 then
			target = player.registryString["elf"]
			if npc.gameRegistry["xmas_2020"] == 0 then
				local elfleft = math.ceil(25 - core.gameRegistry["xmas_2020_count"])
				player:dialogSeq({t,"Thank you for helping "..target,
				"We still need "..elfleft.." more elves to finish!"},0)
			else
				player:dialogSeq({t,"Thank you for helping "..target,
				target.." got everything ready now and is able to visit Santa."},0)
		    end
		end
	end),
	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
		if string.match(speech, "merry christmas") or  string.match(speech, "merry xmas") or
		string.match(speech, "feliz navidad") or string.match(speech, "feliz navidad") or
		string.match(speech, "selamat hari natal") then
			cupcake_the_elf.click(player, npc)
		end
	end)
}

xmas_yeti = {
	on_spawn = function(mob)
		mob.registry["yeti_zap"] = os.time()
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		--mob:talk(1,"move")
		xmas_yeti.aoeWarn(mob)
		
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end
		local healAmount = 1000
		if string.match(mob.mapTitle, 1) then
			healAmount = 5000
		elseif string.match(mob.mapTitle, 2) then
			healAmount = 20000
		end
		if (os.time() % 3 == 0 and mob.paralyzed == true) then
			local paraHeal = math.random(1, 2)
			if (paraHeal == 1) then
				mob:sendAnimation(5)
				mob:playSound(708)
				mob.attacker = mob.ID
				mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			end
		end
		
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target)
		--mob:talk(1,"attack")
		xmas_yeti.aoeWarn(mob)
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end		
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		for i = 1, 10 do
			mob.registry["target"..i.."x"] = 0
			mob.registry["target"..i.."y"] = 0
		end
		mob.registry["targets"] = 0
		mob.registry["yeti_zap"] = 0
		mob.registry["yeti_aoe"] = 0
		mob_ai_mythic.after_death(mob)
	end,
	aoe = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if targets[i].state ~= 1 then
						if distance(targets[i], mob) <= 2 then
							damage = targets[i].maxHealth * 0.075
							area = true
						elseif distance(targets[i], mob) == 3 then
							damage = targets[i].maxHealth * 0.025
							area = true
						end
						targets[i].attacker = mob.ID
						targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
					end
				end
			end
		end
		if area == true then
			mob:sendAction(1, 80)
			mob:sendAnimation(598)
			mob.registry["yeti_aoe"] = os.time() + 9
		end
	end,
	aoeWarn = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local warning = 0
		if (os.time() + 3 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 2 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 1 == mob.registry["yeti_aoe"]) then
			warning = 247	
		end
		if targets ~= nil then
			if #targets > 0 then
				--mob:sendAction(1, 80)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 3 then
						targets[i]:sendAnimation(warning)
					end
				end
			end
		end
	end,
	ice_spike = function(mob)--not in use
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if targets[i].state == 1 then
						break
					end
					if distance(targets[i], mob) <= 9 then
						damage = targets[i].maxHealth * 0.35
					elseif distance(targets[i], mob) < 13 then
						damage = targets[i].maxHealth * 0.025
					end
					targets[i].attacker = mob.ID
					targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				end
			end
		end
		if area == true then
			mob:sendAction(2, 160)
			mob.registry["yeti_zap"] = os.time() + 7
		end
	end,
	ice_spike_targets = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local target = {}
		local targetcount = 0
		local ani = 0
		if mob.registry["yeti_zap"] - 2 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(246, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] - 1 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(247, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] == os.time() then
			if mob.registry["targets"] > 0 then
				local cells 
				for i = 1, mob.registry["targets"] do
					cells = mob:getObjectsInCell(mob.m, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"], BL_PC)
					if cells ~= nil then
						if #cells > 0 then
							for j = 1, #cells do
								if cells[j].state ~= 1 then
									cells[j].attacker = mob.ID
									cells[j]:removeHealthExtend(cells[j].maxHealth * 0.36, 0, 0, 0, 0, 0)
								end
							end
						end
					end
					mob:sendAnimationXY(633, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
					
				end
			end
		end
		if mob.registry["yeti_zap"] > os.time() then
			return
		end
		if targets ~= nil then
			if #targets > 0 then
				targetcount = math.ceil(#targets / 3)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 12 then
						table.insert(target, targets[i])
					end
				end
				if #target > 0 then
					for i = 1, targetcount do
						local rand = math.random(#target)
						mob.registry["target"..i.."x"] = target[math.random(rand)].x
						mob.registry["target"..i.."y"] = target[math.random(rand)].y
					end
					mob.registry["targets"] = targetcount
				end
				mob:talk(2, "**"..mob.name.." summons power**")
				mob:sendAction(2, 160)
				mob.registry["yeti_zap"] = os.time() + math.random(6,9)
				
			end
		end
	end
}

xmas_yeti2 = {
	on_spawn = function(mob)
		mob.registry["yeti_zap"] = os.time()
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		--mob:talk(1,"move")
		xmas_yeti.aoeWarn(mob)
		
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end
		local healAmount = 1000
		if string.match(mob.mapTitle, 1) then
			healAmount = 5000
		elseif string.match(mob.mapTitle, 2) then
			healAmount = 20000
		end
		if (os.time() % 3 == 0 and mob.paralyzed == true) then
			local paraHeal = math.random(1, 2)
			if (paraHeal == 1) then
				mob:sendAnimation(5)
				mob:playSound(708)
				mob.attacker = mob.ID
				mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			end
		end
		
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target)
		--mob:talk(1,"attack")
		xmas_yeti.aoeWarn(mob)
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end		
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		for i = 1, 10 do
			mob.registry["target"..i.."x"] = 0
			mob.registry["target"..i.."y"] = 0
		end
		mob.registry["targets"] = 0
		mob.registry["yeti_zap"] = 0
		mob.registry["yeti_aoe"] = 0
		mob_ai_mythic.after_death(mob)
	end,
	aoe = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if targets[i].state ~= 1 then
						if distance(targets[i], mob) <= 2 then
							damage = targets[i].maxHealth * 0.075
							area = true
						elseif distance(targets[i], mob) == 3 then
							damage = targets[i].maxHealth * 0.025
							area = true
						end
						targets[i].attacker = mob.ID
						targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
					end
				end
			end
		end
		if area == true then
			mob:sendAction(1, 80)
			mob:sendAnimation(598)
			mob.registry["yeti_aoe"] = os.time() + 9
		end
	end,
	aoeWarn = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local warning = 0
		if (os.time() + 3 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 2 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 1 == mob.registry["yeti_aoe"]) then
			warning = 247	
		end
		if targets ~= nil then
			if #targets > 0 then
				--mob:sendAction(1, 80)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 3 then
						targets[i]:sendAnimation(warning)
					end
				end
			end
		end
	end,
	ice_spike = function(mob)--not in use
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if distance(targets[i], mob) <= 9 then
						damage = targets[i].maxHealth * 0.35
					elseif distance(targets[i], mob) < 13 then
						damage = targets[i].maxHealth * 0.025
					end
					targets[i].attacker = mob.ID
					targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				end
			end
		end
		if area == true then
			mob:sendAction(2, 160)
			mob.registry["yeti_zap"] = os.time() + 7
		end
	end,
	ice_spike_targets = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local target = {}
		local targetcount = 0
		local ani = 0
		if mob.registry["yeti_zap"] - 2 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(246, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] - 1 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(247, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] == os.time() then
			if mob.registry["targets"] > 0 then
				local cells 
				for i = 1, mob.registry["targets"] do
					cells = mob:getObjectsInCell(mob.m, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"], BL_PC)
					if cells ~= nil then
						if #cells > 0 then
							for j = 1, #cells do
								if cells[j].state ~= 1 then
									cells[j].attacker = mob.ID
									cells[j]:removeHealthExtend(cells[j].maxHealth * 0.36, 0, 0, 0, 0, 0)
								end
							end
						end
					end
					mob:sendAnimationXY(633, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
					
				end
			end
		end
		if mob.registry["yeti_zap"] > os.time() then
			return
		end
		if targets ~= nil then
			if #targets > 0 then
				targetcount = math.ceil(#targets / 3)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 12 then
						table.insert(target, targets[i])
					end
				end
				if #target > 0 then
					for i = 1, targetcount do
						local rand = math.random(#target)
						mob.registry["target"..i.."x"] = target[math.random(rand)].x
						mob.registry["target"..i.."y"] = target[math.random(rand)].y
					end
					mob.registry["targets"] = targetcount
				end
				mob:talk(2, "**"..mob.name.." summons power**")
				mob:sendAction(2, 160)
				mob.registry["yeti_zap"] = os.time() + math.random(7,10)
				
			end
		end
	end
}

xmas_yeti4 = {
	on_spawn = function(mob)
		mob.registry["yeti_zap"] = os.time()
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		--mob:talk(1,"move")
		xmas_yeti.aoeWarn(mob)
		
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end
		local healAmount = 1000
		if string.match(mob.mapTitle, 1) then
			healAmount = 5000
		elseif string.match(mob.mapTitle, 2) then
			healAmount = 20000
		end
		if (os.time() % 3 == 0 and mob.paralyzed == true) then
			local paraHeal = math.random(1, 2)
			if (paraHeal == 1) then
				mob:sendAnimation(5)
				mob:playSound(708)
				mob.attacker = mob.ID
				mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			end
		end
		
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target)
		--mob:talk(1,"attack")
		xmas_yeti.aoeWarn(mob)
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end		
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		for i = 1, 10 do
			mob.registry["target"..i.."x"] = 0
			mob.registry["target"..i.."y"] = 0
		end
		mob.registry["targets"] = 0
		mob.registry["yeti_zap"] = 0
		mob.registry["yeti_aoe"] = 0
		mob_ai_mythic.after_death(mob)
	end,
	aoe = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if targets[i].state ~= 1 then
						if distance(targets[i], mob) <= 2 then
							damage = targets[i].maxHealth * 0.075
							area = true
						elseif distance(targets[i], mob) == 3 then
							damage = targets[i].maxHealth * 0.025
							area = true
						end
						targets[i].attacker = mob.ID
						targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
					end
				end
			end
		end
		if area == true then
			mob:sendAction(1, 80)
			mob:sendAnimation(598)
			mob.registry["yeti_aoe"] = os.time() + 9
		end
	end,
	aoeWarn = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local warning = 0
		if (os.time() + 3 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 2 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 1 == mob.registry["yeti_aoe"]) then
			warning = 247	
		end
		if targets ~= nil then
			if #targets > 0 then
				--mob:sendAction(1, 80)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 3 then
						targets[i]:sendAnimation(warning)
					end
				end
			end
		end
	end,
	ice_spike = function(mob)--not in use
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if distance(targets[i], mob) <= 9 then
						damage = targets[i].maxHealth * 0.35
					elseif distance(targets[i], mob) < 13 then
						damage = targets[i].maxHealth * 0.025
					end
					targets[i].attacker = mob.ID
					targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				end
			end
		end
		if area == true then
			mob:sendAction(2, 160)
			mob.registry["yeti_zap"] = os.time() + 7
		end
	end,
	ice_spike_targets = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local target = {}
		local targetcount = 0
		local ani = 0
		if mob.registry["yeti_zap"] - 2 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(246, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] - 1 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(247, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] == os.time() then
			if mob.registry["targets"] > 0 then
				local cells 
				for i = 1, mob.registry["targets"] do
					cells = mob:getObjectsInCell(mob.m, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"], BL_PC)
					if cells ~= nil then
						if #cells > 0 then
							for j = 1, #cells do
								if cells[j].state ~= 1 then
									cells[j].attacker = mob.ID
									cells[j]:removeHealthExtend(cells[j].maxHealth * 0.36, 0, 0, 0, 0, 0)
								end
							end
						end
					end
					mob:sendAnimationXY(633, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
					
				end
			end
		end
		if mob.registry["yeti_zap"] > os.time() then
			return
		end
		if targets ~= nil then
			if #targets > 0 then
				targetcount = math.ceil(#targets / 3)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 12 then
						table.insert(target, targets[i])
					end
				end
				if #target > 0 then
					for i = 1, targetcount do
						local rand = math.random(#target)
						mob.registry["target"..i.."x"] = target[math.random(rand)].x
						mob.registry["target"..i.."y"] = target[math.random(rand)].y
					end
					mob.registry["targets"] = targetcount
				end
				mob:talk(2, "**"..mob.name.." summons power**")
				mob:sendAction(2, 160)
				mob.registry["yeti_zap"] = os.time() + math.random(7,10)
				
			end
		end
	end
}



xmas_yeti3 = {
	on_spawn = function(mob)
		mob.registry["yeti_zap"] = os.time()
	end,

	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,

	move = function(mob, target)
		--mob:talk(1,"move")
		xmas_yeti.aoeWarn(mob)
		
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end
		local healAmount = 1000
		if string.match(mob.mapTitle, 1) then
			healAmount = 5000
		elseif string.match(mob.mapTitle, 2) then
			healAmount = 20000
		end
		if (os.time() % 3 == 0 and mob.paralyzed == true) then
			local paraHeal = math.random(1, 2)
			if (paraHeal == 1) then
				mob:sendAnimation(5)
				mob:playSound(708)
				mob.attacker = mob.ID
				mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			end
		end
		
		mob_ai_basic.move(mob, target)
	end,

	attack = function(mob, target)
		--mob:talk(1,"attack")
		xmas_yeti.aoeWarn(mob)
		if mob.blind == true then
			if math.random(100) > 70 then
				if mob.registry["yeti_aoe"] <= os.time() then
					xmas_yeti.aoe(mob)
				end
				if mob.registry["yeti_zap"] <= os.time() then
					xmas_yeti.ice_spike_targets(mob)
				end
			end
		else
			if mob.registry["yeti_aoe"] <= os.time() then
				xmas_yeti.aoe(mob)
			end
			if mob.registry["yeti_zap"] <= os.time() then
				xmas_yeti.ice_spike_targets(mob)
			end
		end		
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		for i = 1, 10 do
			mob.registry["target"..i.."x"] = 0
			mob.registry["target"..i.."y"] = 0
		end
		mob.registry["targets"] = 0
		mob.registry["yeti_zap"] = 0
		mob.registry["yeti_aoe"] = 0
		mob_ai_mythic.after_death(mob)
	end,
	aoe = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if targets[i].state ~= 1 then
						if distance(targets[i], mob) <= 2 then
							damage = targets[i].maxHealth * 0.125
							area = true
						elseif distance(targets[i], mob) == 3 then
							damage = targets[i].maxHealth * 0.075
							area = true
						end
						targets[i].attacker = mob.ID
						targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
					end
				end
			end
		end
		if area == true then
			mob:sendAction(1, 80)
			mob:sendAnimation(598)
			mob.registry["yeti_aoe"] = os.time() + 5
		end
	end,
	aoeWarn = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local warning = 0
		if (os.time() + 3 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 2 == mob.registry["yeti_aoe"]) then
			warning = 246
		elseif (os.time() + 1 == mob.registry["yeti_aoe"]) then
			warning = 247	
		end
		if targets ~= nil then
			if #targets > 0 then
				--mob:sendAction(1, 80)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 3 then
						targets[i]:sendAnimation(warning)
					end
				end
			end
		end
	end,
	ice_spike = function(mob)--not in use
		local targets = mob:getObjectsInArea(BL_PC)
		local area = false
		local damage = 0
		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do
					if distance(targets[i], mob) <= 9 then
						damage = targets[i].maxHealth * 0.35
					elseif distance(targets[i], mob) < 13 then
						damage = targets[i].maxHealth * 0.025
					end
					targets[i].attacker = mob.ID
					targets[i]:removeHealthExtend(damage, 0, 0, 0, 0, 0)
				end
			end
		end
		if area == true then
			mob:sendAction(2, 160)
			mob.registry["yeti_zap"] = os.time() + 7
		end
	end,
	ice_spike_targets = function(mob)
		local targets = mob:getObjectsInArea(BL_PC)
		local target = {}
		local targetcount = 0
		local ani = 0
		if mob.registry["yeti_zap"] - 2 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(246, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] - 1 == os.time() then
			if mob.registry["targets"] > 0 then
				for i = 1, mob.registry["targets"] do
					mob:sendAnimationXY(247, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
				end
			end
		elseif mob.registry["yeti_zap"] == os.time() then
			if mob.registry["targets"] > 0 then
				local cells 
				for i = 1, mob.registry["targets"] do
					cells = mob:getObjectsInCell(mob.m, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"], BL_PC)
					if cells ~= nil then
						if #cells > 0 then
							for j = 1, #cells do
								if cells[j].state ~= 1 then
									cells[j].attacker = mob.ID
									cells[j]:removeHealthExtend(cells[j].maxHealth * 0.36, 0, 0, 0, 0, 0)
								end
							end
						end
					end
					mob:sendAnimationXY(633, mob.registry["target"..i.."x"], mob.registry["target"..i.."y"])
					
				end
			end
		end
		if mob.registry["yeti_zap"] > os.time() then
			return
		end
		if targets ~= nil then
			if #targets > 0 then
				targetcount = math.ceil(#targets / 3)
				for i = 1, #targets do
					if distance(targets[i], mob) <= 12 then
						table.insert(target, targets[i])
					end
				end
				if #target > 0 then
					for i = 1, targetcount do
						local rand = math.random(#target)
						mob.registry["target"..i.."x"] = target[math.random(rand)].x
						mob.registry["target"..i.."y"] = target[math.random(rand)].y
					end
					mob.registry["targets"] = targetcount
				end
				mob:talk(2, "**"..mob.name.." summons power**")
				mob:sendAction(2, 160)
				mob.registry["yeti_zap"] = os.time() + math.random(3,6)
				
			end
		end
	end
}

angry_elf = {
	on_spawn = function(mob)

		local elfFirst = {"Johnny","Blitz","Twinkle","Wayne","Zippy","Louie","Cockle","Rumpert","George","Gregg","Happy","Frothy","Michael","Grint","Buddy","Randy","Chuck","Nutmeg","Jack","Pop","Gil","Lanthy"}
		local elfLast = {"Merrybottom","Cupcake","Twinkle-toe","Claus","Peppermint","Butterscotch","Smores","Sprinklepie"}	
		mob.gfxClone = 1
		mob.gfxCrown = -1
		mob.gfxMantle = -1
		mob.gfxShield = -1
		mob.gfxFace = math.random(201,238)
		if math.random(2) > 1 then
			mob.gfxWeap = 354
		else
			if math.random(5) % 2 == 0 then
				mob.gfxWeap = math.random(354,355)
			else
				mob.gfxWeap = math.random(353,355)
			end
		end
		mob.gfxNeck = -1
		mob.gfxFaceA = 65535
		mob.gfxFaceAT = 65535
		mob.gfxName = elfFirst[math.random(#elfFirst)].." "..elfLast[math.random(#elfLast)]
		local mapTitle = mob.mapTitle
		--if string.match(mapTitle, "2") == true then
		--	mob.gfxSkinC = math.random(12,21)
		--elseif string.match(mapTitle, "3") == true then
		--	mob.gfxSkinC = math.random(22,32)
		--else
		mob.gfxSkinC = math.random(32)
		--end
		mob.gfxArmor = 17
		mob.gfxHelm = 109
		mob:warp(mob.m, mob.x, mob.y)
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,
	move = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 95 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.move(mob, target)
	end,	
	attack = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 97 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
	
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
	end	
}

angrier_elf = {
	on_spawn = function(mob)
		angry_elf.on_spawn(mob)
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,
	move = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 97 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.move(mob, target)
	end,	
	attack = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 97 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
	end	

}

angriest_elf = {
	on_spawn = function(mob)
		angry_elf.on_spawn(mob)
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,
	move = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 95 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.move(mob, target)
	end,	
	attack = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 98 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
	end	
}

grumpy_elf = {
	on_spawn = function(mob)
		angry_elf.on_spawn(mob)
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob_ai_mythic.on_attacked(mob, attacker, 2)
	end,
	move = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 99 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.move(mob, target)
	end,	
	attack = function(mob, target)
		local says = {"Oh no... can't be late.","Where's that sprinklestapler!?","CHRISTMAS IS RUINED!","aaaaaaaaaA pulls hair out","Back to work.. back to.. work.","Merry Christmas!","Anyone seen Grin?","TNKTNKTNK SMASH NOOoo NOT THE DIADEM!","Leave me alone!"}
		if math.random(100) > 95 then
			mob:talk(0, mob.gfxName..": "..says[math.random(#says)])
		end
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
	end	
}


xmas_deer = {
	on_spawn = function(mob)
		broadcast(mob.m, "A "..mob.name.." has been spotted!")
		mob.registry["gold"] = math.random(20, 50)
		mob.registry["gold"] = mob.registry["gold"] * 1000
	end,
	on_healed = function(mob, healer)
		mob_ai_basic.on_healed(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		mob.attacker = attacker.ID
		mob:removeDuras(venoms)
		if attacker.damage > mob.maxHealth * 0.03 then
			attacker.damage = mob.maxHealth * 0.02
		end
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	end,
	move = function(mob, target)
		xmas_deer.reindeer_run(mob)
		mob_ai_basic.move(mob, target)
	end,	
	attack = function(mob, target)
		xmas_deer.reindeer_run(mob)
		if mob.paralyzed == true then
			mob.paralyzed = false
		end
		if mob.blind == true then
			mob.blind = false
		end
		if math.random(100) % 3 == 0 then
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()		
		end
		mob_ai_basic.attack(mob, target)
	end,
	after_death = function(mob)
		mob_ai_basic.after_death(mob)
	end,
	reindeer_run = function(mob)
		if mob.paralyzed == true then
			mob.paralyzed = false
		end
		if mob.blind == true then
			mob.blind = false
		end
		mob:removeDuras(venoms)
		
		if mob.health > mob.maxHealth * 0.51 then
			return
		end
		for i = 1, math.random(2,4) do
			if mob.registry["gold"] > 500 then
				mob:dropItem(2, 500)
				mob.registry["gold"] = mob.registry["gold"] - 500
			else
				if mob.registry["gold"] == 0 then
					mob.side = math.random(0,3)
					mob:sendSide()
					return
				end
				mob:dropItem(mob.registry["gold"])
				mob.registry["gold"] = 0
			end
			local rand = math.random(0, 3)
			mob.side = rand
			mob:move()
			mob:move()
			mob:move()
		end
	end
}

peppermint_candy_cane = {
	use = function(player)

        local invItem = player:getInventoryItem(player.invSlot)
		local target = getTargetFacing(player, BL_MOB)
	
		if target == nil then
			return
		end
		if player.state == 1 then
			player:sendMinitext("Can't while dead.")
			return
		end

		if target.yname == "angry_elf" or target.yname == "angrier_elf" or target.yname == "angriest_elf" or target.yname == "grumpy_elf" then
			if target.gfxName == player.registryString["elf"] then
				if invItem.yname == "peppermint_candy_cane" and player.quest["stressed_elf"] ~= 0 then
					player:removeItem("peppermint_candy_cane", 1, 9)
					player.registry["peppermint_candy_cane"] = player.registry["peppermint_candy_cane"] + 1
					target:sendAction(14, 80)
					target:talk(0, target.gfxName..": nomnomnom")
					target:talk(0, target.gfxName..": Thanks, "..player.name.."! You're the best.")
				end
				if player.registry["peppermint_candy_cane"] >= 3 then
					target:talk(0,target.gfxName..": thank you "..player.name..", I already have enough of these!")
				end
				candy_canes.check(player)
			else
				player:sendMinitext("It appears this elf is too busy to care.")
				--player:removeItem("peppermint_candy_cane", 1, 9)
			end
		end		
    end
}

rainbow_candy_cane = {
	use = function(player)

        local invItem = player:getInventoryItem(player.invSlot)
		local target = getTargetFacing(player, BL_MOB)
	
		if target == nil then
			return
		end
		if player.state == 1 then
			player:sendMinitext("Can't while dead.")
			return
		end
		
		if target.yname == "angry_elf" or target.yname == "angrier_elf" or target.yname == "angriest_elf" or target.yname == "grumpy_elf" then
			if target.gfxName == player.registryString["elf"] then
				if invItem.yname == "rainbow_candy_cane" and player.quest["stressed_elf"] ~= 0 then
					player:removeItem("rainbow_candy_cane", 1, 9)
					player.registry["rainbow_candy_cane"] = player.registry["rainbow_candy_cane"] + 1
					target:sendAction(14, 80)
					target:talk(0, target.gfxName..": nomnomnom")
					target:talk(0, target.gfxName..": Thanks, "..player.name.."! You're the best.")
				end
				if player.registry["rainbow_candy_cane"] >= 3 then
					target:talk(0,target.gfxName..": thank you "..player.name..", I already have enough of these!")
				end
				candy_canes.check(player)
			else
				player:sendMinitext("It appears this elf is too busy to care.")
				--player:removeItem("rainbow_candy_cane", 1, 9)
			end
		end		
    end
}

rootbeer_candy_cane = {
	use = function(player)

        local invItem = player:getInventoryItem(player.invSlot)
		local target = getTargetFacing(player, BL_MOB)
	
		if target == nil then
			return
		end
		if player.state == 1 then
			player:sendMinitext("Can't while dead.")
			return
		end
		
		if target.yname == "angry_elf" or target.yname == "angrier_elf" or target.yname == "angriest_elf" or target.yname == "grumpy_elf" then
			if target.gfxName == player.registryString["elf"] then
				if invItem.yname == "rootbeer_candy_cane" and player.quest["stressed_elf"] ~= 0 then
					player:removeItem("rootbeer_candy_cane", 1, 9)
					player.registry["rootbeer_candy_cane"] = player.registry["rootbeer_candy_cane"] + 1
					target:sendAction(14, 80)
					target:talk(0, target.gfxName..": nomnomnom")
					target:talk(0, target.gfxName..": Thanks, "..player.name.."! You're the best.")
				end
				if player.registry["rootbeer_candy_cane"] >= 3 then
					target:talk(0,target.gfxName..": thank you "..player.name..", I already have enough of these!")
				end
				candy_canes.check(player)
			else
				player:sendMinitext("It appears this elf is too busy to care.")
				--player:removeItem("rootbeer_candy_cane", 1, 9)
			end
		end		
    end
}
wasabi_candy_cane = {
	use = function(player)

        local invItem = player:getInventoryItem(player.invSlot)
		local target = getTargetFacing(player, BL_MOB)
	
		if target == nil then
			return
		end
		if player.state == 1 then
			player:sendMinitext("Can't while dead.")
			return
		end
		
		if target.yname == "angry_elf" or target.yname == "angrier_elf" or target.yname == "angriest_elf" or target.yname == "grumpy_elf" then
			if target.gfxName == player.registryString["elf"] then
				if invItem.yname == "wasabi_candy_cane" and player.quest["stressed_elf"] ~= 0 then
					player:removeItem("wasabi_candy_cane", 1, 9)
					player.registry["wasabi_candy_cane"] = player.registry["wasabi_candy_cane"] + 1
					target:sendAction(14, 80)
					target:talk(0, target.gfxName..": nomnomnom")
					target:talk(0, target.gfxName..": Thanks, "..player.name.."! You're the best.")
				end
				if player.registry["wasabi_candy_cane"] >= 3 then
					target:talk(0,target.gfxName..": thank you "..player.name..", I already have enough of these!")
				end
				candy_canes.check(player)
			else
				player:sendMinitext("It appears this elf is too busy to care.")
				--player:removeItem("wasabi_candy_cane", 1, 9)
			end
		end		
    end
}

candy_canes = {
	check = function(player)
		local count = player.gameRegistry["xmas_2020_count"]
		local wasabi = player.registry["wasabi_candy_cane"]
		local rootbeer = player.registry["rootbeer_candy_cane"]
		local rainbow = player.registry["rainbow_candy_cane"]
		local peppermint = player.registry["peppermint_candy_cane"]
		
		if wasabi >= 3 and rootbeer >= 3 and rainbow >= 3 and peppermint >= 3 and player.quest["stressed_elf"] < 2 then
			player.gameRegistry["xmas_2020_count"] = count + 1
			player.quest["stressed_elf"] = 2
			
			if not player:hasLegend("xmas_2020") then
				player:addLegend("Befriended "..player.registryString["elf"].." (" .. curT() .. ")","xmas_2020",189,226)
				player:sendAnimation(199,1)
				broadcast(-1, "["..player.registryString["elf"].."]: Thanks for all the candy, "..player.name.."! Now I can finally get some work done..")
			end
		end

		if player.gameRegistry["xmas_2020_count"] >= 25 then
            if player.gameRegistry["xmas_2020"] ~= 1 then
                player.gameRegistry["xmas_2020"] = 1
                broadcast(-1, "Santa Claus: "..player.name.." has helped the last elf to prepare for Christmas!")
                broadcast(-1, "Santa Claus: Merry Christmas!")
            end
        end
		
	end,
}










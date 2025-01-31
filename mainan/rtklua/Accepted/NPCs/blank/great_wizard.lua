great_wizard = {
	on_spawn = function(mob)
		mob:talk(0,mob.name..": had to run a quick errand.")
		mob.side = 2
		mob:sendSide()
		mob:sendAnimationXY(177, mob.x, mob.y)
		mob.registry["great_wiz_action"] = os.time() + 20
		mob.registry["great_wiz_sleep"] = 1
		--great_wizard.move(mob)
	end,
	click = async(function(player, npc)
		if player.gmLevel > 0 then
			player:sendMinitext("Name: "..npc.name..", Spawn ID: "..npc.ID)
		end
		--clone.wipe(player)
		gfx_switch.cast(player)
		gfx_switch.cast(player)
		local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.lastClick = npc.ID
		--player.dialogType = 1 --Crashes (line 8824)
		player.dialogType = 2
		--clone.equip(player, npc)
		--clone.gfx2(player, npc)
		--clone.equipNPC(player,npc)
		--wizard_quest.controller(player, npc, t)

		local opts = {"Hello"}
		if type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" then
			table.insert(opts, "Sealed scroll")
		end
		local optsChoice = player:menuString("What should I say?", opts)	
		
		if (optsChoice == "Hello") then
			npc:talk(0, "Great Wizard: Hello!")
		elseif (optsChoice == "Sealed scroll") then
			player:dialogSeq({t,"I see you have a magically sealed scroll.\n\nPlease seek my friend in the library, he can help you."}, 1)
			player.registry["wizard_sute"] = 4
		end
		--local optsChoice = player:menuString2("Test", {"test"})
		--player:dialogSeq({t,"Hello there!"}, 0)		
	end),
	move = function(mob,target)
		if (target == nil) then
			target = mob:getUsers()[1]
			--mob.attacker = target.ID
			--mob.target = target.ID
		end
		if mob.registry["great_wiz_action"] < os.time() then
			if (os.time()%3==0) then
				mob:sendAction(16,320)
				mob.registry["great_wiz_sleep"] = 1
			end
		end
		local healAmount = math.ceil(mob.maxHealth * 0.05)
		if mob.health < math.floor(mob.maxHealth *0.75) then
			mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			mob:sendAnimation(5)
			mob:sendAction(6,80)
			mob.registry["great_wiz_action"] = os.time() + 20
		end
	end,
	heal = function(mob)
		local healAmount = math.ceil(mob.maxHealth * 0.05)
		mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
		mob:sendAnimation(5)
		mob:sendAction(6,80)
		mob.registry["great_wiz_action"] = os.time() + 20
	end,
	invoke = function(mob)
		mob:sendAnimation(11)--Invoke
		mob.magic = mob.maxMagic
		local health = mob.maxHealth * 0.30
		if (mob.health < health) then
			health = mob.maxHealth * 0.20
		end
		mob.health = health
		mob:sendStatus()
		mob.registry["great_wiz_action"] = os.time() + 20
	end,
	attack = function(mob, target)
		--if (target == nil) then
			--target = getUsers()[1]
			--return
		--end
		local micdog_angry = true
		if micdog_angry == true then
			return
		end
		--
		if (mob.registry["great_wiz_cast"] < os.time()) then
			great_wizard.cast(mob)
			if (mob.registry["great_wiz_sleep"] == 1) then
				mob.registry["great_wiz_sleep"] = 0
				if not target:hasLegend("wake_wizard") then
					target:addLegend("Awakened the great wizard's blessing (" .. curT() .. ")","wake_wizard",115,11)
				end
				target:sendMinitext("As you wake up the great wizard, he gives you his blessing.")
				broadcast(-1, "[SYSTEM]: "..target.name.." has awakened the great wizard's blessing.")
			end
		end	
		local rand = math.random(1,100)
		if mob.health < math.floor(mob.maxHealth * 0.35) then
			great_wizard.heal(mob)
			great_wizard.heal(mob)
			great_wizard.heal(mob)
		elseif mob.health < math.floor(mob.maxHealth * 0.75) then
			great_wizard.heal(mob)
		elseif mob.health < math.floor(mob.maxHealth * 0.96) then
			if rand % 3 == 0 then
				great_wizard.heal(mob)
			end
			if rand % 21 == 0 then
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
				great_wizard.heal(mob)
			end
		end	
		if 	mob.magic < math.floor(mob.maxMagic * 0.10) then		
			great_wizard.invoke(mob)
			great_wizard.heal(mob)
		end
		if rand == 100 then
			if (math.random(1,500) > 485) then
				great_wizard.invoke(mob)
			end
			great_wizard.heal(mob)
		end
		--mob_ai_basic.attack(mob,target)
	end,
	on_attacked = function(mob, attacker)
		local micdog_angry = true
		if micdog_angry == true then
			return
		end
		if mob.paralyzed == true then
			mob.paralyzed = false
			return
		end
		local healAmount = math.ceil(mob.maxHealth * 0.05)
		if mob.health < math.floor(mob.maxHealth *0.75) then
			mob:addHealthExtend(healAmount, 0, 0, 0, 0, 0)
			mob:sendAnimation(5)
			mob:sendAction(6,80)
		end
		
		mob_ai_basic.on_attacked(mob, attacker)
	end,	
	onSayClick = async(function(player, npc)
--		local speech = string.lower(player.speech)
	end),
	cast = function(mob)
		local mintimer = 35
		local maxtimer = 35
		local targets = mob:getUsers()
		local spells = {
		"kingdom_bolster",
		"kingdom_might",
		"kingdom_grace",
		"kingdom_will",
		"kingdom_heal",
		"kingdom_inspire"}
		local spell
		local timer = math.random(mintimer,maxtimer)
		
		for i = 1, #targets do
			if targets[i].pvp == 0 and
			not(targets[i]:checkIfCast(wizard_kingdom)) and --add wizard kingdom to spellTables.lua
			targets[i].state ~= 1 then
				spell = math.random(1,#spells)
				targets[i]:selfAnimation(targets[i].ID,2)
				targets[i]:sendMinitext("You sense the Great Wizard's magic.")
				if spell == 1 then
					kingdom_bolster.cast(targets[i])
				elseif spell == 2 then
					kingdom_might.cast(targets[i])
				elseif spell == 3 then
					kingdom_grace.cast(targets[i])
				elseif spell == 4 then
					kingdom_will.cast(targets[i])
				elseif spell == 5 then
					kingdom_heal.cast(targets[i])
				elseif spell == 6 then
					kingdom_inspire.cast(targets[i])
				end
			end
		end	
		mob:sendAction(6,2000)
		mob.registry["great_wiz_action"] = os.time() + 20
		mob.registry["great_wiz_cast"] = timer + os.time()
	end,
}

wiz_alana = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts = {}
		wizard_quest.preparation(player, npc)
	end),
	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)

		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
	end)
}

wiz_keeper = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts = {}

		if type(player:hasItem("unified_theory_of_magic", 1)) == "boolean" and player.class == 3 then
			table.insert(opts, "Become a Wizard")
		elseif player.class == 26 then
			--Learn spell and stuff
			table.insert(opts, "Spellbook")
			table.insert(opts, "Orb of Mana")
			table.insert(opts, "Leave subpath")
		end
		
		local optsChoice = player:menuString("How can I help you?", opts)
		local wizOpts = {}
		
		if optsChoice == "Spellbook" then
            if player:hasSpell("thunderstorm") == false then
                if player.level >= 70 then
                    table.insert(wizOpts,"Learn Thunderstorm")
                end
            end
            if player:hasSpell("diamond_dust") == false then
                if player.level >= 75 then
                    table.insert(wizOpts,"Learn Diamond Dust")
                end
            end
            if player:hasSpell("meditate") == false then
                if player.level >= 72 then
                    table.insert(wizOpts,"Learn Meditate")
                end
            end
            if player:hasSpell("blink") == false then
                if player.level >= 98 then
                    table.insert(wizOpts,"Learn Blink")
                end
            end
            if player:hasSpell("assess_karma") == false then
                if player.level >= 99 then
                    table.insert(wizOpts,"Learn Assess Karma")
                end
            end
            if player:hasSpell("ionic_blast") == false then
                if player.level >= 99 then
					if (player.baseHealth >= 80000 or player.baseMagic >= 40000)then
						--table.insert(wizOpts,"Learn Ionic Blast")
						player:dialogSeq({t,"You are not ready for this spell."},1)
					end
                end
            end
			
			if (player.class == 26) then
				local wizMenu = player:menuString("Greetings wizard, how can I help you today?",wizOpts)
				if wizMenu == "Learn Thunderstorm" then
					player:dialogSeq({t,"Summon a dark cloud which rains thunder in an area","This costs two bekyun's spears, one angel's tear and 25,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("bekyuns_spear",2) == true) and (player:hasItem("angels_tear",1) == true) and (player.money >= 25000)) then
						player:removeItem("bekyuns_spear",2)
						player:removeItem("angels_tear",1)
						player:removeGold(25000)
						player:addSpell("thunderstorm")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end

				if wizMenu == "Learn Diamond Dust" then
					player:dialogSeq({t,"This spell will infuse mana into the aether to manipulate and control the environment.","This costs one frozen spear and 20,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("frozen_spear",1)) == true and (player.money >= 20000)) then
						player:removeItem("frozen_spear",1)
						player:removeGold(20000)
						player:addSpell("diamond_dust")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end

				if wizMenu == "Learn Meditate" then
					player:dialogSeq({t,"This advanced technique will help you regenerate mana beyond your limits.","To learn this spell you will require a scroll of invocation and 10,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("scroll_of_invocation",1)) == true and (player.money >= 10000)) then
						player:removeItem("scroll_of_invocation",1)
						player:removeGold(10000)
						player:addSpell("meditate")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end
				if wizMenu == "Learn Blink" then
					player:dialogSeq({t,"This advanced technique allow you to teleport a short distance.","To learn this spell you will require an enchanted crystal ball and a surge.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("enchanted_crystal_ball",1)) == true and (player:hasItem("surge",1)) == true) then
						player:removeItem("enchanted_crystal_ball",1)
						player:removeItem("surge",1)
						player:addSpell("blink")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end
				if wizMenu == "Learn Assess Karma" then
					player:dialogSeq({t,"By sensing the slight deviations in the aether you can determine another person's karma.","To learn this spell you will require a dozen Tao stones and 1,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("tao_stone",12)) == true and (player.money >= 1000)) then
						player:removeItem("tao_stone",12)
						player:removeGold(1000)
						player:addSpell("assess_karma")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end
				if wizMenu == "Learn Ionic Blast" then
					player:dialogSeq({t,"Release a blast of ions charged into the atmosphere.","To learn this spell you will require an enchanted surge and 50,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
					if((player:hasItem("enchanted_surge",1)) == true and (player.money >= 50000)) then
						player:removeItem("enchanted_surge",1)
						player:removeGold(50000)
						player:addSpell("ionic_blast")
					else
						player:dialogSeq({t,"You don't have those items.."},0)
					end
				end
			end
		elseif optsChoice == "Orb of Mana" then
            if player.level >= 99 then
                table.insert(wizOpts,"Orb of Mana")
            end

            if ((player.maxHealth >= 80000) or (player.maxMagic >= 40000)) then
                table.insert(wizOpts,"Enchanted Orb of Mana")
            end

            if player.mark >= 1 then
                table.insert(wizOpts,"Il san Orb of Mana")
            end

            if player.mark >= 2 then
                table.insert(wizOpts,"Ee san Orb of Mana")
            end
			
            if player.mark >= 3 then
                table.insert(wizOpts,"Sam san Orb of Mana")
            end
            if player.mark >= 4 then
                table.insert(wizOpts,"Sa san Orb of Mana")
            end
			
			local wizMenu = player:menuString("Greetings wizard, Orb of Mana lets you control the flow of Mana.",wizOpts)
			
            if wizMenu == "Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To harness the power of one, you must bring me 2 silver branches, 9 fox tails and 2 of the ore Sute seeks.","It will also require you to relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("silver_tree_branch",2) == true) and (player:hasItem("fox_tail",9) == true) and (player:hasItem("silver_ore",2) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper effortlessly weaves aether into an orb of mana as if he was directing an orchestra*","Take good care of it."},1)
                    player:removeItem("silver_tree_branch",2)
					player:removeItem("fox_tail", 9)
                    player:removeItem("silver_ore",2)
					player.baseWill = player.baseWill - 10
					player:sendStatus()
                    player:addItem("orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 20 will."},0)
                end
			elseif wizMenu == "Enchanted Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To enchant one you must bring an Orb of Mana and relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("orb_of_mana",1) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper compresses aether into the orb to create higher concentrations of mana*","Take good care of it."},1)
                    player:removeItem("orb_of_mana",1)
					player.baseWill = player.baseWill - 5
					player:sendStatus()
                    player:addItem("enchanted_orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 20 will."},0)
                end
			elseif wizMenu == "Il san Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To further enchant one you must bring an Enchanted Orb of Mana and relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("enchanted_orb_of_mana",1) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper compresses aether into the orb to create higher concentrations of mana*","Take good care of it."},1)
                    player:removeItem("enchanted_orb_of_mana",1)
					player.baseWill = player.baseWill - 10
					player:sendStatus()
                    player:addItem("il_san_orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 20 will."},0)
                end
			elseif wizMenu == "Ee san Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To further enchant one you must bring an Il san Orb of Mana and relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("il_san_orb_of_mana",1) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper compresses aether into the orb to create higher concentrations of mana*","Take good care of it."},1)
                    player:removeItem("il_san_orb_of_mana",1)
					player.baseWill = player.baseWill - 15
					player:sendStatus()
                    player:addItem("ee_san_orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 20 will."},0)
                end
			elseif wizMenu == "Sam san Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To further enchant one you must bring an Ee san Orb of Mana and relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("ee_san_orb_of_mana",1) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper compresses aether into the orb to create higher concentrations of mana*","Take good care of it."},1)
                    player:removeItem("ee_san_orb_of_mana",1)
					player.baseWill = player.baseWill - 20
					player:sendStatus()
                    player:addItem("sam_san_orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 20 will."},0)
                end
			elseif wizMenu == "Sa san Orb of Mana" then
                player:dialogSeq({t,"Orb of Mana lets you control the folow of mana, use carefully as its use is situational.","To further enchant one you must bring an Sam san Orb of Mana and relinquish some of your will.","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("sam_san_orb_of_mana",1) == true) and player.baseWill > 20) then
                    player:dialogSeq({t,"*The keeper compresses aether into the orb to create higher concentrations of mana*","Take good care of it."},1)
                    player:removeItem("sa_san_orb_of_mana",1)
					player.baseWill = player.baseWill - 25
					player:sendStatus()
                    player:addItem("sam_san_orb_of_mana",1,0,player.ID)
                else
                    player:dialogSeq({t,"You have not brought everything, remember you may not have less than 30 will."},0)
                end
            end
		elseif optsChoice == "Leave subpath" then
			local confirm1 = player:menuString("Your spirit will take a hit. Are you SURE you want to abandon subapth?",{"Yes","No"})
			if confirm1 == "Yes" then
				for i = 1, 99 do
					player:removeSpell(26000 + i)
				end
				player:removeLegendbyName("wizard_joined_mark")
				player:removeKarma(4.0)
				player:updatePath(player.baseClass, player.mark)
				player:dialogSeq({t,"It is done."},0)
			end		
		elseif optsChoice == "Become a Wizard" then
			local opts2 = {}
			if player.registry["wiz_trial"] < 1 then
				table.insert(opts2, "Art of Arcane")
			elseif player.registry["wiz_trial"] == 1 then
				table.insert(opts2, "Supplies")
			elseif player.registry["wiz_trial"] == 2 then
				table.insert(opts2, "Knowledge")
			end
			
			optsChoice = player:menuString("How can I help you?", opts2)
			
			if optsChoice == "Art of Arcane" then
				if crafting.checkSkillLegend(player, "potion making") or crafting.checkSkillLegend(player, "scribing") then
					player:dialogSeq({t,"The art of the arcane is the type of magic us wizards specialize in.",
					"Excellent! I see you have an understanding of mental crafts."}, 1)
					player.registry["wiz_trial"] = 1
				else
					player:dialogSeq({t,"The art of the arcane is the type of magic us wizards specialize in.",
					"Through artfully manipulation of the aether we can weave it with mana to cast powerful spells.",
					"In order for you to become a Wizard, you must first understand art.",
					"You can't understand something you haven't taken part of.\n\nAlana understands this very well as I am sure you helped her."}, 1)
				end
			elseif optsChoice == "Supplies" then
				if type(player:hasItem("scribes_pen", 12)) == "boolean" and type(player:hasItem("wiz_magical_scribes_book", 1)) == "boolean" then
					player.registry["wiz_trial"] = 2
					player:removeItem("scribes_pen", 12)
					player:removeItem("wiz_magical_scribes_book", 1)
					player:dialogSeq({t,"These supplies will aid greatly in the study of arcane magic.",
					"Make sure you research and study before attempting the next step."}, 1)
				else
					player:dialogSeq({t,"With all the new wizards, our study room is running low on supplies.",
					"Bring me a dozen pens and a magical book for our scribes."}, 1)
				end
			elseif optsChoice == "Knowledge" then
				--Insert questionnaire
				if #player:getSpells() < 24 then
					player:dialogSeq({t,"Your spellbook must contain at least 24 spells to prove your knowledge of magic."},1)
					return
				end
				local pass = wizard_quest.questionnaire(player, npc)
				if  pass == 10 then
					player:dialogSeq({t,"You are one fine student, "..player.name..".","You have earned your library pass. ","Welcome wizard "..player.name},1)
					player:addLegend("Scholar of the art of the arcane (" .. curT() .. ")","wizard_joined_mark",56,200)
					player:updatePath(26, player.mark)
					broadcast(-1,"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!")
					
					player.registry["wiz_trial"] = 0
					player.quest["wizard_scroll"] = 3
					player.registry["wizard_sute"] = 10
				end
			end
		end
	end),
	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)

		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
		if player.class ~= 26 then
			player:dialogSeq({t,"Please keep your voice down while you visit."}, 1)
		end
		if speech == "wizard" or speech == "wizards" or speech == "unified theory of magic" or speech == "theory of magic" or speech == "magic" or speech == "sealed scroll"  or speech == "scroll" then
			wizard_quest.controller(player, npc)
		end
	end)
}

wizard_quest = {
--[[
	Quest == 0 Not started
	Quest == 1 Started
	Quest == 2 In Progress
	Quest == 3 Completed
]]--

	controller = function( player, npc, t)
		if t == nil then
			local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			player.lastClick = npc.ID
		end
		local wiz_scroll = player.quest["wizard_scroll"]
		local wiz_sute = player.registry["wizard_sute"]	
		local region = player.region
		--Region 1: Buya (Lake)
		--Region 6: Blank
		if (wiz_scroll < 1) then--Not Started
			if npc.yname == "LibrarianNpc" then
				if region == 6 then
					player:dialogSeq({t,"If you'd like to learn more about the wizards you should procure the scroll of Unified Theory of Magic.",
					"The first tome was given to Lake in Buya, he should be able to lend it to you."}, 0)
				elseif region == 1 then -- Lake
					player:dialogSeq({t,"Yes, yes...",
					"The Unified Theory of Magic is an insightful masterpiece, I had a tome some decades ago.",				
					"According to my logs, Eldritch should have the first tome."}, 0)
					--player.registry["wizard_sute"] = 0
					player.quest["wizard_scroll"] = 1			
				else -- Other Librarians
					player:dialogSeq({t,"Shhh.. please keep your voice down, there are other people reading in the hall.",
					"If you're looking for information on wizards you best check with Lake as he has grown quite interested in them too."}, 0)			
				end
			end
		elseif (wiz_scroll == 1) then
			if npc.name == "Eldritch" then
				if wiz_sute < 1 then
					player:dialogSeq({t, "I, umm... lost it after lending it to Makutu, one of my students.",
					"Most likely he was acquiring the scroll for his master, Sute.",
					"Let me know if you would like to learn more."}, 0)
					player.registry["wizard_sute"] = 1
					player.quest["wizard_scroll"] = 2
				end
			elseif npc.name == "Lake" then --Buya
				player:dialogSeq({t,"Yes, yes...",
				"The Unified Theory of Magic is an insightful masterpiece, I had a tome some decades ago.",				
				"According to my logs, Eldritch should have the first tome."}, 0)
			end
		elseif wiz_scroll == 2 then
			if type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute <4 and npc.name == "Lake"then
				player:dialogSeq({t,"Did you find it?",
				"Hmm, so it seems Sute sealed the scroll with some magic.\n\nTake it to Eldritch to see if he can break the seal.",
				"It seems like Sute didn't want anyone reading it."}, 0)
				player.registry["wizard_sute"] = 2
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 3 and npc.name == "Eldritch" then
				player:dialogSeq({t,"The seal on this scroll is characteristic to traits I read on the Unified Theory of Magic.",
				"Perhaps it's time you seek the assistance of the Wizards. \n\nHead out to the Blank Kingdom and talk to their librarian, he may be able to further guide you from here."}, 0)
				player.registry["wizard_sute"] = 3
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 4 and npc.name == "Eldritch" then
				player:dialogSeq({t,"The seal on this scroll is characteristic to traits I read on the Unified Theory of Magic.",
				"Perhaps it's time you seek the assistance of the Wizards. \n\nHead out to the Blank Kingdom and talk to their librarian, he may be able to further guide you from here.",
				"What are you waiting for? Wizards can be found somewhere on the coast of the Blank Kingdom."}, 0)
			elseif npc.name == "Eldritch" and wiz_sute <= 2 then-- does not have sealed scroll
				player:dialogSeq({t,"\nIn every great mind, there is a hint of madness.\n\n     -Sute",
				"Ah, Sute...",
				"**the mage shakes his head slightly.**",
				"Sute was one of my most talented students, he had an incredible talent for all forms of magic. Although his impatience might have been his downfall.",
				"**Eldritch gazes far in the distance with sad eyes**",
				"When Sute attained his Sky clothes he had already mastered unleashing fire from hell and was impatient to learn more. One day he ventured southeast where he caught wind of great scholars of magic.",
				"**Eldritch sighs**",
				"The scholars of a land closed to us as ordered by King Yuri were not very well known in these lands, all we knew was that they called themselves wizards.",
				"The forms of magic practiced by wizards had similarities with ours, while displaying higher control over aether.",
				"**Eldritch continues rambling for some time about his memories of Sute..**",
				"Perhaps Sute kept the tome somewhere, when you're ready ask me about Sute."}, 0)
				player.registry["wizard_sute"] = 2
				--Note: add a respawning clickable chest in 443 21 23, if player has sute's key it will give a dark amber. If they are on this quest it will give a sealed scroll.			
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 4 and npc.yname == "LibrarianNpc" and player.region == 6 then
					player:dialogSeq({t,"It appears the Unified Theory of Magic is under a magical seal.",
					"I suggest you take it to the Great Wizard to get the seal undone as the magic on it is too strong for me.",
					"The Great Wizard can usually be found somewhere around Blank Kingdom."}, 0)
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 6 and npc.yname == "LibrarianNpc" and player.region == 6 then
				if player.baseClass == 3 then
					player:dialogSeq({t,"So the Great Wizard sent you to see the keeper?",
					"Alright I will let you pass."}, 0)
					player:warp(26002, 10, 19)
				else
					player:dialogSeq({t,"You would not understand the art of the arcane.",
					"I am sorry."}, 0)
				end
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 5 and npc.yname == "wiz_keeper" then
				if player.quest["wiz_preparation"] >= 7 then
					player:dialogSeq({t,"Interesting...\n\nThere's a trick on this seal...",
					"It appears to be a deviation from one of our older seals.",
					"To break this seal we will require large amounts of mana.",
					"Let me know when you are ready."}, 0)
					player.registry["wizard_sute"] = 5
					player.registry["wiz_mana"] = 1000 + player.maxMagic * math.random(20, 35)
				else
					player:dialogSeq({t,"We have nothing to discuss.",
					"Perhaps go and make yourself useful."}, 0)
				end
				--preparation quest requirement
			elseif type(player:hasItem("wiz_sealed_scroll", 1)) == "boolean" and wiz_sute < 6 and npc.yname == "wiz_keeper" then
				if player.quest["wiz_preparation"] < 7 then
					player:dialogSeq({t,"We have nothing to discuss.",
					"Perhaps go and make yourself useful."}, 0)
					return
				end
				if player.registry["wiz_mana"] > 0 then
					player:dialogSeq({t,"Your will is too weak.",
					"Please replenish your mana and come back."}, 0)
					player.registry["wiz_mana"] = player.registry["wiz_mana"] - player.magic
					player:removeMagic(player.magic)
				else
					player:dialogSeq({t,"You have finally cultivated enough mana to unlock the seal.",
					"It appears this is a copy of the first tome of the Unified Theory of Magic.",
					"Try not to lose it or break it as it won't be easy to get back."}, 0)
					if player:hasItem("wiz_sealed_scroll", 1) then
						player:removeItem("wiz_sealed_scroll", 1)
						player:addItem("unified_theory_of_magic", 1)
						player.registry["wiz_mana"] = 0
						player.registry["wizard_sute"] = 6
					else
						player.registry["wizard_sute"] = 3
					end
				end
			elseif npc.yname == "LibrarianNpc" and player.region == 6 then
				if wiz_sute >= 6 and player.class ~= 26 and player.baseClass == 3 and player.level >= 70 then
					player:dialogSeq({t,"I see you managed to get your hands on a copy of Unified Theory of Magic.",
					"You shall pass."}, 0)
					player:warp(26002, 10, 19)
				end
			end
		elseif wiz_scroll == 3 or player.class == 26 then
			player:warp(26002, 10, 19)
		end
	end,

	preparation = function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		local prep = player.quest["wiz_preparation"]
		
		if prep < 1 then
			if player.level >= 5 then
				player:dialogSeq({t,"Greetings from Alana the Wizard and welcome to the Blank Kingdom!",
				"I just became a wizard and I'm learning all about the art of arcane magic.\n\nFirst things first!\n\nI will need some paper and ink as the first step is to research and study."}, 0)
				player.quest["wiz_preparation"] = 1
			else
				player:dialogSeq({t,"Greetings from Alana the Wizard and welcome to the Blank Kingdom!",
				"I just became a wizard and I'm learning all about the art of arcane magic.\n\nToo bad you don't have what it takes to help me yet."}, 0)
			end
		elseif prep == 1 then
			if type(player:hasItem("white_paper", 1)) == "boolean" and type(player:hasItem("ink", 1)) == "boolean"  then
				player:dialogSeq({t,"Greetings from Alana the Wizard and welcome to the Blank Kingdom!",
				"I am still waiting for the ink and paper I need to research and study magic."}, 0)
				if type(player:hasItem("white_paper", 1)) == "boolean"  and type(player:hasItem("ink", 1)) == "boolean"  then
					player:removeItem("white_paper", 1)
					player:removeItem("ink", 1)
					player.quest["wiz_preparation"] = 2
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Greetings from Alana the Wizard and welcome to the Blank Kingdom!",
				"I am still waiting for the ink and paper I need to research and study magic."}, 0)
			end
		elseif prep == 2 then
			if type(player:hasItem("yellow_potion", 1)) == "boolean"  and type(player:hasItem("blue_potion", 1)) == "boolean"  and type(player:hasItem("indigo_potion", 1)) == "boolean"  and type(player:hasItem("aged_wine", 1)) == "boolean"  then
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"Wow, you're amazing!",
				"Thanks very much, with this I will be able to do more research into mental crafts."}, 0)
				if type(player:hasItem("yellow_potion", 1)) == "boolean"  and type(player:hasItem("blue_potion", 1)) == "boolean"  and type(player:hasItem("indigo_potion", 1)) == "boolean"  and type(player:hasItem("aged_wine", 1)) == "boolean"  then
					player:removeItem("yellow_potion", 1)
					player:removeItem("blue_potion", 1)
					player:removeItem("indigo_potion", 1)
					player:removeItem("aged_wine", 1)
					player.quest["wiz_preparation"] = 3
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"Think you could help me with some research? I have heard of potions made in other kingdoms.\n\nCould you help me procure a yellow, blue and indigo potion?",
				"Also please bring me a wine that has withstood the test of time."}, 0)
			end
		elseif prep == 3 then
			if type(player:hasItem("scroll", 1)) == "boolean"  and type(player:hasItem("book", 1)) == "boolean"  and type(player:hasItem("ink", 1)) == "boolean"  and type(player:hasItem("sonhi_pipe", 1)) == "boolean"  then
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"Thanks very much, with this I will be able to further study the art of the arcane."}, 0)
				if type(player:hasItem("scroll", 1)) == "boolean"  and type(player:hasItem("book", 1)) == "boolean"  and type(player:hasItem("ink", 1)) == "boolean"  and type(player:hasItem("sonhi_pipe", 1)) == "boolean"  then
					player:removeItem("scroll", 1)
					player:removeItem("book", 1)
					player:removeItem("ink", 1)
					player:removeItem("sonhi_pipe", 1)
					player.quest["wiz_preparation"] = 4
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"I need some more supplies for my studies into the arts of the arcane.\n\nCould you get me a scroll, book, sonhi pipe and some ink?"}, 0)
			end
		elseif prep == 4 then
			if type(player:hasItem("rich_wine", 1)) == "boolean" then
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"I need this rich wine so much, thank you!",
				"Mana is in everything around us, it is something you can have and can be cultivated."}, 0)
				if type(player:hasItem("rich_wine", 1)) == "boolean" then
					player:removeItem("rich_wine", 1)
					player.quest["wiz_preparation"] = 5
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"I'm not strong enough to learn meditate, could you get me some rich wine? I'm always out of mana!",
				"By the way did you know the difference between mana and aether?\n\nI was reading all about it on the Unified Theory of Magic."}, 0)
			end
		elseif prep == 5 then
			if type(player:hasItem("moon_paper", 1)) == "boolean" then
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"Excellent!\n\nYou got me some moon paper!",
				"Now I will use this to prepare my new spell."}, 0)
				if type(player:hasItem("moon_paper", 1)) == "boolean" then
					player:removeItem("moon_paper", 1)
					player.quest["wiz_preparation"] = 6
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Oh, it's "..player.name.." again!\n\nGreetings from Alana the Wizard!",
				"For this spell I will need paper infused with magic from the stars.",
				"If you can do this I will be so grateful!"}, 0)
			end
		elseif prep == 6 then
			if type(player:hasItem("magic_mirror", 1)) == "boolean" then
				player:dialogSeq({t,"Hey "..player.name.."!\n\nGreetings from Alana the Wizard!",
				"With this magical mirror I will finally be able to try out my new spell.",
				"Thank you so much for your assistance!\n\nYou have been very helpful."}, 0)
				if type(player:hasItem("magic_mirror", 1)) == "boolean" then
					player:removeItem("magic_mirror", 1)
					player.quest["wiz_preparation"] = 7
					wizard_quest.legend(player)
				else
					wizard_quest.cheat(player)
				end
			else
				player:dialogSeq({t,"Hey "..player.name.."!\n\nGreetings from Alana the Wizard!",
				"This time I will need a magical artifact that can reflect more than light!"}, 0)
			end
		elseif prep >= 7 then
			player:dialogSeq({t,"Howdy "..player.name.."!\n\nGreetings from Alana the Wizard!",
			"Everything has been great so far, I'm still studying under the great wizard.", "You could get a scroll of the Unified Theory of Magic from a librarian, just ask them about wizards."}, 0)
		end
	end,
	
	legend = function(player)
		player.quest["wiz_assist"] = player.quest["wiz_preparation"] - 1
		player.quest["wiz_assist"] = player.quest["wiz_assist"] + 1

		local times = player.quest["wiz_assist"]

		if player:hasLegend("wiz_assist") then
			player:removeLegendbyName("wiz_assist")
		end
	
		player:giveXP((100 + player.level * 100) * player.quest["wiz_preparation"])

		if times == 1 then
			player:addLegend(
				"Assisted wizards in spellcasting " .. times .. " time",
				"wiz_assist", 25, 9)
		end
		if times > 1 then
			player:addLegend(
				"Assisted wizards in spellcasting " .. times .. " times",
				"wiz_assist", 25, 9)
		end
	end,
	
	cheat = function(player)
		player:dialogSeq({t,"Why are you trying to cheat the wizards?"}, 0)
		player.quest["wizard_preparation"] = 1
		if player:hasLegend("wiz_assist") then
			player:removeLegendbyName("wiz_assist")
		end
		player.health = 1
		player:sendAnimation(25)
		player:sendStatus()
		broadcast(-1, "[SUBPATH]: "..player.name.." has been struck by Alana the Wizard.")
	end,
	
	questionnaire = function(player, npc)
		local qset = {
		q1 = "What are wizards?", 
		a1 = {"Spellcasters who mastered all forms of magic", "Highly adept in combat", "Librarians"},
		q2 = "What art do wizards practice?",
		a2 = {"Mental crafts", "Jewelry", "Art of Wizardry"},
		q3 = "What characteristics do wizards have?",
		a3 = {"Powerful spells and instant magic", "Enchantations and spellcasting", "Infinite mana"},
		q4 = "The art of the arcane is...",
		a4 = {"Manipulation of mana", "Manipulation of aether", "Arcane arts & crafts or magical trinkets"},
		q5 = "What is an ascendant wizard?",
		a5 = {"It is a wizard who ascended", "It is a wizard who stepped on the next rank", "It is when a wizard reaches angel's tear karma"},
		q6 = "Ascendants can be...",
		a6 = {"Abjurers, Chronomancers and Transmuters", "Evokers, Enchanters and Summoners", "Ritualists, Conjurers and Demonologists"},
		q7 = "Spellcasting basic elements are...",
		a7 = {"Gathering materials, chanting, aiming and casting", "Preparing, chanting, casting", "Learning the spell, merging aether and casting"},
		q8 = "What is aether?",
		a8 = {"Aether is the cooldown in between spellcasts", "Aether is what makes us magical", "Aether is the energy in the air we exhale"},
		q9 = "What is mana?",
		a9 = {"Mana is the blue thing we use to cast spells", "Mana is a secret kept under the world tree", "Mana is the spiritual life force in the air"},
		q10 = "What is the difference between mana and aether?",
		a10 = {"Mana we breathe, aether we have", "Mana to cast, aether is the time between spells", "Mana is the source, while aether is how we control it"}
		}
		--[[
		1 What are wizards?
			Scholars
			Spellcasters who mastered all forms of magic
			Highly adept in combat
			Librarians
		2 What art do wizards practice?
			Art of Arcane
			Mental crafts
			Jewelry
			Art of Wizardry
		3 What characteristics do wizards have?
			Broad range of spells learned over time
			Powerful spells and instant magic
			Enchantations and spellcasting
			Infinite mana
		4 The art of the arcane is...
			A form of magic involving manipulation of energies
			A form of magic involving manipulation of mana
			A form of magic involving manipulation of aether
			Arcane arts & crafts or magical trinkets
		5 What is an ascendant wizard?
			It is when a wizard specializes in a specific form
			It is a wizard who ascended
			It is a wizard who stepped on the next rank
			It is when a wizard reaches angel's tear karma
		6 Ascendants can be...
			Elementalists, Scholars and Conjurers
			Abjurers, Chronomancers and Transmuters
			Evokers, Enchanters and Summoners
			Ritualists, Conjurers and Demonologists
		7 Spellcasting basic elements are...
			Casting, research and study, preparation
			Gathering materials, chanting, aiming and casting
			Preparing, chanting, casting
			Learning the spell, merging aether and casting
		8 What is Aether?
			Aether is the ambient magic
			Aether is the cooldown in between spellcasts
			Aether is what makes us magical
			Aether is the energy in the air we exhale
		9 What is mana?
			Mana is the spiritual life force inside everything
			Mana is the blue thing we use to cast spells
			Mana is a secret kept under the world tree
			Mana is the spiritual life force in the air
		10 What is the difference between mana and aether?
			Mana is an intentional force, while aether is a source of energy
			Mana is what we breathe, aether is what we have
			Mana is what we use to cast spells and aether is the time between spells
			Mana is the source of energy for spell casting, while aether is how we control it
			
		
		]]--
		
		table.insert(qset.a1,math.random(1,4), "Scholars")
		table.insert(qset.a2,math.random(1,4), "Art of Arcane")
		table.insert(qset.a3,math.random(1,4), "Broad range of spells learned over time")
		table.insert(qset.a4,math.random(1,4), "Manipulation of energies")
		table.insert(qset.a5,math.random(1,4), "When a wizard specializes in a specific form")
		table.insert(qset.a6,math.random(1,4), "Elementalists, Scholars and Conjurers")
		table.insert(qset.a7,math.random(1,4), "Casting, research and study, preparation")
		table.insert(qset.a8,math.random(1,4), "Aether is the ambient magic")
		table.insert(qset.a9,math.random(1,4), "Mana is the spiritual life force in everything")
		table.insert(qset.a10,math.random(1,4), "Mana is intentional, aether is a source")

		local left = player:getEquippedItem(4)
		local right = player:getEquippedItem(5)
		local pen = nil
		local a1, a2, a3, a4, a5, a6, a7, a8, a9, a10
		if left ~= nil then
			if left.yname == "scribes_pen" then
				pen = 4
			end
		end
		if right ~= nil then
			if right.yname == "scribes_pen" then
				pen = 5
			end
		end
		
		if pen == nil then
			player:sendMinitext("You have nothing to write with, equip something to write with first.")
			return
		end
		
		a1 = player:menuString(qset.q1,qset.a1)
		if a1 ~= "Scholars" then
			player:deductDura(pen, 1500)
			return
		end
		a2 = player:menuString(qset.q2,qset.a2)
		if a2 ~= "Art of Arcane" then
			player:deductDura(pen, 1500)
			return
		end
		a3 = player:menuString(qset.q3,qset.a3)
		if a3 ~= "Broad range of spells learned over time" then
			player:deductDura(pen, 1500)
			return
		end
		a4 = player:menuString(qset.q4,qset.a4)
		if a4 ~= "Manipulation of energies" then
			player:deductDura(pen, 1500)
			return
		end
		a5 = player:menuString(qset.q5,qset.a5)
		if a5 ~= "When a wizard specializes in a specific form" then
			player:deductDura(pen, 1500)
			return
		end
		a6 = player:menuString(qset.q6,qset.a6)
		if a6 ~= "Elementalists, Scholars and Conjurers" then
			player:deductDura(pen, 1500)
			return
		end
		a7 = player:menuString(qset.q7,qset.a7)
		if a7 ~= "Casting, research and study, preparation" then
			player:deductDura(pen, 1500)
			return
		end
		a8 = player:menuString(qset.q8,qset.a8)
		if a8 ~= "Aether is the ambient magic" then
			player:deductDura(pen, 1500)
			return
		end
		a9 = player:menuString(qset.q9,qset.a9)
		if a9 ~= "Mana is the spiritual life force in everything" then
			player:deductDura(pen, 1500)
			return
		end
		a10 = player:menuString(qset.q10,qset.a10)
		if a10 ~= "Mana is intentional, aether is a source" then
			player:deductDura(pen, 1500)
			return
		end
		return 10
		--player:talk(0,"Congrats")
	end
}

wiz_sutes_chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 24
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	click = function(player, npc)
		if not type(player:hasItem("wiz_sutes_key", 1) == "boolean") then
			return
		end
		if npc.side ~= 2 then
			return
		end
		
		npc.side = 1
		npc:sendSide()

		local items = {"dark_amber"}
		local itemsDesc = {"Dark Amber"}
		if player.registry["wizard_sute"] >= 2 then
			table.insert(items, "wiz_sutes_key")
			table.insert(itemsDesc, "Sute's Magical key")
		end

		if math.random(100) > 40 then
			player:addItem("dark_amber", 1)
		else
			player:addItem("wiz_sealed_scroll", 1)
		end
		player:removeItem("wiz_sutes_key", 1)
	end
}

wizard_kingdom = {
	"kingdom_bolster",
	"kingdom_might",
	"kingdom_grace",
	"kingdom_will",
	"kingdom_heal",
	"kingdom_inspire"
}

kingdom_bolster = {--Great Wizard's bolster
	cast = function(player)
		local duration = 10
		duration = duration * math.abs((100 - player.level))
		if duration > 600 then
			duration = 600
		end
		player:setDuration("kingdom_bolster", duration * 1000)
		player:calcStat()
	end,
	recast = function(player)
		player.armor = player.armor - 1
		player:sendStatus()	
	end,
	uncast = function(player)
		player.armor = player.armor + 1
		player:sendStatus()	
	end
}

kingdom_might = {--Great Wizard's might
	cast = function(player)
		local duration = 10
		duration = duration * math.abs((100 - player.level))
		if duration > 600 then
			duration = 600
		end
		player:setDuration("kingdom_might", duration * 1000)
		player:calcStat()
	end,
	recast = function(player)
		player.might = player.might + 1
		player:sendStatus()	
	end,
	uncast = function(player)
		player.might = player.might - 1
		player:sendStatus()	
	end
}

kingdom_grace = {--Great Wizard's grace
	cast = function(player)
		local duration = 10
		duration = duration * math.abs((100 - player.level))
		if duration > 600 then
			duration = 600
		end
		player:setDuration("kingdom_grace", duration * 1000)
		player:calcStat()
	end,
	recast = function(player)
		player.grace = player.grace + 1
		player:sendStatus()	
	end,
	uncast = function(player)
		player.grace = player.grace - 1
		player:sendStatus()	
	end
}

kingdom_will = {--Great Wizard's Will
	cast = function(player)
		local duration = 10
		duration = duration * math.abs((100 - player.level))
		if duration > 600 then
			duration = 600
		end
		player:setDuration("kingdom_will", duration * 1000)
		player:calcStat()
	end,
	recast = function(player)
		player.will = player.will + 1
		player:sendStatus()	
	end,
	uncast = function(player)
		player.will = player.will - 1
		player:sendStatus()	
	end
}

kingdom_heal = {
	cast = function(player)
		local amount = 50
		if player.might > 5 then
			amount = math.ceil((player.might * amount) / 1.5)
		end
		player:addHealth(amount)
		player:sendMinitext("The Great Wizard heals you.")
	end
}

kingdom_inspire = {
	cast = function(player)
		local amount = 30
		if player.will > 5 then
			amount = math.ceil((player.will * amount) / 2)
		end	
		player:addMagic(amount)
		player:sendMinitext("The Great Wizard inspires you.")
	end
}

great_wizard_gateway = {
	cast = function(player,city)
		if city == "" then
			return
		end
		player:removeDuras(venoms)
		player:removeDuras(curses)
	end
}

assess_karma = {
	cast = async(function(player)
		local t = {}

		player.npcGraphic = 0
		player.npcColor = 0
		player.dialogType = 0
		player.lastClick = player.ID

		local magicCost = 1250
		if player:carnageSpell() then
			return
		end

		if (not player:canCast(0, 1, 0)) or (not player.pvp == 0) then
			return
		end
		if (player.magic < magicCost) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		local input = player:inputLetterCheck(player:inputSeq(
			"Who's karma shall you read?",
			"The one known as",
			"shall be examined.",
			{},
			{}
		))
		local target = Player(input)

		if target == nil then
			player:dialogSeq({t, "Player is not online or unavailable."}, 0)
			return
		end

		if target.ID == player.ID then player:dialogSeq({t,"You cannot assess your own karma."},0) return end

		player.magic = player.magic - magicCost
		player:sendStatus()

		local karma = target.karma
		local text = ""
		local text2 = ""

		--t = {graphic = convertGraphic(111, "monster"), color = 0}

		if karma <= -3 then
			-- snake
			t = {graphic = convertGraphic(184, "monster"), color = 25}
			text = target.name .. " is among the cursed of the earth; they crawl alone in shame."
			text2 = "You are among the cursed of the earth; you crawl alone in shame."
		elseif karma > -3 and karma < 0 then
			-- rat
			t = {graphic = convertGraphic(91, "monster"), color = 10}
			text = target.name .. " is out of favor with the Gods; they must purify their soul and cleanse their spirit."
			text2 = "You are out of favor with the Gods; you must purify your soul and cleanse your spirit."
		elseif karma >= 0 and karma < 1 then
			-- cat
			t = {graphic = convertGraphic(182, "monster"), color = 30}
			text = target.name .. " has begun the journey to perfection."
			text2 = "You have begun the journey to perfection."
		elseif karma >= 1 and karma < 2 then
			-- squirrel
			t = {graphic = convertGraphic(25, "monster"), color = 9}
			text = target.name .. "'s education progresses; they store knowledge for the ordeals to come."
			text2 = "Your education progresses; you store knowledge for the ordeals to come."
		elseif karma >= 2 and karma < 3 then
			-- rabbit
			t = {graphic = convertGraphic(21, "monster"), color = 3}
			text = target.name .. "'s soul moves ever quicker toward its goal."
			text2 = "Your soul moves ever quicker toward its goal."
		elseif karma >= 3 and karma < 4 then
			-- dog
			t = {graphic = convertGraphic(18, "monster"), color = 12}
			text = target.name .. " is faithful to the teachings of the Gods."
			text2 = "You are faithful to the teachings of the Gods."
		elseif karma >= 4 and karma < 6 then
			-- monkey
			t = {graphic = convertGraphic(126, "monster"), color = 5}
			text = target.name .. " is clever and good-hearted; the Gods smile upon them."
			text2 = "You are clever and good-hearted; the Gods smile upon you."
		elseif karma >= 6 and karma < 8 then
			-- ox
			t = {graphic = convertGraphic(27, "monster"), color = 9}
			text = target.name .. " is stalwart and honest, worthy of trust, strong of heart."
			text2 = "You are stalwart and honest, worthy of trust, strong of heart."
		elseif karma >= 8 and karma < 11 then
			-- bear
			t = {graphic = convertGraphic(24, "monster"), color = 9}
			text = target.name .. " holds quiet power and and great wisdom, confidence and fortitude."
			text2 = "You hold quiet power and and great wisdom, confidence and fortitude."
		elseif karma >= 11 and karma < 14 then
			-- tiger
			t = {graphic = convertGraphic(29, "monster"), color = 9}
			text = target.name .. " has entered the nobility of souls -- fierce, wise and just."
			text2 = "You have entered the nobility of souls -- fierce, wise and just."
		elseif karma >= 14 and karma < 19 then
			-- dragon
			t = {graphic = convertGraphic(108, "monster"), color = 2}
			text = target.name .. " is at the pinnacle of mortal grace; their soul is noble, beautiful and fearsome to behold."
			text2 = "You are at the pinnacle of mortal grace; your soul is noble, beautiful and fearsome to behold."
		elseif karma >= 19 and karma < 24 then
			-- spirit
			t = {graphic = convertGraphic(167, "monster"), color = 24}
			text = target.name .. " has reached the threshold of immortality; they put aside mortal possessions and passions."
			text2 = "You have reached the threshold of immortality; you put aside mortal possessions and passions."
		elseif karma >= 24 and karma < 30 then
			-- angel's tear
			t = {graphic = convertGraphic(428, "item"), color = 0}
			text = target.name .. "'s journey has been long; they have achieved inner peace and tranquility; they speak with the Gods."
			text2 = "Your journey has been long; you have achieved inner peace and tranquility; you speak with the Gods."
		elseif karma >= 30 then
			-- angel
			t = {graphic = convertGraphic(49, "monster"), color = 5}
			text = target.name .. " is one with the Gods, and their soul is worthy to dwell among them."
			text2 = "You are one with the Gods, and your soul is worthy to dwell among them."
		end

		player:setAether("assess_karma", 10800000)

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = player.ID

		player:dialogSeq({t, text}, 1)

		target.npcGraphic = t.graphic
		target.npcColor = t.color
		target.dialogType = 0
		target.lastClick = player.ID

		target:freeAsync()
		target:dialogSeq({t, text2}, 0)
	end),
}

canPushMobs = function(block, target, push)
	--This function can allow people to steal stuff by pushing
	if (target == nil) then
		return nil
	elseif (target.blType == BL_NPC and (target.subType == 2 or target.subType == 3)) then
		return false
	elseif (target.blType == BL_MOB) then
		if (target.isBoss == 1) then
			return false
		end
	elseif (target.blType == BL_ITEM) then
		return false
	end

	if (target.blind == true) then
		return false
	end

	if (block.side == 0) then
		local checkPCNorth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y - 2,
			BL_PC
		)
		local checkMobNorth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y - 2,
			BL_MOB
		)
		local checkNPCNorth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y - 2,
			BL_NPC
		)

		local checkPCEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_PC
		)
		local checkMobEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_MOB
		)
		local checkNPCEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_NPC
		)

		local checkPCWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_PC
		)
		local checkMobWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_MOB
		)
		local checkNPCWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_NPC
		)

		if (#checkNPCNorth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end

		if (#checkNPCEast > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end

		if (#checkNPCWest > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end

		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end

			if (#checkPCEast > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end

			if (#checkPCWest > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end

		if (block.y - 2 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(
			block.x,
			block.y - 2,
			0
		) == true and getPass(block.m, block.x, block.y - 2) == 0 and not getWarp(
			block.m,
			block.x,
			block.y - 2
		)) then
			if (push == nil) then
				target:warp(block.m, block.x, block.y - 2)
			else
				return true
			end
		elseif (block.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(
			block.x + 1,
			block.y - 1,
			1
		) == true and getPass(block.m, block.x + 1, block.y - 1) == 0 and not getWarp(
			block.m,
			block.x + 1,
			block.y - 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y - 1)
			else
				return true
			end
		elseif (block.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(
			block.x - 1,
			block.y - 1,
			3
		) == true and getPass(block.m, block.x - 1, block.y - 1) == 0 and not getWarp(
			block.m,
			block.x - 1,
			block.y - 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y - 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 1) then
		local checkPCEast = block:getObjectsInCell(
			block.m,
			block.x + 2,
			block.y,
			BL_PC
		)
		local checkMobEast = block:getObjectsInCell(
			block.m,
			block.x + 2,
			block.y,
			BL_MOB
		)
		local checkNPCEast = block:getObjectsInCell(
			block.m,
			block.x + 2,
			block.y,
			BL_NPC
		)

		local checkPCNorth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_PC
		)
		local checkMobNorth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_MOB
		)
		local checkNPCNorth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y - 1,
			BL_NPC
		)

		local checkPCSouth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_PC
		)
		local checkMobSouth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_MOB
		)
		local checkNPCSouth = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_NPC
		)

		if (#checkNPCNorth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end

		if (#checkNPCEast > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end

		if (#checkNPCSouth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end

		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end

			if (#checkPCSouth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end

			if (#checkPCEast > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end
		end

		if (block.x + 2 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(
			block.x + 2,
			block.y,
			1
		) == true and getPass(block.m, block.x + 2, block.y) == 0 and not getWarp(
			block.m,
			block.x + 2,
			block.y
		)) then
			if (push == nil) then
				target:warp(block.m, block.x + 2, block.y)
			else
				return true
			end
		elseif (block.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(
			block.x + 1,
			block.y - 1,
			0
		) == true and getPass(block.m, block.x + 1, block.y - 1) == 0 and not getWarp(
			block.m,
			block.x + 1,
			block.y - 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y - 1)
			else
				return true
			end
		elseif (block.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(
			block.x + 1,
			block.y + 1,
			2
		) == true and getPass(block.m, block.x + 1, block.y + 1) == 0 and not getWarp(
			block.m,
			block.x + 1,
			block.y + 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 2) then
		local checkPCSouth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y + 2,
			BL_PC
		)
		local checkMobSouth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y + 2,
			BL_MOB
		)
		local checkNPCSouth = block:getObjectsInCell(
			block.m,
			block.x,
			block.y + 2,
			BL_NPC
		)

		local checkPCEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_PC
		)
		local checkMobEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_MOB
		)
		local checkNPCEast = block:getObjectsInCell(
			block.m,
			block.x + 1,
			block.y + 1,
			BL_NPC
		)

		local checkPCWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_PC
		)
		local checkMobWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_MOB
		)
		local checkNPCWest = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_NPC
		)

		if (#checkNPCSouth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end

		if (#checkNPCEast > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCEast[i].subType == 2 or checkNPCEast[i].subType == 3) then
					table.remove(checkNPCEast, i)
					i = i - 1
				end
			until (i == #checkNPCEast)
		end

		if (#checkNPCWest > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end

		if (block.showGhosts == 1) then
			if (#checkPCEast > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCEast[i].state == 1) then
						table.remove(checkPCEast, i)
						i = i - 1
					end
				until (i == #checkPCEast)
			end

			if (#checkPCSouth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end

			if (#checkPCWest > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end

		if (block.y + 2 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(
			block.x,
			block.y + 2,
			2
		) == true and getPass(block.m, block.x, block.y + 2) == 0 and not getWarp(
			block.m,
			block.x,
			block.y + 2
		)) then
			if (push == nil) then
				target:warp(block.m, block.x, block.y + 2)
			else
				return true
			end
		elseif (block.x + 1 <= block.xmax and #checkPCEast + #checkMobEast + #checkNPCEast == 0 and block:objectCanMove(
			block.x + 1,
			block.y + 1,
			1
		) == true and getPass(block.m, block.x + 1, block.y + 1) == 0 and not getWarp(
			block.m,
			block.x + 1,
			block.y + 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x + 1, block.y + 1)
			else
				return true
			end
		elseif (block.x - 1 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(
			block.x - 1,
			block.y + 1,
			3
		) == true and getPass(block.m, block.x - 1, block.y + 1) == 0 and not getWarp(
			block.m,
			block.x - 1,
			block.y + 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	elseif (block.side == 3) then
		local checkPCWest = block:getObjectsInCell(
			block.m,
			block.x - 2,
			block.y,
			BL_PC
		)
		local checkMobWest = block:getObjectsInCell(
			block.m,
			block.x - 2,
			block.y,
			BL_MOB
		)
		local checkNPCWest = block:getObjectsInCell(
			block.m,
			block.x - 2,
			block.y,
			BL_NPC
		)

		local checkPCNorth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_PC
		)
		local checkMobNorth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_MOB
		)
		local checkNPCNorth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y - 1,
			BL_NPC
		)

		local checkPCSouth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_PC
		)
		local checkMobSouth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_MOB
		)
		local checkNPCSouth = block:getObjectsInCell(
			block.m,
			block.x - 1,
			block.y + 1,
			BL_NPC
		)

		if (#checkNPCNorth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCNorth[i].subType == 2 or checkNPCNorth[i].subType == 3) then
					table.remove(checkNPCNorth, i)
					i = i - 1
				end
			until (i == #checkNPCNorth)
		end

		if (#checkNPCSouth > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCSouth[i].subType == 2 or checkNPCSouth[i].subType == 3) then
					table.remove(checkNPCSouth, i)
					i = i - 1
				end
			until (i == #checkNPCSouth)
		end

		if (#checkNPCWest > 0) then
			i = 0

			repeat
				i = i + 1

				if (checkNPCWest[i].subType == 2 or checkNPCWest[i].subType == 3) then
					table.remove(checkNPCWest, i)
					i = i - 1
				end
			until (i == #checkNPCWest)
		end

		if (block.showGhosts == 1) then
			if (#checkPCNorth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCNorth[i].state == 1) then
						table.remove(checkPCNorth, i)
						i = i - 1
					end
				until (i == #checkPCNorth)
			end

			if (#checkPCSouth > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCSouth[i].state == 1) then
						table.remove(checkPCSouth, i)
						i = i - 1
					end
				until (i == #checkPCSouth)
			end

			if (#checkPCWest > 0) then
				i = 0

				repeat
					i = i + 1

					if (checkPCWest[i].state == 1) then
						table.remove(checkPCWest, i)
						i = i - 1
					end
				until (i == #checkPCWest)
			end
		end

		if (block.x - 2 > 0 and #checkPCWest + #checkMobWest + #checkNPCWest == 0 and block:objectCanMove(
			block.x - 2,
			block.y,
			3
		) == true and getPass(block.m, block.x - 2, block.y) == 0 and not getWarp(
			block.m,
			block.x - 2,
			block.y
		)) then
			if (push == nil) then
				target:warp(block.m, block.x - 2, block.y)
			else
				return true
			end
		elseif (block.y - 1 > 0 and #checkPCNorth + #checkMobNorth + #checkNPCNorth == 0 and block:objectCanMove(
			block.x - 1,
			block.y - 1,
			0
		) == true and getPass(block.m, block.x - 1, block.y - 1) == 0 and not getWarp(
			block.m,
			block.x - 1,
			block.y - 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y - 1)
			else
				return true
			end
		elseif (block.y + 1 <= block.ymax and #checkPCSouth + #checkMobSouth + #checkNPCSouth == 0 and block:objectCanMove(
			block.x - 1,
			block.y + 1,
			2
		) == true and getPass(block.m, block.x - 1, block.y + 1) == 0 and not getWarp(
			block.m,
			block.x - 1,
			block.y + 1
		)) then
			if (push == nil) then
				target:warp(block.m, block.x - 1, block.y + 1)
			else
				return true
			end
		else
			return false
		end
	end

	return false
end

fourPushMobs = function(block, blockType)
	--This function can allow pushing to steal items
	local blocksNorth = block:getObjectsInCell(
		block.m,
		block.x,
		block.y - 1,
		blockType
	)
	local blocksEast = block:getObjectsInCell(
		block.m,
		block.x + 1,
		block.y,
		blockType
	)
	local blocksWest = block:getObjectsInCell(
		block.m,
		block.x - 1,
		block.y,
		blockType
	)
	local blocksSouth = block:getObjectsInCell(
		block.m,
		block.x,
		block.y + 1,
		blockType
	)
	local side = block.side

	if (#blocksNorth > 0) then
		block.side = 0
		canPushMobs(block, blocksNorth[1])
	end

	if (#blocksEast > 0) then
		block.side = 1
		canPushMobs(block, blocksEast[1])
	end

	if (#blocksSouth > 0) then
		block.side = 2
		canPushMobs(block, blocksSouth[1])
	end

	if (#blocksWest > 0) then
		block.side = 3
		canPushMobs(block, blocksWest[1])
	end

	block.side = side
end

diamond_dust = {
	cast = function(player, target)
		if not player:canCast(1, 1, 0) then
			return
		end	
		if player:carnageSpell() then
			return
		end
		local magicCost = 1000

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if target ~= nil then
			
			if target.blType ~= BL_PC then
				player:sendminitext("You can't do that.")
				return
			end
			if target:hasDuration("diamond_dust") then
				target:flushDurationNoUncast(26002, 26002)
				target:setDuration("diamond_dust", 30000, player.ID) 
			else
				target:setDuration("diamond_dust", 30000, player.ID) 
			end
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendAnimation(12, 1)
			player:sendMinitext("You cast Diamond dust.")
			target:setDuration("diamond_dust", 30000, player.ID)
			player:setAether("diamond_dust", 28000)
			player:sendAction(6, 80)
			player:playSound(10)
		end
	end,
	
	while_cast = function(target, caster)
	
		if not target:canCast(1, 1, 0) then
			return
		end
		
		if caster == nil then
			return
		end

		local magicCost = 50 
		local targets
		local range = 1
		
		if (caster.m ~= target.m)  
		or (distance(caster, target) > 10) then 
			caster:sendMinitext("The link between you and your target weakens.")
			return 
		end 
		if caster.magic < magicCost then 
			caster:sendMinitext("Your will is too weak.") 
			return 
		end 
		
		local weapon = target:getEquippedItem(0)
		if weapon == nil then
			weapon = {class = 0}
		end
		
		if (target.extendHit == true) or weapon.class == 24 or weapon.class == 28 then
			magicCost = 100
			range = 2
			if target.state ~= 3 and target.state ~= 1 then
				fourPushMobs(target,BL_MOB) 
			end
			targets = target:getObjectsInArea(BL_MOB) 

			destinationOffsets = {
			 {x = -2, y = 0}, {x = 2, y = 0},
			 {x = 0, y = -2}, {x = 0, y = 2},
			 {x = 1, y = -1}, {x = -1, y = 1},
			 {x = -1, y = -1}, {x = 1, y = 1}			
			} 
			for i = 1, #destinationOffsets, 1 do 
				local destination = {x = target.x + destinationOffsets[i].x, y = target.y + destinationOffsets[i].y} 
				if (destination.x >= 0 and destination.x <= getMapXMax(target)  
				and destination.y >= 0 and destination.y <= getMapYMax(target)) then 
					target:sendAnimationXY(22, destination.x, destination.y, 2) 
				end 
			end
		else
			targets = getTargetsAround(target, BL_MOB)
			target:sendAnimationXY(22, target.x, target.y + 1, 2)
			target:sendAnimationXY(22, target.x, target.y - 1, 2)
			target:sendAnimationXY(22, target.x + 1, target.y, 2)
			target:sendAnimationXY(22, target.x - 1, target.y, 2)
		end

		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do 
					if distance(target, targets[i]) == range then 
						if targets[i].isBoss == 0 then
							if targets[i]:hasDuration("paralyze_mage") then
								targets[i]:flushDurationNoUncast(3116, 3116)
								targets[i]:setDuration("paralyze_mage", 2000) 
								targets[i].paralyzed = true 
							else
								targets[i]:setDuration("paralyze_mage", 2000) 
							end
							targets[i].paralyzed = true 
						end
					end 
				end
			end 
		end
		
		caster:removeMagic(magicCost) 
		caster:sendStatus() 

		caster:sendAnimation(12, 1) 
		target:sendAnimation(3, 0) 
	end, 
	uncast = function(target)
	end
}

red_curse = {
	cast = function(player, target)
		if not player:canCast(1, 1, 0) then
			return
		end	
		local magicCost = 1000
		if player:carnageSpell() then
			return
		end

		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end

		if target ~= nil then
			if target.blType ~= BL_PC then
				player:sendminitext("You can't do that.")
				return
			end
			if target:hasDuration("red_curse") then
				target:flushDurationNoUncast(26003, 26003)
				target:setDuration("red_curse", 30000, player.ID) 
			else
				target:setDuration("red_curse", 30000, player.ID) 
			end
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendAnimation(12, 1)
			player:sendMinitext("You cast red curse.")
			--target:setDuration("red_curse", 30000, player.ID)
			player:setAether("red_curse", 28000)
			player:sendAction(6, 80)
			player:playSound(10)
		end
	end,
	
	while_cast = function(target, caster)
		if not target:canCast(1, 1, 0) then
			return
		end	
		local magicCost = 75 
		local targets
		local range = 1
		
		if (caster.m ~= target.m)  
		or (distance(caster, target) > 10) then 
			caster:sendMinitext("The link between you and your target weakens.")
			return 
		end 
		if caster.magic < magicCost then 
			caster:sendMinitext("Your will is too weak.") 
			return 
		end 
		
		local weapon = target:getEquippedItem(0)
		if weapon == nil then
			weapon = {class = 0}
		end
		
		if (target.extendHit == true) or weapon.class == 24 or weapon.class == 28 then
			magicCost = 150
			range = 2
			if target.state ~= 3 and target.state ~= 1 then
				fourPushMobs(target,BL_MOB) 
			end
			targets = target:getObjectsInArea(BL_MOB) 

			destinationOffsets = {
			 {x = -2, y = 0}, {x = 2, y = 0},
			 {x = 0, y = -2}, {x = 0, y = 2},
			 {x = 1, y = -1}, {x = -1, y = 1},
			 {x = -1, y = -1}, {x = 1, y = 1}			
			} 
			for i = 1, #destinationOffsets, 1 do 
				local destination = {x = target.x + destinationOffsets[i].x, y = target.y + destinationOffsets[i].y} 
				if (destination.x >= 0 and destination.x <= getMapXMax(target)  
				and destination.y >= 0 and destination.y <= getMapYMax(target)) then 
					target:sendAnimationXY(191, destination.x, destination.y, 2) 
				end 
			end
		else
			targets = getTargetsAround(target, BL_MOB)
			target:sendAnimationXY(191, target.x, target.y + 1, 2)
			target:sendAnimationXY(191, target.x, target.y - 1, 2)
			target:sendAnimationXY(191, target.x + 1, target.y, 2)
			target:sendAnimationXY(191, target.x - 1, target.y, 2)
		end

		if targets ~= nil then
			if #targets > 0 then
				for i = 1, #targets do 
					if distance(target, targets[i]) == range then 
						if targets[i].isBoss == 0 then
							if targets[i]:hasDuration("paralyze_mage") then
								targets[i]:flushDurationNoUncast(3116, 3116)
								targets[i]:setDuration("paralyze_mage", 2000) 
								targets[i].paralyzed = true 
							else
								targets[i]:setDuration("paralyze_mage", 2000) 
							end
							targets[i].paralyzed = true 
						end
					end 
				end
			end 
		end
		
		caster:removeMagic(magicCost) 
		caster:sendStatus() 

		caster:sendAnimation(12, 1) 
		target:sendAnimation(3, 0) 
	end, 
	uncast = function(target)
	end
}

sa_san_orb_of_mana = {
	on_swing = function(player)
		orb_of_mana.on_swing(player)
	end
}
sam_san_orb_of_mana = {
	on_swing = function(player)
		orb_of_mana.on_swing(player)
	end
}
ee_san_orb_of_mana = {
	on_swing = function(player)
		orb_of_mana.on_swing(player)
	end
}
il_san_orb_of_mana = {
	on_swing = function(player)
		orb_of_mana.on_swing(player)
	end
}
enchanted_orb_of_mana = {
	on_swing = function(player)
		orb_of_mana.on_swing(player)
	end
}
orb_of_mana = {
	on_swing = function(player) 
		target = getTargetFacing(player, BL_MOB)
		if target == nil then
			target = getTargetFacing(player, BL_PC)
			if target == nil then return end
		end
		if not player.spell then 
			return 
		end 
		
		local inGroup = false

		if not player:canCast(1, 1, 0) then
			return
		end

		if (target.state == 1) then
			player:sendMinitext("You cannot reach the spirit world.")
			return
		end

		for i = 1, #player.group do
			if target.ID == player.group[i] then
				inGroup = true
				break
			end
		end

		local tmana = 0
		local mana = 0
		local tmanaMax = target.maxMagic * 0.10
		local manaMax = player.maxMagic * 0.10
		tmana = target.maxMagic * 0.10
		mana = player.magic * 0.10
		if (tmana < mana) then
			mana = tmana
		end

		if target.blType == BL_PC then

			if inGroup == true then--Give Mana
				if player.magic < mana then
					mana = player.magic
				end
				target:addMagic(mana)
				player:removeMagic(mana)
			else--Take mana
				local rand = math.random(1,10)
				if rand < 6 then
					return
				end
				if (target.pvp == 1) then
					if math.random(100) % 6 == 0  and os.time() > player.registry["orb_of_mana"] then
						tmana = target.maxMagic * 0.10
						mana = player.maxMagic * 0.10
						if (tmana < mana) then
							mana = tmana
						end
						if (target.magic < mana) then
							mana = target.magic
						end
						player:addMagic(mana)
						target:removeMagic(mana)
						if math.random(100) % 2 == 0 then
							target:sendMinitext(player.name .. " takes your mana.")
						end
						player:sendAnimation(3)
						target:sendAnimation(76)
						player.registry["orb_of_mana"] = os.time() + 11
					end
				else
					return
				end
			end
		elseif target.blType == BL_MOB then	
			if (target.behavior == 2) or (target.isBoss > 0) 
			or (target.behavior == 3) or (target.aiType == 3) then 
				--target:talk(0,"Behavior: "..target.behavior.." isBoss: "..target.isBoss.." AI: "..target.aiType)
				return 
			end 
			local rand = math.random(1,10)
			if rand < 5 then
				--target:talk(0,"Random: "..rand)
				return
			end
			if target.magic < mana then
				mana = target.magic
			end
			player:addMagic(mana)
			target:removeMagic(mana)
		end	
		target:sendStatus()
		player:sendStatus()
	end
} 

wizard_librarian = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		local opts = {"Buy", "Sell", "Talk to Librarian"}
		local collect = false
		local books = {{book=12324, x=15, y=3}, {book=12325, x=15, y=4}, {book=12326, x=1, y=11}}
		for i = 1, #books do
			if (getObject(npc.m, books[i].x, books[i].y) > 0) then
				collect = true
				break
			end
		end
		if (collect == true) then
			table.insert(opts, "Help shelf some books")
		end
		local menu = player:menuString("Hello! How can I help you today?", opts)

		if menu == "Buy" then
			player:buyExtend(
				"I think I can accomodate some of the things you need. What would you like?",
				wizard_librarian.buyItems()
			)
		elseif menu == "Sell" then
			player:sellExtend("What are you willing to sell today?", wizard_librarian.sellItems())
		elseif menu == "Talk to Librarian" then
			wizard_librarian.onSayClick(player, npc)
		elseif menu == "Help shelf some books" then
			wizard_librarian.shelfBooks(npc, player)
		end
	end),

	shelfBooks = function(npc, player)
		local collect = false
		local bookCount = 0
		local books = {{book=12324, x=15, y=3}, {book=12325, x=15, y=4}, {book=12326, x=1, y=11}}
		for i = 1, #books do
			if (getObject(npc.m, books[i].x, books[i].y) > 0) then
				bookCount = bookCount + 1
				collect = true
			end
		end
		if (collect == false) then
			for i = 1, #books do
				npc:spawn(818, books[i].x, books[i].y, 1, npc.m)
				--npc:setObject(npc.m, books[i].x, books[i].y, books[i].book)
			end
		end

		if (bookCount == 0) then
			collect = true
			npc:talk(0,"Grats!")
		end
	end,
	
	buyItems = function()
		local buyOpts = {
			"unified_theory_of_magic",
			"ranger_code"
		}

		return buyOpts
	end,

	sellItems = function()
		local sellItems = wizard_librarian.buyItems()

		if (Config.bossDropSalesEnabled) then
			table.insert(sellItems, "key_to_earth")
			table.insert(sellItems, "key_to_fire")
			table.insert(sellItems, "key_to_wind")
			table.insert(sellItems, "key_to_heaven")
			table.insert(sellItems, "key_to_pond")
			table.insert(sellItems, "key_to_thunder")
			table.insert(sellItems, "key_to_water")
			table.insert(sellItems, "key_to_mountain")
		end

		return sellItems
	end,

	onSayClick = async(function(player, npc)
		local speech = string.lower(player.speech)

		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		if speech == "map" or speech == "fragment" or speech == "map fragment" then
			if player.quest["instance"] == 4 then
				player:dialogSeq(
					{
						t,
						"Here we go. It looks to be a map of some mountains north of here.",
						"Maybe someone with deep historical knowledge will be able to help you."
					},
					1
				)
			end
			if player.quest["instance"] == 3 then
				if player:hasItem("map_fragment", 5) == true then
					player:removeItem("map_fragment", 5)
					player:addItem("combined_map", 1)
					player.quest["instance"] = 4
					player:dialogSeq(
						{
							t,
							"Here we go. It looks to be a map of some mountains north of here.",
							"Maybe someone with deep historical knowledge will be able to help you."
						},
						1
					)
				else
					player:dialogSeq(
						{t, "Did you get more pieces of this map?"},
						1
					)
				end
			end
			if player.quest["instance"] == 2 then
				if player:hasItem("purified_water", 1) == true then
					player:removeItem("purified_water", 1)
					player.quest["instance"] = 3
					player:dialogSeq(
						{
							t,
							"Ah yes here we go, the piece is coming in more clear.",
							"It seems to be piece of a much larger map.",
							"Go collect for me 4 more pieces and we can put together a map to see where this goes."
						},
						1
					)
				else
					player:dialogSeq(
						{t, "Come back to me when you get some purified water."},
						1
					)
				end
			end
			if player:hasItem("map_fragment", 1) == true and player.quest["instance"] == 1 then
				player.quest["instance"] = 2
				player:dialogSeq(
					{
						t,
						"What is this? You were sent by Elder Zephyr to find out more about this map?",
						"It seems pretty dirty. Let's try and clean it up",
						"Go gather some purified water and come back to me. I will use great care on this precious piece."
					},
					1
				)
			end
		end
	end)
}
wizard_shelf = {
	on_spawn=function(mob)
		if (getObject(mob.m, mob.x, mob.y) == 0) then		
			setObject(mob.m, mob.x, mob.y, math.random(12324, 12326))
		end
	end,
	on_attacked = function(mob, attacker)
		mob:talk(0,"attacked")
		mob_ai_basic.on_attacked(mob, attacker)
	end,
	after_death = function(mob, attacker)
		setObject(mob.m, mob.x, mob.y, 0)
		mob_ai_basic.after_death(mob, attacker)
	end
}

getTargetRanged = function(player, BL_TYPE, range)--Line
--Returns first block found checking PASS, if no block found returns coords.

	if (range == nil) then
		range = 7
	end

	local side = player.side

	if (side == 0) then
		for y = 1, range do
			if (#player:getObjectsInCell(player.m, player.x, player.y - y, BL_TYPE) > 0) then
				if (BL_TYPE == BL_PC and player:getObjectsInCell(player.m, player.x, player.y - y, BL_TYPE)[1].state == 1) then
				else
					return player:getObjectsInCell(player.m, player.x, player.y - y, BL_TYPE)
				end
			end
		end
	end
	if (side == 2) then
		for y = 1, range do
			if (#player:getObjectsInCell(player.m, player.x, player.y + y, BL_TYPE) > 0) then
				if (BL_TYPE == BL_PC and player:getObjectsInCell(player.m, player.x, player.y + y, BL_TYPE)[1].state == 1) then
				else
					return player:getObjectsInCell(player.m, player.x, player.y + y, BL_TYPE)
				end
			end
		end
	end
	if (side == 1) then
		for x = 1, range do
			if (#player:getObjectsInCell(player.m, player.x + x, player.y, BL_TYPE) > 0) then
				if (BL_TYPE == BL_PC and player:getObjectsInCell(player.m, player.x + x, player.y, BL_TYPE)[1].state == 1) then
				else
					return player:getObjectsInCell(player.m, player.x + x, player.y, BL_TYPE)
				end
			end
		end
	end
	if (side == 3) then
		for x = 1, range do
			if (#player:getObjectsInCell(player.m, player.x - x, player.y, BL_TYPE) > 0) then
				if (BL_TYPE == BL_PC and player:getObjectsInCell(player.m, player.x - x, player.y, BL_TYPE)[1].state == 1) then
				else
					return player:getObjectsInCell(player.m, player.x - x, player.y, BL_TYPE)
				end
			end
		end
	end
	return nil
end

line_side = function(player, dist)--dist is tiles to the side (radius), not total tiles
	local line = {}
	local xMax = player.xmax
	local yMax = player.ymax
	local side = player.side
	local x = player.x
	local y = player.y
	local x2 = 0
	local y2 = 0
	
	if dist == nil then
		dist = 1
	end
	
	if (side == 0) or (side == 2) then
		for i = -dist, dist do
			x2 = x + i
			if not((x2 < 0) or (x2 > xMax)) then
				table.insert(line, {x2, y})
			end
		end
	elseif (side == 1) or (side == 3) then
		for i = -dist, dist do
			y2 = y + i
			if not((y2 < 0) or (y2 > yMax)) then
				table.insert(line, {x, y2})
			end
		end
	else
		return nil
	end
	return line--returns table {{x,y},{x2,y2}}, etc 
end

thunderstorm = {
	cast = function(block, target)
		local spellName = "Thunderstorm"
		local magicCost = math.floor(block.maxMagic * 0.06)
		if not block:canCast(1, 1, 0) then
			return
		end
		if block:carnageSpell() then
			return
		end
		if (block.magic < magicCost) then
			block:sendMinitext("You do not have enough mana.")
			return
		end
		if target.blType ~= BL_PC then
			block:sendMinitext("You can't target this.")
			return
		end
		if target:hasDurationID("thunderstorm", block.ID) then
			block:sendMinitext("You can't cast that yet.")
			return
		end

		block:sendMinitext("You cast Thunderstorm.")
		block:removeMagic(magicCost)
		block:sendAction(6, 80)		
		target:setDuration("thunderstorm", 30000, block.ID)
		target.registry["thunderstorm"] = target.registry["thunderstorm"] + math.random(65, 76)
		block.registry["ionic_charge"] = block.registry["ionic_charge"] + 5 + block.mark
		if block.registry["ionic_charge"] > 35 then
			block.registry["ionic_charge"] = 35
		end
		block:setAether("thunderstorm", 28000)
	end,
	while_cast = function(block, caster)
		thunderstorm.misses(block)
		local charges = block.registry["thunderstorm"]
		local duration = block:getDuration("thunderstorm")
		if block.m ~= caster.m then
--			block.registry["thunderstorm"] = 0
--			block:setDuration("thunderstorm",0)
--			charges = 0
--			duration = 0
			return
		end
		if duration <= 0 or charges <= 0 then
			return 
		end
		
		if caster == nil then
			return
		end
		
		local ani = 420
		local aoe = 4
		local possible = block:getObjectsInArea(BL_MOB)
		local zapped = {}
		
		if possible ~= nil then
			for i = 1, #possible do
				if (distance(block, possible[i]) < aoe) then
					table.insert(zapped, possible[i])
				end
			end
		end
		
		if duration <= 1 then
			return
		end
		local strikes = math.ceil(charges/(duration/1000))
		--block:talk(2,"Strikes: "..strikes)
		
		if strikes < 0 then
			return
		end
		local damage = 1500 + math.ceil((caster.will + 2) / 3) * 40.325 + caster.maxMagic * 0.12 * (1 + (caster.mark / 2))
		
		for i = 1, strikes do
			charges = block.registry["thunderstorm"]
			if zapped ~= nil then
				if #zapped > 0 then
					local rand2 = math.random(1,#zapped)
					if charges > 0 then
						local worked = global_zap.cast(block, zapped[rand2], damage, 0, -1000)
						if worked ~= 0 then
							zapped[rand2]:sendAnimation(ani)
							block.registry["thunderstorm"] = charges - 1
						end
					end
				end
			end
		end
	end,
	uncast = function(block)
		if block.registry["thunderstorm"] > 5 then
			block.registry["thunderstorm"] = 5
		elseif block.registry["thunderstorm"] < 1 then
			block.registry["thunderstorm"] = 0
		end
		--Thanks for participating, you have not been chosen.
	end,
	misses = function(block)
		local aoe = 4
		local miss = math.random(1,3)
		local x2, y2
		local ani = 420
		if (math.random(1,100) % math.random(2,3) == 0) then
			return
		end
		for i = 1, miss do
			x2 = block.x + math.random(-aoe, aoe)
			y2 = block.y + math.random(-aoe, aoe)
			if (block:getObjectsInCell(block.m, x2, y2, BL_MOB) ~= nil) then
			--and distance(block, x2, y2) < aoe) then
				--block:talk(0," ,")
				block:sendAnimationXY(ani, x2, y2)
			end
		end	
	end,
}

meditate = {
	cast = function(player)
		local magic = 0
		local duration = 10000
		if (not player:canCast(1, 1, 0)) then
			return
		end
		if player:carnageSpell() then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		player:sendAction(6, 35)
		player.magic = player.magic - magic
		player:sendStatus()
		player:setDuration("meditate", duration)
		player:setAether("meditate", duration)
		player:sendMinitext("You cast Meditate")
		player:playSound(12)
		player:sendAnimation(347)
		player:calcStat()
	end,
	recast = function(target)
		target.maxMagic = target.maxMagic * 1.2
		target.healing = target.healing + 50
		target.protection = target.protection + 5
		target:sendStatus()
		target.speed = target.speed + 35
		target:refresh()
	end,
	uncast = function(target)
		target:calcStat()
	end,
	while_cast = function(player)
		player:addMagic(player.maxMagic * 0.10)
		player:sendAnimation(347)
	end
}

blink = {

	cast = function(player)
		local d = {}
		local m = player.m
		local x = player.x
		local y = player.y
		local distFinish = 0
		local sound = 60
		local counter = 0
		local magic = 1
		local aether = 18000
		local blink = player.registry["blink"]

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
		
		if (blink < 6) then
			player:sendMinitext("You do not have enough blink charges left.")
			return
		else	
			player.registry["blink"] = blink - 6
		end

		repeat
			counter = counter + 1
			if (player.side == 0) then
				y = y - 1
			end
			if (player.side == 1) then
				x = x + 1
			end
			if (player.side == 2) then
				y = y + 1
			end
			if (player.side == 3) then
				x = x - 1
			end

			if (checkSpecificTile(player, x, y)) then
				distFinish = counter
			else
				counter = 5
			end
		until counter >= 4
		
		player:sendAnimationXY(432, player.x, player.y)		

		if (player.x - distFinish < 0 and player.side == 3) then
			distFinish = player.x
		end
		if (player.y - distFinish < 0 and player.side == 0) then
			distFinish = player.y
		end

		--player:talk(0,""..distFinish..counter)
		if (player.side == 0) then
			player:warp(player.m, player.x, player.y - distFinish)
		end
		if (player.side == 1) then
			player:warp(player.m, player.x + distFinish, player.y)
		end
		if (player.side == 2) then
			player:warp(player.m, player.x, player.y + distFinish)
		end
		if (player.side == 3) then
			player:warp(player.m, player.x - distFinish, player.y)
		end
		player:sendAction(6, 35)
		if (math.floor(player.registry["blink"] / 6) < 1) then
			player:setAether("blink", aether)
		end

		player:sendAnimation(433)
	end,
	while_passive = function(player)
		local blink = player.registry["blink"]
		if blink >= 24 then
			return
		end
		if player.magic < 1000 then
			return
		else
			player:removeMagic(500)
		end
		player.registry["blink"] = blink + 1
		local charges = "Blink: "..math.floor(player.registry["blink"] / 6)
		player:guitext(charges)
		blink = player.registry["blink"]
		if player:hasAether("blink") then
			if (os.time()%2 == 0) then
				player:sendAnimation(447)
			end
			return
		end
		if (blink > 3) then
		elseif (blink < 1) then
			player:sendAnimation(447)
		else
			if (os.time()%2 == 0) then
				player:sendAnimation(447)
			end
		end
	end
}

ionic_blast = {
	cast = function(player, target)
		if not player:canCast(1, 1, 0) then
			return
		end
		if player:carnageSpell() then
			return
		end
		
		local spellName = "Ionic Blast"
		local charge = player.registry["ionic_charge"]
		if (charge < 0) then
			player:sendMinitext("There is not enough aether in the environment.")
			return
		end
		if (target.blType ~= BL_MOB) then
			player:sendMinitext("")
			return
		end
		local magicCost = player.maxMagic * 0.05 --base cost
		local damage = 0
		local tier = math.ceil(charge / 5)
		local aether = 0
		local costMultiplier = 1
		
		if (tier <= 0) then
			damage = 500 + (player.will - player.level) * 100 / 2 * (1 + player.mark)
			if damage < 1 then
				damage = 100
			end
			if math.random(100) < 30 then
				player:sendMinitext("Aether in the environment is scarce.")
			end
			aether = 1
			player.registry["ionic_charge"] = 0
		elseif (tier == 1) then
			damage = 500 + (player.will - player.level) * 100 / 1.4 * (1 + player.mark) + player.maxMagic * 0.02
			if damage < 1 then
				damage = 100
			end
			aether = 1
			player.registry["ionic_charge"] = charge - 1
		elseif (tier == 2) then
			damage = 500 + (player.will - player.level) * 100 * (1 + player.mark) + (player.maxMagic * 0.04) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 1
			player.registry["ionic_charge"] = charge - 1
			costMultiplier = tier
		elseif (tier == 3) then
			damage = 500 + (player.will - player.level) * 100 * (1 + player.mark) + (player.maxMagic * 0.12) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 1
			player.registry["ionic_charge"] = charge - 1
			costMultiplier = tier * 1.5
		elseif (tier == 4) then
			damage = 500 + (player.will - player.level) * 100 * (1 + player.mark) + (player.maxMagic * 0.22) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 2
			player.registry["ionic_charge"] = charge - (tier - 2)
			costMultiplier = tier * 1.5
		elseif (tier == 5) then
			damage = 500 + (player.will - player.level) * 100 * (1 + (player.mark * 2 )) + (player.maxMagic * 0.30) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 3
			player.registry["ionic_charge"] = charge - (tier - 1)
			costMultiplier = tier * 2
		elseif (tier == 6) then
			damage = (500 + (player.will - player.level) * 100 * (1 + player.mark * 2 ) + player.maxMagic * 0.60) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 4
			player.registry["ionic_charge"] = charge - (tier * 2)
			costMultiplier = tier * 3
		elseif (tier >= 7) then
			tier = 7
			damage = (500 + (player.will - player.level) * 100 * (1 + player.mark * 2.5) + player.maxMagic * 2.50) * tier
			if damage < 1 then
				damage = 100
			end
			aether = 5
			player.registry["ionic_charge"] = 0
			player:guitext("")
			magicCost = player.baseMagic - 500			
		end
		
		magicCost = magicCost * costMultiplier
		
		if player.magic < magicCost then
			player:sendMinitext("Your will is too weak.")
			return
		end
		
		local worked = global_zap.cast(player, target, damage, 0, -1000)
		local rand = math.random(10)
		if worked ~= 0 then
			player:sendMinitext("You cast " .. spellName .. ".")
			player:removeMagic(magicCost)
			if tier == 0 then
				target:sendAnimation(273)
			elseif tier == 1 then
				target:sendAnimationXY(290, target.x, target.y - 3)
				target:sendAnimationXY(273, target.x, target.y)
			elseif tier == 2 then
				target:sendAnimation(274)
				--target:sendAnimationXY(290, target.x, target.y - 4)
			elseif tier == 3 then
				target:sendAnimation(274)
				target:sendAnimationXY(290, target.x, target.y - 3)
			elseif tier == 4 then
				target:sendAnimation(275)
				if rand < 5 then
					player:sendMinitext("**you hear the air crackling**")
				elseif rand < 8 then
					player:sendMinitext("**you feel the ground howl**")
				else
					player:sendMinitext("**you hear thunder wildly crashing down**")
				end
			elseif tier == 5 then
				target:sendAnimationXY(290, target.x, target.y - 3)
				target:sendAnimation(275)
				if rand < 5 then
					broadcast(player.m, "**you hear the air crackling like it was on fire**")
				elseif rand < 10 then
					broadcast(player.m, "**you hear the dry air crackling**")
				else
					broadcast(player.m, "**you hear the air crackling wildly**")
				end
			elseif tier == 6 then
				target:sendAnimation(276)
				target:sendAnimationXY(290, target.x, target.y - 3)
				if rand < 5 then
					broadcast(player.m, "**you hear the air crackling and feel static**")
				elseif rand < 10 then
					broadcast(player.m, "**you hear thunder wildly crashing down**")
				else
					broadcast(player.m, "**you can feel the ions clashing together followed by a wild crash**")
				end
			elseif tier == 7 then
				target:sendAnimation(277)
				target:sendAnimationXY(290, target.x, target.y - 3)
				target:sendAnimationXY(290, target.x + 2, target.y - 3)
				target:sendAnimationXY(290, target.x - 2, target.y - 3)
				if rand < 4 then
					broadcast(player.m, "**you hear a loud and dry crack as if the earth split in two followed by an echoing roar**")
				elseif rand < 8 then
					broadcast(player.m, "**you can feel the ions clashing together followed by a wild thundering crash**")
				else
					broadcast(player.m, "**after the roaring thunder the sky clearing out and a fizzle in the air**")
				end
			end
			target:talk(0,"Tier: "..tier)
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
		if aether > 0 then
			player:setAether("ionic_blast", aether)
		end
	end,
	
	animation = function(target, charge)
	end,
	
	while_passive = function(player)
		local charge = player.registry["ionic_charge"]
		tier = math.floor(charge / 5)
		if tier > 0 then
			player:guitext("Ionic blast: "..tier)
		end
	end
}














--[[WHITE mage]]--
channeling_divinity = {
	cast = function(player, target)
		local spellName = "Channeling Divinity"
		if not player:canCast(1, 1, 0) then
			return
		end
		
		if player:carnageSpell() then
			return
		end
		
		local magicCost = 200
		local healAmount = 500


		if player.registry["wm_divinity_timer"] + 5 < os.time() then
			player.registry["wm_divinity_target"] = 0
			player.registry["wm_channeling_divinity"] = 0
		end
		
		healAmount = healAmount + target.maxHealth * (0.04 + (player.registry["wm_channeling_divinity"] / 100))
		if player.mark == 0  and healAmount > 32000 then
			healAmount = 32000	
		elseif player.mark == 1 and healAmount > 64000 then
			healAmount = 64000
		elseif player.mark == 2 and healAmount > 128000 then
			healAmount = 128000
		elseif player.mark == 3 and healAmount > 256000 then
			healAmount = 256000
		elseif player.mark >= 4 and healAmount > 512000 then
			healAmount = 512000
		end		
		magicCost = math.ceil(healAmount / 12.5)

		if player.registry["wm_divinity_target"] == target.ID then
			player.registry["wm_channeling_divinity"] = 0
			healAmount = healAmount + target.maxHealth * (0.04 + (player.registry["wm_channeling_divinity"] / 100))
		end
		
		local worked = global_heal.cast(player, target, healAmount, magicCost, 34)
		if worked ~= 0 then
			player.registry["wm_divinity_timer"] = os.time()
			if player.registry["wm_divinity_target"] == target.ID then
				if player.registry["wm_channeling_divinity"] < 6 then
					player.registry["wm_channeling_divinity"] = player.registry["wm_channeling_divinity"] + 1
				else
					player.registry["wm_channeling_divinity"] = 6
				end
			else	
				player.registry["wm_channeling_divinity"] = 0
			end
			player.registry["wm_divinity_target"] = target.ID		
			player:sendMinitext("You cast " .. spellName .. ".")
		end
		if worked == 2 then
			target:sendMinitext(player.name .. " cast " .. spellName .. " on you.")
		end
	end
}





AlcheonNpc = {

	buyItems = function(player, npc)
		local items = {"yellow_scroll"}
			player:buyExtend("I think I can accomodate some of the things you need. What would you like?",items)
			return
	end,

	sellItems = function(player, npc)
		local items = {"yellow_scroll"}
			player:sellExtend("What are you willing to sell today?",items)
		return
	end,

	weaponQuest = function(player, npc, t)

		items = {
			"honor_blade",
			"enchanted_honor_blade",
			"il_san_honor_blade",
			"ee_san_honor_blade",
			"sam_san_honor_blade",
			"sa_san_honor_blade"
		}


		if player.quest["knight_weapon"] == 0 then
			local weaponMenu = player:menuString("Would you like to forge your very own Honor Blade?",{"Yes", "No"})

			if (weaponMenu == "No") then
				player:dialogSeq({t,"That's a real shame. Come back when you are ready to represent our path."}, 0)
				return
			else
				if player.registry["flushed_kills"] == 0 then
					-- Sheep 1
					player:flushKills("sheep_veteran")
					player:flushKills("mythic_sheep")

					-- Sheep 2
					player:flushKills("divine_sheep")
					player:flushKills("sheep_shepherd")

					-- Sheep 3
					player:flushKills("sheep_avenger")
					player:flushKills("spirit_sheep")

					player.registry["flushed_kills"] = 1
				end

				if (player:killCount("sheep_veteran") >= 1 and player:killCount("mythic_sheep") >= 1) or (player:killCount("divine_sheep") >= 1 and player:killCount("sheep_shepherd") >= 1) or (player:killCount("sheep_avenger") >= 1 and player:killCount("spirit_sheep") >= 1) then
						
					player.registry["flushed_kills"] = 0
					player.quest["knight_weapon"] = 1

					player:dialogSeq({t,"Good work, Knight."}, 0)
					return
				end

				player:dialogSeq({t,"So you would like represent our Order of Knights and forge your very own Honor Blade?","I can help you achieve that task, but these blades are not for everyone. I'll need you to complete a couple of tasks first.","Your first trial will be a test of strength, you must enter the lair of the Mythic Sheep and slay one of each leader.","I await your return. Good luck, Knight."}, 0)
				return
			end
		end

		if player.quest["knight_weapon"] == 1 then

			player.quest["knight_weapon"] = 2
			player:dialogSeq({t,"Welcome back, Knight. That was a great show of strength, are you ready for the next step?","I'll require a few things in exchange for your honor blade.","First, you'll need a base for the weapon and some of your experience to fuse with the blade.","Bring me an appropriately leveled spike and 200,000,000 experience. (( for example, an Il San Spike if you're Il San. ))"}, 0)
			return
		end

		if player.quest["knight_weapon"] == 2 then

			local hasSpike = 0
		
			if (player.mark == 0 and (player.baseHealth >= 80000 or player.baseMagic >= 40000)) then
				if player:hasItem("enchanted_spike", 1) then
					removeSpike = "enchanted_spike"
					hasSpike = 1
				end
				item = items[2]
			elseif player.mark == 0 then
				if player:hasItem("spike", 1) then
					removeSpike = "spike"
					hasSpike = 1
				end
				item = items[1]
			elseif player.mark == 1 then
				if player:hasItem("il_san_spike", 1) then
					removeSpike = "il_san_spike"
					hasSpike = 1
				end
				item = items[3]
			elseif player.mark == 2 then
				if player:hasItem("ee_san_spike", 1) then
					removeSpike = "ee_san_spike"
					hasSpike = 1
				end
				item = items[4]
			elseif player.mark == 3 then
				if player:hasItem("sam_san_spike", 1) then
					removeSpike = "sam_san_spike"
					hasSpike = 1
				end
				item = items[5]
			elseif player.mark == 4 then
				if player:hasItem("sa_san_spike", 1) then
					removeSpike = "sa_san_spike"
					hasSpike = 1
				end
				item = items[6]
			end

			if (player.exp >= 200000000 and hasSpike == 1) then
				player:removeItem(removeSpike, 1)
				player.exp = player.exp - 200000000
				player:addItem(item, 1, 0, player.ID)
				player:sendStatus()
				player.quest["knight_weapon"] = 1
		
				player:dialogSeq({t,"Good work, Knight. Here is your very own Honor Blade.","If you require another blade in the future, you will not have to demonstrate your strength."}, 0)
				return
			else
				player:dialogSeq({t,"Come back after you've acquired an appropriately tiered Spike and 200,000,000 experience."}, 0)
				return
			end
		end
	end,

	shieldQuest = function(player,npc,t)
		
		items = {
			"mirror_aegis",
			"il_san_mirror_aegis",
			"ee_san_mirror_aegis",
			"sam_san_mirror_aegis",
			"sa_san_mirror_aegis"
		}

		if player.quest["knight_shield"] == 0 then
			local weaponMenu = player:menuString("Would you be interested in improving that shield of yours?",{"Yes", "No"})

			if (weaponMenu == "No") then
				player:dialogSeq({t,"That's okay, let me know when you're ready."}, 0)
				return
			else
				player.quest["knight_shield"] = 1
				player:dialogSeq({t,"So you're interested in improving your shield?","That's great, the Order of Knights has developed a way to improve your shield, but you will have to collect a few items.","The first item is straight forward. You'll need one of the Shields you get from the Nagnag Armory.","In order to give it the shine of a proper Knight's shield, I'll need five Silver Tree Branches.","Next, you'll have to get five pieces of a special armor plating.","You'll need to collect the best ingredients you can find to combine metal with powdered amber in order to give it a purplish hue.","You'll also need the assistance of an expert smelter in order to combine the items for you.","Once you have the shield, the metal armor plates, and the silver tree branches, come back to me and I'll help you enhance the shield."}, 0)
			end
		end

		if player.quest["knight_shield"] == 1 then

		local hasShield = 0

			if player.mark == 0 then
				if player:hasItem("stone_shield", 1) then
					removeShield = "stone_shield"
					hasShield = 1
				end
				item = items[1]
			elseif player.mark == 1 then
				if player:hasItem("hide_shield", 1) then
					removeShield = "hide_shield"
					hasShield = 1
				end
				item = items[2]
			elseif player.mark == 2 then
				if player:hasItem("brass_shield", 1) then
					removeShield = "brass_shield"
					hasShield = 1
				end
				item = items[3]
			elseif player.mark == 3 then
				if player:hasItem("titanium_shield", 1) then
					removeShield = "titanium_shield"
					hasShield = 1
				end
				item = items[4]
			elseif player.mark == 4 then
				if player:hasItem("noble_shield", 1) then
					removeShield = "noble_shield"
					hasShield = 1
				end
				item = items[5]
			end

			if (hasShield == 1 and player:hasItem("silver_tree_branch", 5) == true and player:hasItem("metal_armor_plate", 5) == true) then
				player:removeItem(removeShield, 1)
				player:removeItem("silver_tree_branch", 5)
				player:removeItem("metal_armor_plate", 5)
				player:addItem(item, 1, 0, player.ID)
				player:sendStatus()
				player.quest["knight_shield"] = 0

				player:dialogSeq({t,"These look alright to me, let me see what I can do...","*you watch as Alcheon focuses on forging the items together to create a new shield*","Here you go, Knight, wear it with pride."}, 0)
				return
			else
				player:dialogSeq({t,"Come back after you've acquired a shield from the Nagnag Armory, five Silver Tree Branches, and five Metal Armor Plates"}, 0)
				return
			end
		end
	end,

	leavePath = function(player,npc,t)
		local confirm = player:menuSeq("Do you wish to clear your mind, opening the possibility of one of the other subpaths? It will cost much karma to do so.",{"I wish to join another subpath.", "Nevermind."},{})

		if confirm == 1 then
			local knightSpells = {
				"second_wind",
				"shield_bash",
				"heroic_stance"
			}
			local aclassSpells = player:getAllClassSpells(player.class)
			local classSpells = {}

			for i = 1, #knightSpells do
				player:removeSpell(knightSpells[i])
			end

			player:removeLegendbyName("knighted")
			player:removeKarma(4.0)
			player:updatePath(player.baseClass, player.mark)

			player:dialogSeq({t, "It is done."}, 0)
		end
	end,

	learnSpells = function(player,npc,t)
		local spellOpts = {}
		if player:hasSpell("heroic_stance") == false then
			table.insert(spellOpts,"Heroic Stance")
		end
		if player:hasSpell("second_wind") == false then
			table.insert(spellOpts,"Second Wind")
		end
		if player:hasSpell("shield_bash") == false then
			table.insert(spellOpts,"Shield Bash")
		end
		local spellChoice = player:menuString("What abilities can I assist in teaching you?", spellOpts)

		if spellChoice == "Heroic Stance" then
			player:dialogSeq({t,"This ability is the very essence of a Knight. It enables you to bolster your defense and increase your damage.","The cost is high, though. It will require:","1 Ice sabre. 1 Flamefang. 1 Spike. 1 Frozen spear. 1 Dark dagger.","60 Yellow ambers. 100 Dark ambers.","Press next ONLY if you have all items necessary."},1)
			if(player:hasItem("ice_sabre",1) == true and player:hasItem("flamefang",1) == true and player:hasItem("spike",1) == true and player:hasItem("frozen_spear",1) == true and player:hasItem("dark_dagger",1) == true and player:hasItem("yellow_amber",60) == true and player:hasItem("dark_amber",100) == true) then
				player:removeItem("ice_sabre",1)
				player:removeItem("flamefang",1)
				player:removeItem("spike",1)
				player:removeItem("frozen_spear",1)
				player:removeItem("dark_dagger",1)
				player:removeItem("dark_amber",100)
				player:removeItem("yellow_amber",60)
				player:addSpell("heroic_stance")
				player:sendMinitext("Heroic Stance learned!")
			else
				player:dialogSeq({t,"Come back when you're ready to pay for your training."},0)
			end
		elseif spellChoice == "Second Wind" then
			player:dialogSeq({t,"This ability fully restore your vitality in order to continue fighting.","It will require:","2 red potion. 5 mountain ginseng, and 50,000 gold.","Press next ONLY if you have all items necessary."},1)
			if(player:hasItem("red_potion",2) == true and player:hasItem("mountain_ginseng",5) == true and player.money >= 50000) then
				player:removeItem("red_potion",2)
				player:removeItem("mountain_ginseng",5)
				player.money = player.money - 50000
				player:addSpell("second_wind")
				player:sendMinitext("Second Wind learned!")
			else
				player:dialogSeq({t,"Come back when you're ready to pay for your training."},0)
			end
		elseif spellChoice == "Shield Bash" then
			player:dialogSeq({t,"This ability bashes your opponent with a shield and temporarily prevents damage.","It will require:","2 dragons liver. 10 yellow amber, 2 electra, and 75,000 gold.","Press next ONLY if you have all items necessary."},1)
			if(player:hasItem("dragons_liver",2) == true and player:hasItem("yellow_amber",5) == true and player:hasItem("electra",2) == true and player.money >= 75000) then
				player:removeItem("dragons_liver",2)
				player:removeItem("yellow_amber",10)
				player:removeItem("electra",2)
				player.money = player.money - 75000
				player:addSpell("shield_bash")
				player:sendMinitext("Second Wind learned!")
			else
				player:dialogSeq({t,"Come back when you're ready to pay for your training."},0)
			end
		end
	end,

	click = async(function(player, npc)

		--[[ npc.gfxCrown = 305
		npc.gfxWeap = 403
		npc.gfxWeapC = 8
		npc.gfxHair = 118
		npc.gfxFace = 208
		npc.gfxFaceC = 0
		npc.gfxHairC = 21
		npc.gfxFaceA = -1
		npc.gfxFaceAT = -1
		npc.gfxMantle = -1
		npc.gfxNeck = -1
		npc.gfxHelm = 45
		npc.gfxHelmC = 28
		npc.gfxShield = -1
		npc.gfxSkin = 0
		npc.gfxArmor = 31
		npc.gfxArmorC = 0
		npc.gfxClone = 1
		npc.gfxTitleColor = 0
		npc:updateState() ]]
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
		if player.class == 29 then

			local options = {
				"Buy",
				"Sell",
				"Learn Secret",
				"Forget Secret",
				"Banking",
				"Fix Item",
				"Fix All Items",
				"Weapon Quest",
				"Shield Quest",
				"Leave Path"
			}

			local choice = player:menuString("Hello Knight! How can I help you today?",options)

			if choice == "Buy" then
				AlcheonNpc.buyItems(player, npc)
			elseif choice == "Sell" then
				AlcheonNpc.sellItems(player, npc)
			elseif choice == "Banking" then
				bank.show_main_menu(player, npc)
			elseif choice == "Learn Secret" then
				AlcheonNpc.learnSpells(player, npc, t)
			elseif choice == "Forget Secret" then
				player:forgetSpell(npc)
			elseif choice == "Fix Item" then
				player:repairExtend()
			elseif choice == "Fix All Items" then
				player:repairAll(npc)
			elseif choice == "Weapon Quest" then
				AlcheonNpc.weaponQuest(player, npc, t)
			elseif choice == "Shield Quest" then
				AlcheonNpc.shieldQuest(player, npc, t)
			elseif choice == "Leave Path" then
				AlcheonNpc.leavePath(player, npc, t)
			end
		end

		if player.class == 6 or player.class == 31 or player.class == 30 then
			player:dialogSeq({t,"Greetings warrior, I cannot teach one who follows another path. Come back to me when you are ready to learn."}, 0)
			return
		end

		if player.class > 1 and player.class ~= 29 then
			player:dialogSeq({t,"Greetings adventurer, how fares your travels?"}, 0)
			return
		end

		if player.level < 91 then
			player:dialogSeq({t,"Greetings warrior, you still have more training ahead of you if you wish to learn my secrets. Come back when you're stronger."}, 0)
			return
		end

		if player.class == 1 and player.quest["knightq"] == 0 then
			player:dialogSeq({t,"*you see a gnarled, old fighter polishing his helm while basking in the sun*","*he looks you up and down as you approach and nods to himself*","You look like a formidable warrior. Have you ever thought of training to become a Knight?","A Knight is a warrior dedicated and loyal to the crown, their family, and friends.","They have a code of conduct and their honor is held in the highest regard throughout the lands."}, 1)

			local menu = player:menuString("Are you sure you would like to dedicate yourself to becoming a Knight?",{"Yes", "No"})

			if (menu == "No") then
				player:dialogSeq({t,"That's a real shame, good luck in your adventures and come find me if you change your mind."}, 0)
				return
			end

			player.quest["knightq"] = 1
			
			player:dialogSeq({t,"Hrm, well, just so happens I was looking for a new squire and it may be that I can teach you a thing or two.","It won't be easy and it won't always be fun, but if you stick to my training you'll find yourself knighted in a decade or two.","First, I have a few errands I need you to run. My weapon has rusted in it's age and I'm looking to replace it. I was thinking of trying out a few different weapons and I'd like you to go and gather them for me.","The first weapon is an axe that is said to be made from the mandibles of a spider that lunges at you from the ceiling.","The second weapon is a sword, one rumored to be electrified.","The third weapon is a club filled with spikey ends.","Bring me these weapons and we'll test them out together in the training yard."}, 0)
			return
		elseif player.quest["knightq"] == 1 then

			local knight1Items = 0

			if player:hasItem("hunangs_axe", 1) == true then
				knight1Items = knight1Items + 1
			end
			if player:hasItem("electra", 1) == true then
				knight1Items = knight1Items + 1
			end
			if player:hasItem("spike", 1) == true then
				knight1Items = knight1Items + 1
			end

			if knight1Items ~= 3 then
				player:dialogSeq({t,"Did you forget the errand I sent you on?","The first weapon is an axe that is said to be made from the mandibles of a spider that lunges at you from the ceiling.","The second weapon is a sword, one rumored to be electrified.","The third weapon is a club filled with spikey ends.","Bring me these weapons, and we'll test them out together in the training yard."}, 0)
				return
			end

			player:removeItem("hunangs_axe", 1)
			player:removeItem("electra", 1)
			player:removeItem("spike", 1)
			player.quest["knightq"] = 2

			player:dialogSeq({t,"Great, those look mighty fierce. Each of those weapons look like they have their place on the battlefield if one knows how to wield them. Come back to me later for your next lesson."}, 0)
			return
		elseif player.quest["knightq"] == 2 then

			player.quest["knightq"] = 3

			player:dialogSeq({t,"Welcome back Squire, ready for a new lesson?","There is a banquet tonight in King Frank's honor and the larder is looking a little light.","I'd like for you to get some various meats in order for the cook's to prepare a feast.","Accomplish this and I'll let you accompany me to the banquet; you might even get a chance to see our liege tonight!","The cooks gave me a list of what they wanted to cook tonight... Lemme see if I can find it.","*the old knight rummages in his pocket for a crumbled up piece of paper and pulls it out*","Ah, yes. First, please work on getting ten chunks of tiger meat.","Second, thirty of the leanest steaks.","Finally, twenty five slabs of wolf meat for the stew.","I'll work on acquiring the drinks for tonight. Come find me when you have everything."}, 0)
			return
		elseif player.quest["knightq"] == 3 then

			local knight2Items = 0

			if player:hasItem("tiger_meat", 10) == true then
				knight2Items = knight2Items + 1
			end
			if player:hasItem("lean_beef", 30) == true then
				knight2Items = knight2Items + 1
			end
			if player:hasItem("wolf_meat", 25) == true then
				knight2Items = knight2Items + 1
			end

			if knight2Items ~= 3 then
				player:dialogSeq({t,"Were you able to get all that meat?","first, please work on getting ten chunks of tiger meat.","Second, thirty of the leanest steaks.","Finally, twenty five slabs of wolf meat for the stew.","Come find me when you have everything."}, 0)
				return
			end

			player:removeItem("tiger_meat", 10)
			player:removeItem("lean_beef", 30)
			player:removeItem("wolf_meat", 25)
			player.quest["knightq"] = 4

			player:dialogSeq({t,"Wonderful! Looks like everything is in order. I'll bring these down to the kitchens. Come back to me when you're ready for the banquet."}, 0)
			return
		elseif player.quest["knightq"] == 4 then
			player:dialogSeq({t,"Welcome back Squire. You've been doing a lot of work lately and it's time to see the fruition of your efforts. Let's head to the feast.","We have the great honor of escorting His Royal Highness, King Frank, to the banquet. He will be along momentarily. Keep your eyes down and your wits about you.","Ready your weapon as well. There is no telling what might befall us on the road.","((Press \"Next\" ONLY if you are ready to start an instance. Otherwise, Press \"Close\".))"}, 1)
			player.quest["knightq"] = 5
			InstanceTestNpc.createInstance(player,npc,"knight_quest_blank","Escort Trial",1)
			return
		elseif player.quest["knightq"] == 5 then
			if player.registry["knight_instance"] < 5 then
				player:dialogSeq({t,"Did you lose your way to the feast? Be sure to stick close to me this time!","((Press \"Next\" ONLY if you are ready to start an instance. Otherwise, Press \"Quit\".))"}, 1)
				
				player.registry["knight_instance"] = 0
				InstanceTestNpc.createInstance(player,npc,"knight_quest_blank","Escort Trial",1)
				return
			else
				player.quest["knightq"] = 6
				player.registry["knight_quest_time"] = 0
				player.registry["knight_instance"] = 0
				player:dialogSeq({t,"The king is safe! An ambush by the Ogres of Hamgyong Nam-Do was most unprecedented. I'd bet I know who was behind this ambush. Come back to me when you're ready to make our plans."}, 0)
				return
			end
		elseif player.quest["knightq"] == 6 then
			player.quest["knightq"] = 7

			if player.registry["flushed_kills"] == 0 then
				player:flushKills("zinte_ogre")
				player:flushKills("zangze_ogre")
				player.registry["flushed_kills"] = 1
			end

			player:dialogSeq({t,"*as you approach the Knight, you see him hunched over and looking at a map.*","Squire, is that you? Good, we have some planning to do. I believe that the fearsome ogre brothers, Zangze and Zin-te were behind this attack on our royal highness.","Needless to say, the King has asked us to quest into their lands and put a stop to any further attacks.","I'll check the area and provide support. You gather a party to aide you while you traverse the treacherous deeps of their homes.","We will meet back here after the task is done, I am sure the king will be eternally grateful."}, 0)
			return
		elseif player.quest["knightq"] == 7 then
			if player:killCount("zinte_ogre") >= 1 and player:killCount("zangze_ogre") >= 1 then
				player.registry["flushed_kills"] = 0
				player.quest["knightq"] = 8

				player:dialogSeq({t,"Wonderful! That should slow down the ogre aggressors for a while until they reestablish themselves. Good work, Squire.",
						"Let's go report our success to the king! You can find him in the palace. Come back to me later as I'm sure we'll have more to discuss."
					}, 0)
				return
			else
				player:dialogSeq({t,"What are you waiting for, this must be dealt with before they have a chance to attack again!","Go slay the ogre brothers, Zin-Te and Zangze."}, 0)
				return
			end
		elseif player.quest["knightq"] == 8 then
			player:dialogSeq({t,"Don't keep the king waiting, Squire. You can find him above us in the palace.",}, 0)
			return
		end
	end)
}
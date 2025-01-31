temptation = {
	click = async(function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
        local opts = {}
		if player.class == 28 and not player:hasSpell("vampiric_plague") then
			table.insert(opts, "Learn Vampiric Plague")
		end
		if player.class == 28 and not player:hasSpell("red_curse") then
			table.insert(opts, "Learn Red Curse")
		end
		if player.class == 3 and (player.quest["subpath_trials"] == 0 or player.quest["subpath_trials"] == 28) then
			table.insert(opts, "Join the Bloodmages")
		end

		if player.quest["subpath_trials"] == 28 then
			table.insert(opts, "Abandon Trials")
		end
		if player.level >= 99 and player.class == 28 then
			table.insert(opts, "Eunjangdo")
		end
		if (player.maxHealth >= 80000 or player.maxMagic >= 40000) and player.class == 28 then
			table.insert(opts, "Enchanted Eunjangdo")
		end
		if player.mark >= 1 and player.class == 28 then
			table.insert(opts, "Il-san Eunjangdo")
		end
		if player.mark >= 2 and player.class == 28 then
			table.insert(opts, "Ee-san Eunjangdo")
		end
		if player.class == 28 then
			table.insert(opts, "Leave subpath")
		end




		local menu = player:menuString("....Hm, what is it you want, Mage? I seek desire within you...ambition.", opts)
	--[[local buyitems = temptation.buyItems()
		local sellitems = temptation.sellItems()


		if menu == "Buy" then
			player:buyExtend(
				"I think I can accommodate some of the things you need. What would you like?",
				buyitems
			)
		elseif menu == "Sell" then
			player:sellExtend("What are you willing to sell today?", sellitems)
		elseif menu == "Ghengis Khan's Welcome" then
			player:dialogSeq({t, "Hello and welcome to the Barbarian Cave."}, 0)
			return--]]
		if menu == "Il-san Eunjangdo" then
			local buy = player:menuString(
				"The Il-san Eunjangdo is the sacred Bloodmage weapon, weld by only the elite. Do you want to buy one? (75000 coins)",
				{"...Yes", "No, I don't think so."}
			)
			if buy == ("...Yes") then
				if player.money >= 75000 then
					player:removeGold(75000)
					player:addItem("il_san_staff_of_agui",1,0,player.ID)
					player:sendAnimation(5,0)
				else
					player:dialogSeq({t,"You don't have enough!"},0)
					return
				end
			end
		end

		if menu == "Ee-san Eunjangdo" then
			local buy = player:menuString(
				"The Ee-san Eunjangdo is the sacred Bloodmage weapon, weld by only the elite. Do you want to buy one? (100000 coins)",
				{"...Yes", "No, I don't think so."}
			)
			if buy == ("...Yes") then
				if player.money >= 100000 then
					player:removeGold(100000)
					player:addItem("ee_san_staff_of_agui",1,0,player.ID)
					player:sendAnimation(5,0)
				else
					player:dialogSeq({t,"You don't have enough!"},0)
					return
				end
			end
		end

		if menu == "Leave subpath" then
			local confirm1 = player:menuString("Your spirit will take a hit. Are you SURE you want to abandon subapth?",{"Yes","No"})
			if confirm1 == "Yes" then
				local bmSpells = {"vampiric_plague","red_curse"}
				for i = 1, #bmSpells do
					player:removeSpell(bmSpells[i])
				end
				player:removeLegendbyName("blackmage_joined_mark")
				player:removeKarma(4.0)
				player:updatePath(player.baseClass, player.mark)
				player:dialogSeq({t,"It is done."},0)
			end
		end

		if menu == "Enchanted Eunjangdo" then
			local buy = player:menuString(
				"The Enchanted Eunjangdo is the sacred Bloodmage weapon, weld by only the elite. Do you want to buy one? (50000 coins)",
				{"...Yes", "No, I don't think so."}
			)
			if buy == ("...Yes") then
				if player.money >= 50000 then
					player:removeGold(50000)
					player:addItem("enchanted_staff_of_agui",1,0,player.ID)
					player:sendAnimation(5,0)
				else
					player:dialogSeq({t,"You don't have enough!"},0)
					return
				end
			end
		end


		if menu == "Eunjangdo" then
			local buy = player:menuString(
				"The Eunjangdo is the sacred Bloodmage weapon, weld by only the elite. Do you want to buy one? (50000 coins)",
				{"...Yes", "No, I don't think so."}
			)
			if buy == ("...Yes") then
				if player.money >= 25000 then
					player:removeGold(25000)
					player:addItem("staff_of_agui",1,0,player.ID)
					player:sendAnimation(5,0)
				else
					player:dialogSeq({t,"You don't have enough!"},0)
					return
				end
			end
		end

		
		if menu == "Learn Vampiric Plague" then
			if (player:hasItem("surge", 1) == true and player.money >= 50000) then
				player:removeItem("surge", 1)
				player:removeGold(50000)
				player:addSpell("vampiric_plague")
				player:sendMinitext("You have learned Vampiric Plague!")
				player:sendAnimation(2,0)
			else
				player:dialogSeq({t,"This ability will harness the blood of your enemies.. It requires a Surge and 50,000 gold."},0)
			end
		end
		if menu == "Learn Red Curse" then
			if ((player:hasItem("tao_stone", 1) == true) and (player:hasItem("dragons_liver", 1) == true) and (player.money >= 25000)) then
				player:removeItem("tao_stone", 1)
				player:removeItem("dragons_liver", 1)
				player:removeGold(25000)
				player:addSpell("red_curse")
				player:sendMinitext("You have learned Red Curse!")
				player:sendAnimation(2,0)
			else
				player:dialogSeq({t,"This curse allows you to manipulate creatures' blood. It costs a tao stone, dragon's liver, and 25,000 gold."},0)
			end
		end
		if menu == "Join the Bloodmages" then
			temptation.joinTheBloodmages(player, npc)
		elseif menu == "Abandon Trials" then
			local abandon = player:menuString("Are you sure you want to abandon your trials?",{"Yes", "No"})
			if abandon == "Yes" then
				temptation.clearQuestLegends(player)
				player:dialogSeq({t,"You are not strong enough to master the dark arts."},0)
			else
				return
			end
		end
	end),

	clearQuestLegends = function(player)
		player.quest["subpath_trials"] = 0
		player.quest["blackmage_trial"] = 0
		player.quest["blackmage_trial_of_willingness"] = 0
--		player.quest["blackmage_trial_of_survival"] = 0
		player.quest["blackmage_trial_of_atonement"] = 0
		player.quest["blackmage_trial_of_atonement_meat_collected"] = 0
		player.quest["blackmage_trial_of_repudiation"] = 0
		player.quest["blackmage_trial_of_competency"] = 0
		player.quest["blackmage_trial_of_competency_prior_wins"] = 0
		player.quest["blackmage_trial_ads"] = 0
--[[
		player:removeLegendbyName("blackmage_trial_of_willingness")
		player:removeLegendbyName("blackmage_trial_of_survival")
		player:removeLegendbyName("blackmage_trial_of_atonement")
		player:removeLegendbyName("blackmage_trial_of_repudiation")
        player:removeLegendbyName("blackmage_trial_of_competency")
]]
	end,

	action = function(npc)
		local random = math.random(1, 15)
		if random == 1 then
			npc:talk(0, npc.name .. ": Welcome to the Crypt of the Bloodmages")
		end
	end,
--[[
	move = function(npc)
		npc.side = math.random(0, 3)
		npc:sendSide()
	end,

	buyItems = function()
		local buyItems = {
			"rabbit_meat",
			"meat_scrap",
			"horse_meat",
			"antler",
			"bears_liver",
			"tigers_heart"
		}
		return buyItems
	end,

	sellItems = function()
		return temptation.buyItems()
	end,
]]
	joinTheBloodmages = function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		--[[1. Willingness
	2. Survival
	3. Atonement
	4. Repudiation
	5. Competency]]
		--

		if player.level < 70 then
			player:dialogSeq({t, "You are too young to join at this time."}, 0)
			return
		end

		if not player:karmaCheck("ox") then
			player:dialogSeq(
				{t, "Your soul is too impure. Improve your karma and return."},
				0
			)
			return
		end

		if player.quest["subpath_trials"] == 0 then
			player:dialogSeq(
				{
					t,
					"Do you seek to harness the power of the darkness?"
									},
				1
			)

			local join = player:menuString(
				"Are you sure you want to begin the process?",
				{"...Yes", "No, I don't think so."}
			)

			if join == "...Yes" then
				player.quest["subpath_trials"] = 28
--				player.quest["blackmage_trial_ads"] = 0
			else
				player:dialogSeq(
					{t, "Very well, begone!"},
					0
				)
			end
		end

		if player.quest["subpath_trials"] == 28 then
			-- barb

			if player.quest["blackmage_trial"] == 0 and player.quest["blackmage_trial_ads"] <= 1 then
				-- trial of willingness

				player:dialogSeq(
					{
						t,
						"What would you do to possess the power which you seek? Would you sacrifice everything... even yourself? ",
						"Many have come before you, and many have failed.",
						"Behold the flesh of those who sought to dwell within the shadows, but couldn't."
					},
					1
				)
				if player.quest["blackmage_trial_ads"] == 0 then
					player.quest["blackmage_trial_ads"] = 1
					local x = {19, 20, 21, 12, 11, 10}
					local y = {7, 7, 7, 7, 7, 7}
					local boss = player:getObjectsInMap(2205,BL_MOB)
					player.registry["onbmquest"] = 1
					for i=1, #boss do
						boss[i]:delete()
					end
					for i=1, #x do
						npc:spawn(807, x[i], y[i], 1, 2205)
					end
					local boss2 = player:getObjectsInMap(2205,BL_MOB)
					player:addThreatGeneral(100)
				else
					if player.registry["bmquestkillcount"] <= 5 then
						player:dialogSeq({t,"You must finish the trial!"},0)
						return
					else
						player.quest["blackmage_trial"] = 1
						player.registry["bmquestkillcount"] = 0
						player.registry["onbmquest"] = 0
						player:dialogSeq(
							{
								t,
								"I see that your aspirations run deep. Very well then."
							},
							1)
					end
				end
			end


			if player.quest["blackmage_trial"] == 1 then
				-- trial of atonement

				if player.quest["blackmage_trial_of_atonement"] == 0 then
					-- not started quest
					player:dialogSeq(
						{
							t,
							"The darkness requests proof of your willingness to sacrifice all else. Bring me a representation of all of the great totem animals.",
							"We will introduce them to the shadows."
						},
						1
					)
					player.quest["blackmage_trial_of_atonement"] = 1
				elseif player.quest["blackmage_trial_of_atonement"] == 1 then
					-- started quest

					if player.quest["blackmage_trial_of_atonement_meat_collected"] <= 0 then
						if player:hasItem("chung_ryong_key", 1) ~= true or player:hasItem("baekho_key", 1) ~= true or player:hasItem("ju_jak_key", 1) ~= true or player:hasItem("hyun_moo_key", 1) ~= true then
							player:dialogSeq(
								{
									t,
									"Bring me a representation of all of the great totem animals."
								},
								1
							)
							return
						else
							player:removeItem("chung_ryong_key", 1)
							player:removeItem("baekho_key", 1)
							player:removeItem("ju_jak_key", 1)
							player:removeItem("hyun_moo_key", 1)
							player.quest["blackmage_trial_of_atonement_meat_collected"] = player.quest["blackmage_trial_of_atonement_meat_collected"] + 1

							player:dialogSeq(
								{
									t,
									"Your tribute has been noted, Mage."
								},
								1
							)
						end
					end

					if player.quest["blackmage_trial_of_atonement_meat_collected"] >= 1 then
						player.quest[
							"blackmage_trial_of_atonement_meat_collected"
						] = 0
						player.quest["blackmage_trial_of_atonement"] = 0
						player.quest["blackmage_trial"] = 2
						player:dialogSeq(
							{
								t,
								"Your tribute has been noted, Mage."
							},
							1
						)
					end
				end
			end

			if player.quest["blackmage_trial"] == 2 then
				-- trial of repudiation


				if player.quest["blackmage_trial_of_repudiation"] == 0 then
					player:dialogSeq(
						{
							t,
							"Your dedication and willinginess to accept the darkness have been noted",
							"As a practioner of dark magic, it will be your blessing to spread the shadow among the lands.",
							"Take this - (Temptation hands you a small, rotted acorn)",
							"Plant this seed at the center of life so it may spread its influence. After you have completed this, we will consider you one of ours."
						},
						1
					)

					player.quest["blackmage_trial_of_repudiation"] = 1
					player.registry["seedplanted"] = 0
					player:addItem("corrupted_seed", 1)
				end

					
				if player.quest["blackmage_trial_of_repudiation"] == 1 then
					if player.registry["seedplanted"] == 0 then
						player:dialogSeq({t,"You have not yet planted the seed of corruption..."},0)
						return
					else
						player:dialogSeq({t,"Complete!"},1)
						player.quest["blackmage_trial_of_repudiation"] = 0
						player.quest["blackmage_trial_complete"] = 1
						player.registry["seedplanted"] = 0
					end
				end
			end

			if player.quest["blackmage_trial_complete"] == 1 then -- trial of competency
				player:dialogSeq({t,"You have done well. The seed will take root, and with it our influence will spread throughout the land. ",
						"Beneath these crypts you will find the reliquary. The convert of bloodmages feel it is an excellent site for convergence or the occasional sacrificial rites..",},1)	
				player.quest["blackmage_trial_complete"] = 0
				temptation.clearQuestLegends(player)
				player:addLegend("Sacrificed to become a Bloodmage (" .. curT() .. ")","blackmage_joined_mark",26,15)
				player:updatePath(28, player.mark)
				broadcast(-1,"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!")
				player.registry["seedplanted"] = 0
				player.quest["blackmage_trial"] = 0

				player:sendAnimation(628,5)
			end
		end
	end
}

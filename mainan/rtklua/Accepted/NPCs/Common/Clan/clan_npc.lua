ClanNpc = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts = {
			"Buy",
			"Sell",
			"Banking",
			"Transport",
			"Date & Time"
		}

		if os.time() >= player.registry["gave_fragile_orb_of_world_shout_time"] then
			table.insert(opts, "Free World Shout")
		end

		if player.clanName == npc.clanName then
			table.insert(opts, "Deposit clan item")
			table.insert(opts, "Withdraw clan item")
			table.insert(opts, "Live here")
		end

		local choice = player:menuString("Hello! How can I help you today?", opts)

		if choice == "Buy" then
			player:buyExtend(
				"I think I can accomodate some of the things you need. What would you like?",
				ClanNpc.buyItems()
			)
		elseif choice == "Sell" then
			player:sellExtend(
				"What are you willing to sell today?",
				InnNpc.sellItems()
			)
		elseif choice == "Deposit clan item" then
			if player.clan ~= 0 then
					player:showClanBankDeposit(npc)
			end
		elseif choice == "Withdraw clan item" then
			if (player.clan ~= 0 and player.clanRank >= 4) then
				player:showClanBankWithdraw(npc)
			else
				player:dialogSeq({"You do not have sufficient rank for that."}, 0)
			end
		elseif choice == "Banking" then
			bank.show_main_menu(player, npc)
		elseif choice == "Transport" then
			Waypoint.click(player, npc)
		elseif choice == "Date & Time" then
			general_npc_funcs.time(player)
		elseif choice == "Live here" then
			ClanNpc.LiveHere(player, npc)
		elseif choice == "Free World Shout" then
			general_npc_funcs.freeWorldShout(player, npc)
		end
	end),

	buyItems = function()
		local buyItems = {
			"apple",
			"wine",
			"thick_wine",
			"yellow_scroll",
			"kindred_talisman",
			"soup_bowl",
			"comb",
			"rice_wine",
			"root_liquor"
		}

		return buyItems
	end,








	LiveHere = function(player, npc)
		if player.registry["home"] == 1 then
			local confirm = player:menuSeq(
				"You already live here... Do you wish to move back to the kingdom?",
				{"Yes, I do.", "No, I wish to stay."},
				{}
			)

			if confirm == 1 then
				-- leave
				player.registry["home"] = 0
				player:dialogSeq({"Well, nothing lasts forever. Good luck in the future."}, 0)

				return
			elseif confirm == 2 then
				player:dialogSeq({"Ah, that is good to hear. I hope you like my service here."}, 0)
				return
			end
		else
			player:dialogSeq({"Ah, great! You're ready to live with us in our home?"}, 1)

			local confirm = player:menuSeq(
				"Are you sure you want to do this?",
				{"Yes, I wish to.", "No, I do not."},
				{}
			)

			if confirm == 1 then
				player.registry["home"] = 1
				player:dialogSeq({"Welcome to our home, I hope you enjoy your time here."}, 0)
				return
			elseif confirm == 2 then
				player:dialogSeq({"That is your choice, plenty of room if you wish to come back later."}, 0)
				return
			end
		end
	end,

	sellItems = function()
		local sellItems = InnNpc.buyItems()

		return sellItems
	end,

	onSayClick = async(function(player, npc)
		Waypoint.onSayClick(player, npc)
	end)

}

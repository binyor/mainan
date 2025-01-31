MontyPvpPrizesNpc = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}

		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		if (player.registry["carnagePrizeTime"] ~= 0 and os.time() < player.registry["carnagePrizeTime"] + 21600) then
			player.gfxDye = 0
			player.gfxDye = 0
			clone.wipe(player)
			player:updateState()
			player:calcStat()
			player:returnToInn()
			player:addItem("event_token",3)

			minigames.giveMinigameExp(player, 1)
			player.registry["carnageWin"] = player.registry["carnageWin"] + 1
			player:removeLegendbyName("carnageWin")
			player:addLegend(
				player.registry["carnageWin"] .. " Carnage victories",
				"carnageWin",
				1,
				128
			)
			player:dialogSeq({t, "You may only receive one prize a day."}, 1)
			return
		end

		local mats = 20
		local ore = "poor"
		local fine = ""
		local fineIdentifier = ""
		local frags = 0
		local karma = 0.1
		local ilweaps = 0
		local weap95 = 0
		local weap75 = 0

		if (player.baseHealth >= 160000 or player.baseMagic >= 80000) then
			mats = 100
			ore = "high"
			fine = " Fine"
			fineIdentifier = "fine_"
			frags = 10
			karma = 1.0
			ilweaps = 1
			weap95 = 1
			weap75 = 1
		elseif (player.level == 99) then
			mats = 100
			ore = "high"
			frags = 5
			karma = 0.8
			weap95 = 1
			weap75 = 1
		elseif (player.level > 85) then
			mats = 75
			ore = "med"
			karma = 0.6
			weap75 = 1
		elseif (player.level > 65) then
			mats = 50
			ore = "med"
			karma = 0.4
			weap75 = 1
		elseif (player.level > 35) then
			mats = 35
			karma = 0.2
		end

		local prizes = {
			["5 Gold acorns"] = {item = "gold_acorn", amount = 5},
			["20 Light fox fur"] = {item = "light_fox_fur", amount = 20},
			[mats .. " Amber"] = {item = "amber", amount = mats},
			[mats .. " Ginko wood"] = {item = "ginko_wood", amount = mats},
			[mats .. " Ore [" .. ore .. "]"] = {item = "ore_" .. ore, amount = mats},
			[mats .. fine .. " Metal"] = {item = fineIdentifier .. "metal", amount = mats},
			[mats .. " Wool"] = {item = "wool", amount = mats},
			[mats .. fine .. " Cloth"] = {item = fineIdentifier .. "cloth", amount = mats},
			[frags .. " Map fragments"] = {item = "map_fragment", amount = frags},
			["Karma bonus"] = {item = "karma", amount = karma},
			["Dark scimitar"] = {item = "dark_scimitar", amount = 1},
			["Light broadsword"] = {item = "light_broadsword", amount = 1},
			["Wand of Fire"] = {item = "wand_of_fire", amount = 1},
			["Winter scepter"] = {item = "winter_scepter", amount = 1},
			["Blood"] = {item = "blood", amount = 1},
			["Spike"] = {item = "spike", amount = 1},
			["Surge"] = {item = "surge", amount = 1},
			["Charm"] = {item = "charm", amount = 1},
			["Electra"] = {item = "electra", amount = 1},
			["Star-staff"] = {item = "star_staff", amount = 1},
			["Steelthorn"] = {item = "steelthorn", amount = 1}
		}

		local opts = {
			"5 Gold acorns",
			"20 Light fox fur",
			mats .. " Amber",
			mats .. " Ginko wood",
			mats .. " Ore [" .. ore .. "]",
			mats .. fine .. " Metal",
			mats .. " Wool",
			mats .. fine .. " Cloth"
		}

		if (frags > 0) then
			table.insert(opts, frags .. " Map fragments")
		end
		if (ilweaps > 0) then
			table.insert(opts, "Dark simitar")
			table.insert(opts, "Light broadsword")
			table.insert(opts, "Wand of fire")
			table.insert(opts, "Winter scepter")
		end

		if (weap95 > 0) then
			table.insert(opts, "Spike")
			table.insert(opts, "Blood")
			table.insert(opts, "Surge")
			table.insert(opts, "Charm")
		end
		if (weap75 > 0) then
			table.insert(opts, "Electra")
			table.insert(opts, "Star-staff")
			table.insert(opts, "Steelthorn")
		end



		table.insert(opts, "Karma bonus")

		local dialog = "See you next time."

		local menu = player:menuString(
			"You are victorious, choose your spoils.",
			opts
		)

		if (menu == nil) then
			return
		end

		if (menu == "Karma bonus") then
			t.graphic = convertGraphic(49, "monster")
			t.color = 5
			player:addKarma(karma)
			player:removeItem("carnage_token", 1)
			player:addItem("event_token",3)

			local slightly = ""

			if (karma < 1) then
				slightly = " slightly"
			end

			dialog = "Your karma has risen" .. slightly .. "."
		else
			local itemIdentifier = prizes[menu].item
			local item = Item(itemIdentifier)
			local amount = prizes[menu].amount
			t.graphic = item.icon
			t.color = item.iconC

			if (not player:hasSpace(itemIdentifier, amount)) then
				player:dialogSeq(
					{
						t,
						"You cannot claim a prize until you have room in your inventory."
					},
					0
				)
				return
			end

			if (not player:hasSpace(itemIdentifier, amount)) then
				player:dialogSeq({t,"You cannot claim a prize until you have room in your inventory."},0) return
			end
			player:addItem(itemIdentifier, amount)
			player:addItem("event_token",3)
			player:removeItem("carnage_token", 1)

			local itemName = item.name
			
			if (itemName == "Gold acorn" or itemName == "Map fragment") then
				itemName = itemName .. "s"
			end

			dialog = "Enjoy your " .. itemName .. ". See you next time."
		end

		player.registry["carnagePrizeTime"] = os.time()
		minigames.giveMinigameExp(player, 1)

		player.registry["carnageWin"] = player.registry["carnageWin"] + 1
		player:removeLegendbyName("carnageWin")
		player:addLegend(
			player.registry["carnageWin"] .. " Carnage victories",
			"carnageWin",
			1,
			128
		)

		player.gfxDye = 0
		clone.wipe(player)
		player:updateState()
		player:calcStat()
		player:returnToInn()

		player:dialogSeq({t, dialog}, 1)
	end)
}

tailoring = {
	craft = function(player, npc, speech)
		if speech ~= "tailor" then return end

		local tcloth = {
			graphic = convertGraphic(1632, "item"),
			color = 0
		}

		player.npcGraphic = tcloth.graphic
		player.npcColor = tcloth.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local craftBandanna = {   0,    0,    0,    0,    0,    0,    0,    1,    1,    1,    1} -- can craft bandanna
		local qualityMin =    {   1,    1,    2,    2,    3,    3,    3,    4,    4,    5,    5} -- minimum quality
		local qualityMax =    {   2,    3,    4,    5,    5,    7,    7,    7,    7,    7,    7} -- maximum quality
		local regChance =     {  35, 37.5,   40, 42.5,   45,   50,   60,   65,   68,   71,   75} -- regular chance to craft

		local starChance    = {   0,    0,    0,    0,    0,    0,    0,   30,   30,   40,   50} -- % chance to attempt to craft star
		local starMaxRandom = {   0,    0,    0,    0,    0,    0,    0,  100,   80,   70,   50} -- 1 in # chance of success

		local skillLevelID = crafting.getSkillLevelID(player, "tailoring")

		local opts = {"Waistcoat", "Blouse", "Garb", "Clothes", "Dress", "Skirt", "Robes", "Mantle", "Gown", "Drapery"}
		if craftBandanna[skillLevelID] == 1 then table.insert(opts, "Bandanna") end

		local choice = player:menuSeq("What type of clothing are you trying to tailor?", opts, {})
		local chosenItem = string.lower(opts[choice])

		local matsAmts = {2, 2, 3, 3, 2, 3, 2, 3, 2, 3, 3}
		local quality = {}
		if choice == 1 then -- Waistcoat
			quality = {"novice","farmer","royal","sky","ancient","blood","earth"}
		elseif choice == 2 then -- Blouse
			quality = {"spring","summer","autumn","winter","leather","ancient","earth"}
		elseif choice == 3 then -- Garb
			quality = {"spring","summer","royal","sky","leather","blood","earth"}
		elseif choice == 4 then -- Clothes
			quality = {"peasant","farmer","royal","sky","ancient","family","earth"}
		elseif choice == 5 then -- Dress
			quality = {"spring","summer","autumn","winter","ancient","leather","earth"}
		elseif choice == 6 then -- Skirt
			quality = {"spring","summer","autumn","winter","leather","heart","earth"}
		elseif choice == 7 then -- Robes
			quality = {"spring","summer","autumn","winter","ancient","blood","earth"}
		elseif choice == 8 then -- Mantle
			quality = {"spring","summer","autumn","winter","ancient","blood","earth"}
		elseif choice == 9 then -- Gown
			quality = {"spring","summer","autumn","winter","leather","ancient","earth"}
		elseif choice == 10 then -- Drapery
			quality = {"spring","summer","autumn","winter","leather","ancient","earth"}
		elseif choice == 11 then -- Bandanna
			quality = {"black","purple","white","brown","green","pink","teal","navy","darkpurple","orange","babyblue","lava","star"}
		end

		-- Verify player has minimum [fine] cloth items required to craft
		if player:hasItem("cloth", matsAmts[choice]) ~= true and player:hasItem("fine_cloth", matsAmts[choice]) ~= true then
			player:dialogSeq({tcloth, "You need " .. matsAmts[choice] .. " bolts of cloth to tailor."}, 0)
			return
		end

		-- Take either cloth, or fine cloth to begin our craft
		local clothtaken = "cloth"
		if player:hasItem("cloth", matsAmts[choice]) == true then
			player:removeItem("cloth", matsAmts[choice], 9)
		elseif player:hasItem("fine_cloth", matsAmts[choice]) == true then
			clothtaken = "fine_cloth"
			player:removeItem("fine_cloth", matsAmts[choice], 9)
		end

		for z = 1, matsAmts[choice] do
			crafting.skillChanceIncrease(player, NPC("Lin"), "tailoring")
		end

		-- Randomly choose a quality from our available range
		local rand = math.random(qualityMin[skillLevelID], qualityMax[skillLevelID])
		if choice == 11 then rand = math.random(1, 13) end

		-- Build item table
		local itemstable = {}
		for i = 1, #quality do
			table.insert(itemstable, quality[i] .. "_" .. chosenItem)
		end

		-- 1 in starMaxRandom[skillLevelID] chance of star quality
		local isStarQuality = false
		if starMaxRandom[skillLevelID] ~= 0 and math.random(1, starMaxRandom[skillLevelID]) == 1 then
			isStarQuality = true
		end

		-- Fine cloth is 100% success, lets process those first
		if clothtaken == "fine_cloth" then
			if isStarQuality then
				player:addItem("star_" .. chosenItem,1)
			else
				player:addItem(itemstable[rand], 1)
			end
			player:dialogSeq({{graphic = Item(itemstable[rand]).icon, color = Item(itemstable[rand]).iconC}, "You were successful."}, 0)
			return
		end

		-- Test if their cloth crfting attempt is successful
		if math.random(1, 100) > regChance[skillLevelID] then
			player:dialogSeq({{graphic = Item(clothtaken).icon, color = Item(clothtaken).iconC}, "You failed your attempt."}, 0)
			return
		end

		-- Test if their attempt will create star quality
--		if starChance[skillLevelID] ~= 0 and math.random(1, 100) <= starChance[skillLevelID] and isStarQuality then
--			player:addItem("star_" .. chosenItem,1)
--		else
		player:addItem(itemstable[rand], 1)
--		end

		player:dialogSeq({{graphic = Item(itemstable[rand]).icon, color = Item(itemstable[rand]).iconC}, "You were successful."}, 0)
	end
}

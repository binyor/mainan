onKill = function(block, player)
end

onWalk = function(player)
	if player.m == 15050 then
		BomberWarNpc.pickups(player)
	end
end

use = async(function(player)
end)

onInventoryClick = async(function(player)
	local item = player:getInventoryItem(player.invSlot)
	local iname = ""
	local iid = item.id .. "\n"
	local idmg = "DPS: " ..  (item.minSDmg + item.maxSDmg) / 2 .. "\n"
	local itype = "Item Type:" .. item.type
	local lvlstr = ""
	local mightstr = ""
	local willstr = ""
	local gracestr = ""
	local str = ""
	local equipstr = ""
	local acstr = ""
	local vitastr = ""
	local manastr = ""
	local mdurastr = ""
	local cdurastr = ""
	local dmgstr = ""
	local hitstr = ""
	local damstr = ""
	local protstr = ""
	local regenstr = ""
	local bodstr = ""
	local stackamtstr = ""
	local totalvalstr = ""
	local amtstr = ""
	local wisstr = ""
	local sexstr = ""
	local rarestr = ""
	iname = item.name .. "\n"
	if(item.rare == 5) then
		rarestr = "  ***LEGENDARY***\n\n"
		iname = "         " .. item.name .. "\n\n"
	elseif(item.rare == 4) then
		rarestr = "          **EPIC**\n\n"
		iname = "         " .. item.name .. "\n\n"
		elseif(item.rare == 3) then
			rarestr = "          **RARE**\n\n"
			iname = "         " .. item.name .. "\n\n"
			elseif(item.rare == 2) then
				rarestr = " ****ARTIFACT****\n\n"
				iname = "          " .. item.name .. "\n\n"
				elseif(item.rare == 1) then
					rarestr = "         *GM ITEM*\n\n"
					iname = "         " .. item.name .. "\n\n"
	end
	if(item.level == 99 and item.mark >= 1) then
		lvlstr = "\n\nMark Req: \n" .. item.rank
	elseif(item.level > 1 and item.level <= 99 and item.mark == 0) then
		lvlstr = "\n\nLevel Req : \n" .. item.level .. "  " .. item.rank
	end

	if(item.type == 3 or item.type == 4 or item.type == 5 or item.type == 6 or item.type == 7 or item.type == 10 ) then
		player:sendMinitext(item.name .. " type is " .. item.type)
	if(item.maxDura >= 1) then
		durapctstr = math.floor((item.dura / item.maxDura) * 100)
		durastr = "Durability: " .. durapctstr .. "%" .. "\n\n"
	end
	if(item.type == 4) then
		if(item.sex == 1) then
			sexstr = " (F)"
			elseif(item.sex == 0) then
				sexstr = " (M)"
			end
	end

	if (item.minSDmg >= 1 and item.maxSDmg >= 1) then
		dmgstr = "DPS: " .. ((item.minSDmg + item.maxSDmg) / 2) .. "\n"
		player:sendMinitext(dmgstr)
	end
	if (item.vita >= 1) then
		vitastr = "Vita: " .. item.vita .. " "
	end
	if (item.mana >= 1) then
		manastr = "Mana: " .. item.mana .. "\n"
	end
	if (item.armor <= -1) then
		acstr = "AC: " .. item.armor .. "\n\n"
		player:sendMinitext("Has AC")
	end
	if (item.might >=1) then
		 mightstr = "Might:" .. item.might .. " "
		player:sendMinitext(mightstr)
	end
	if (item.will >= 1) then
		 willstr = "Will:" .. item.will .. " "
		player:sendMinitext(willstr)
	end
	if (item.grace >= 1) then
		 gracestr = "Grace:" .. item.grace .. "\n\n"
		player:sendMinitext(gracestr)
	end
	if (item.hit >= 1) then
		hitstr = "Hit: " .. item.hit .. "   "
	end
	if (item.dam >= 1) then
		damstr = "Dam: " .. item.dam .. "\n\n"
	end
	if (item.protection >= 1) then
		protstr = "Protection: " .. item.protection .. "\n"
	end
	if (item.healing >= 1) then
		regenstr = "Regen:" .. item.healing .. " \n"
	end
	if (item.wisdom >= 1) then
		wisstr = "Wisdom:" .. item.wisdom .. " "
	end

 	equipstr = iname .. rarestr .. durastr .. dmgstr .. acstr .. vitastr .. manastr .. mightstr .. willstr .. gracestr .. hitstr .. damstr .. protstr .. regenstr .. wisstr ..  lvlstr .. sexstr
	player:inventoryPopup(player, equipstr, player.invSlot)
	elseif(item.type ~= 3 or item.type ~= 4) then
		if(item.stackAmount > 1) then
		local totalvalue = (item.price * item.amount)
		totalvalstr = "\nTotal Value: " .. "\n" .. totalvalue
		amtstr = "\n\nAmount: " .. item.amount
		stackamtstr = "\nStack size: " .. item.stackAmount
		end

		str = iname .. rarestr .. "\n" .. "Value: \n" .. item.price .. totalvalstr .. amtstr ..  stackamtstr
		player:inventoryPopup(player, str, player.invSlot)
	end
end)



useBeardItem = async(function(player)
	local item = player:getInventoryItem(player.invSlot)

	local t = {graphic = item.icon, color = item.iconC}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if player:getEquippedItem(EQ_FACEACCTWO) ~= nil then
		-- slot 14
		player:dialogSeq(
			{
				t,
				"You will need to shave your beard before you can get a new style!"
			},
			0
		)
		return
	end

	local confirm = player:menuSeq(
		"Are you sure you want to equip the beard? This is a one time operation and the item disappears upon use.",
		{"Yes, add my beard.", "No, nevermind."},
		{}
	)

	if confirm == 1 then
		if player:hasItem(item.yname, 1) ~= true then
			return
		end

		player:forceEquip(item.id, EQ_FACEACCTWO)

		player:removeItem(item.yname, 1)

		player:updateState()

		player:dialogSeq({t, "I hope you enjoy your new beard."}, 0)
	end
end)

useHairDye = async(function(player)
	local item = player:getInventoryItem(player.invSlot)

	local t = {graphic = item.icon, color = item.iconC}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local confirm = player:menuSeq(
		"Are you sure you want to apply " .. item.name .. " to your hair?",
		{"Yes, do it.", "Nevermind."},
		{}
	)

	if confirm == 1 then
		if player:hasItem(item.yname, 1) ~= true then
			return
		end

		player.hairColor = item.lookC
		player:updateState()

		player:removeItem(item.yname, 1, 9)

		player:dialogSeq({t, "I hope you enjoy your new hair dye!"}, 0)
		return
	end
end)

useSetItem = function(player)
	local item = player:getInventoryItem(player.invSlot)

	local setItems = getSetItems(item.id)

	local items = {}
	local amounts = {}

	if #setItems > 0 then
		for i = 1, #setItems, 2 do
			if setItems[i] > 0 and setItems[i + 1] > 0 then
				table.insert(items, setItems[i])
				table.insert(amounts, setItems[i + 1])
			end
		end
	end

	for i = 1, #items do
		player:talkSelf(
			0,
			"" .. Item(items[i]).name .. " amount: " .. amounts[i]
		)
	end
end

useSkinItem = async(function(player)
	local item = player:getInventoryItem(player.invSlot)

	if item.skinnable >= 3 and item.skinnable <= 17 then
		-- skins... the skinnable attribute is the equipment slot that it will work for

		local t = {graphic = item.icon, color = item.iconC}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local itemType = item.skinnable - 3

		local equip = player:getEquippedItem(itemType)

		if equip == nil then
			player:dialogSeq(
				{
					t,
					"You are not wearing the base item type the skin is meant for."
				},
				0
			)
			return
		end

		local name = equip.name

		if equip.realName ~= "" then
			-- engrave
			name = equip.realName .. " (" .. equip.name .. ")"
		end

		local confirm = player:menuSeq(
			"Are you sure you want to apply this skin to your " .. name .. "?",
			{"Yes, do it.", "Nevermind."},
			{}
		)

		if confirm == 1 then
			if player:hasItem(item.name, 1) ~= true then
				return
			end

			equip.customLook = item.look
			equip.customLookColor = item.lookC
			equip.customIcon = item.icon - 49152
			equip.customIconColor = item.iconC
			player:removeItem(item.name, 1)

			player:updateState()
		end

		return
	end
end)

onMountItem = function(player)
	local item = player:getInventoryItem(player.invSlot)

	if player:checkIfCast(invis) or player.state == 2 or player.state == 4 then
		player:sendMinitext("You cannot do that.")
		return
	end

	if player:canPK(player) and player.mapTitle ~= "Vale" then
		player:sendMinitext("You cannot do that.")
		return
	end

	if player.canMount == 0 then
		player:sendMinitext("That doesn't work here.")
		return
	end


	player.registry["mountSpeed"] = item.level

	local speed = 50
	speed = player.registry["mountSpeed"]


	for i = 1, 32 do
		player:sendAction(6, 50)
	end

	player.state = 3
	player.disguise = item.look
	player.registry["mountMobId"] = 0
	player.speed = speed
	player:calcStat()
end

onEquip = function(player, item)
	if player.state == 2 or player.state == 4 then
		player:sendMinitext("You can't do that while transformed.")
		return
	end

	if player.state == 3 then
		player:sendMinitext("You can't do that while riding a mount.")
		return
	end

	player:equip()

	player:sendMinitext("AC: " .. player.armor .. " Regen: " .. player.healing .. " Prot: " .. player.protection)
end

onUnequip = function(player, item)
	if player.state == 2 or player.state == 4 then
		player:sendMinitext("You can't do that while transformed.")
		return
	end

	if player.state == 3 then
		player:sendMinitext("You can't do that while riding a mount.")
		return
	end

	player:takeOff()

	player:sendMinitext("AC: " .. player.armor .. " Regen: " .. player.healing .. " Prot: " .. player.protection)
end

equip_delay = {
	cast = function(player)
		player:setAether("equip_delay", 1000)
		player:sendStatus()
		return
	end
}

onDeathPlayer = function(player)
	player.registry["beforeHOattacker"] = player.attacker
	player:setDuration("death_save", 500)
end

onCast = function(player)
	--if player:hasEquipped("charm") then charm.onCast(player)
	--elseif player:hasEquipped("enchanted_charm") then charm.onCast(player)
	--elseif player:hasEquipped("il_san_charm") then charm.onCast(player)
	--elseif player:hasEquipped("ee_san_charm") then charm.onCast(player) end
	--if player:hasEquipped("sam_san_charm") then charm.onCast(player) end
	--if player:hasEquipped("sa_san_charm") then charm.onCast(player) end
end

onBreak = function(player)
end

onThrow = function(player, item)
	player:throwItem()
end

onAction = function(player)
end

onTurn = function(player)
	onSign(player, 3)
end

onSign = function(player, signType)
	local obj = getObjFacing(player, player.side)

	if (obj == 1619 or obj == 1620) and player.side == 0 then
		--player:showBoard(selectBulletinBoard(player))
		player:showBoard(selectBulletinBoard(player.m, player.x, player.y - 1))
	end

	if (signType == 1) then
		--onLook
	elseif (signType == 2) then
		--onScriptedTile
	elseif (signType == 3) then
		--onTurn
		if player.drunk == 1 then
			player.side = math.random(0, 3)
			player:sendSide()
		end
	end
end

onLook = function(player, block)
	onSign(player, 1)

	if block.yname == "blue_rooster" then
		player.quest["seen_blue_rooster"] = 1
	end

	if player.gmLevel > 0 then
		if block.blType == BL_PC then
			player:sendMinitext(block.name .. " \a (" .. ((block.health / block.maxHealth) * 100) .. "%) \a (IP: " .. block.ipaddress .. ") \a ID: " .. block.ID)
		elseif block.blType == BL_MOB then
			local realid = block.ID
			player:sendMinitext(block.name .. " (" .. block.yname .. ") \a ID: " .. block.mobID .. "(" ..realid..  ") \a Lvl: " .. block.level .. " \a Vita: " .. block.health .. " \a AC: " .. block.armor)
			player:sendMinitext("Exp: " .. Tools.formatNumber(block.experience))
		elseif block.blType == BL_NPC then
			local realid = block.ID
			player:sendMinitext(block.name .. " (" .. block.yname .. ") \a ID: " .. block.id .. "("..realid..")")
		elseif block.blType == BL_ITEM then
			if block.id <= 3 then
				-- gold
				player:sendMinitext(block.name .. " (" .. block.yname .. ") \a Amt: " .. block.amount)
			else
				local realName = FloorItem(block.ID).realName
				local dura = FloorItem(block.ID).dura

				local owner = FloorItem(block.ID).owner

				if realName ~= "" then
					player:sendMinitext(realName .. " (" .. block.yname .. ") (" .. ((dura / block.maxDura) * 100) .. "%) \a Amt: " .. block.amount)
				else
					player:sendMinitext(block.name .. " (" .. block.yname .. ") (" .. ((dura / block.maxDura) * 100) .. "%) \a Amt: " .. block.amount)
				end
			end
		end
	else
		if block.blType == BL_PC then
			if block.gmLevel ~= 0 then
				return
			end
			player:sendMinitext(block.title .. " " .. block.name)
		elseif block.blType == BL_MOB then
			player:sendMinitext(block.name)
		elseif block.blType == BL_NPC and block.subType ~= 2 then
			player:sendMinitext(block.name)
		elseif block.blType == BL_ITEM then
			if block.id <= 3 then
				-- gold
				player:sendMinitext(block.name .. " \a Amt: " .. block.amount)
			else
				local realName = FloorItem(block.ID).realName

				if realName ~= "" then
					player:sendMinitext(realName .. " \a Amt: " .. block.amount)
				else
					player:sendMinitext(block.name .. " \a Amt: " .. block.amount)
				end
			end
		end
	end
end

onClick = function(player, target)
	if target.blType == BL_PC then
		if player.gmLevel > 0 then
      if (player.registry["gm_click"]~=0) then
        player.dialogType = 0
        player:freeAsync()
        gm_click.menu(player, target)
      end
		end
	end
end

onMount = function(player, mob)
	local disguise = 0
	local speed = 0

	if mob.yname == "horse" then
		disguise = 26
		speed = 50
	elseif mob.yname == "arawns_stag" then
		disguise = 126
		speed = 50
	else
		return
	end

	player.state = 3

	player.disguise = disguise

	player.registry["mountMobId"] = mob.mobID
	player.registry["mountSpeed"] = 50

	mob:vanish()
	player.speed = speed
	player:calcStat()
end

onDismount = function(player)
	side = player.side
	mountMobId = player.registry["mountMobId"]
	player.disguise = 0
	player.state = 0

	if player.speed < 90 then
		player.speed = 90
	end
	player:updateState()

	player:sendMinitext("You precariously step again onto the ground.")

	if mountMobId ~= 0 then
		local x = 0
		local y = 0

		--[[if side == 0 then
			if player.y - 1 < 0 then
				player:spawn(mountMobId, player.x, player.y, 1, player.m)
			else
				player:spawn(mountMobId, player.x, player.y-1, 1, player.m)
			end
		elseif side == 1 then -- left
			if getMapXMax(player.m) < player.x + 1 then
				player:spawn(mountMobId, player.x, player.y, 1, player.m)
			else
				player:spawn(mountMobId, player.x+1, player.y, 1, player.m)
			end
		elseif side == 2 then
			if getMapYMax(player.m) < player.y + 1 then
				player:spawn(mountMobId, player.x, player.y, 1, player.m)
			else
				player:spawn(mountMobId, player.x, player.y+1, 1, player.m)
			end
		elseif side == 3 then
			if player.x - 1 < 0 then
				player:spawn(mountMobId, player.x, player.y, 1, player.m)
			else
				player:spawn(mountMobId, player.x-1, player.y, 1, player.m)
			end
		end]]
		--

		if side == 0 then
			x = player.x
			y = player.y - 1
		elseif side == 1 then
			x = player.x + 1
			y = player.y
		elseif side == 2 then
			x = player.x
			y = player.y + 1
		elseif side == 3 then
			x = player.x - 1
			y = player.y
		end

		if x < 0 then
			x = 0
		end
		if y < 0 then
			y = 0
		end
		if x > getMapXMax(player.m) then
			x = getMapXMax(player.m)
		end
		if y > getMapYMax(player.m) then
			y = getMapYMax(player.m)
		end

		local obj = getObject(player.m, x, y)
		local mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
		local npcCheck = player:getObjectsInCell(player.m, x, y, BL_NPC)
		local pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)
		local warpCheck = getWarp(player.m, x, y)
		local passCheck = getPass(player.m, x, y)

		if obj == 0 and #mobCheck == 0 and #npcCheck == 0 and #pcCheck == 0 and passCheck == 0 and not warpCheck then
			player:spawn(mountMobId, x, y, 1, player.m)
		else
			player:spawn(mountMobId, player.x, player.y, 1, player.m)
		end

		player.registry["mountMobId"] = 0
	end
end

remount = function(player)
	player.speed = player.registry["mountSpeed"]
	player:updateState()
end

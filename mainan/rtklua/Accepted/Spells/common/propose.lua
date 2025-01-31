propose = {
	cast = async(function(player)
		if player:hasLegend("engaged") or player:hasLegend("married") then
			player:removeSpell("propose")
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		player:setDuration("propose", 1200000)
		player.setAether("propose", 1200000)

		local pcs = player:getObjectsInArea(BL_PC)

		local item = Item("engagement_ring")
		player.npcGraphic = item.icon
		player.npcColor = 0

		if player:hasLegend("engaged") or player:hasLegend("married") or player:hasLegend("forged_blood_oath") or player:hasLegend("sealed_blood_oath") or player.partner ~= 0 then
			player:dialog("Anda sudah terikat dengan orang lain!", {})
			return
		end

		local choice = player:inputSeq(
			"Siapa nama orang yang kamu cintai?",
			"Yang mengagumkan",
			"telah memikat hatiku",
			{},
			{}
		)

		if choice == "" then
			return
		end
		if choice == player.name then
			player:dialog("Anda tidak bisa menikahi diri sendiri.", {})
			return
		end

		local target = Player(choice)

		if target == nil then
			player:dialog("Pemain tidak valid atau tidak online.", {})
			return
		end

		local found = false

		for i = 1, #pcs do
			if pcs[i].ID == target.ID then
				found = true
			end
		end

		if found == false then
			player:popUp("Kekasihmu harus dekat denganmu ketika kamu membuat komitmen ini.")
			return
		end

		if target:hasLegend("engaged") or target:hasLegend("married") or target:hasLegend("forged_blood_oath") or target:hasLegend("sealed_blood_oath") or target.partner ~= 0 then
			player:dialog(
				target.name .. " sudah terikat dengan orang lain!",
				{}
			)
			return
		end

		if target:hasItem("engagement_ring", 1) ~= true and not target:hasEquipped("engagement_ring") then
			player:dialog("Anda belum memberinya cincin pertunangan.", {})
			return
		end

		target:freeAsync()
		target.registry["proposer"] = player.ID
		propose.prompt(target)
	end),

	prompt = async(function(target)
		local proposer = Player(target.registry["proposer"])
		local accept = target:menuSeq(
			proposer.name .. " melamar untuk menikah. Apakah Anda menerima?",
			{"Ya! Saya sangat jatuh cinta.", "Saya harus menolak."},
			{"tutup"}
		)

		if accept == 1 then
			target:addLegend(
				"Engaged to $player (" .. curT() .. ")",
				"engaged",
				6,
				1,
				proposer.ID
			)
			proposer:addLegend(
				"Engaged to $player (" .. curT() .. ")",
				"engaged",
				6,
				1,
				target.ID
			)
			proposer:removeSpell("propose")
			target:removeItem("engagement_ring", 1)

			target.registry["partner1"] = proposer.ID
			target.registry["partner2"] = target.ID

			proposer.registry["partner1"] = proposer.ID
			proposer.registry["partner2"] = target.ID

			target.registry["marriage_timer"] = os.time() + 259200

			-- 3 days
			proposer.registry["marriage_timer"] = os.time() + 259200

			-- 3 days

			proposer:removeSpell("propose")
			proposer:dialog(target.name .. " terima!", {})
		elseif accept == 2 then
			target.registry["proposer"] = 0
			proposer:dialog(target.name .. " terpaksa menolak.", {})

			return
		end
	end),

	requirements = function(player)
		local level = 5
		local items = {}
		local itemAmounts = {}
		local desc = "Mantra ini dapat digunakan untuk melamar seseorang yang Anda cintai."
		return level, items, itemAmounts, desc
	end
}

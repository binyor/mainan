mentor = {
	cast = async(function(player)
		local t = {
			graphic = convertGraphic(core.look, "monster"),
			color = core.lookColor
		}
		player.npcGraphic = 0
		player.npcColor = 0
		player.dialogType = 0
		player.lastClick = 0

		local magic = 100
		if (not player:canCast(1, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local pcs = player:getObjectsInArea(BL_PC)

		local choice = player:inputSeq(
			"Siapa yang ingin Anda mentor?",
			"",
			"",
			{},
			{}
		)

		if choice == "" then
			return
		end
		if string.lower(choice) == string.lower(player.name) then
			player:dialog("Anda tidak bisa menjadi mentor untuk diri sendiri.", {})
			return
		end

		local target = Player(choice)

		if target == nil then
			player:dialog("Pemain tidak valid atau tidak online.", {})
			return
		end

		if not distanceSquare(player, target, 3) then
			player:popUp(target.name .. " harus berada dekat dengan Anda saat Anda meminta untuk menjadi mentor.")
			return
		end

		if target.level < 3 or target.level > 8 then
			if target:hasLegend("mentored_by") then
				player:dialog(target.name .. " sudah memiliki mentor!", {})
				return
			end
			if target.registry["mentor"] ~= player.ID and target.registry["mentor"] ~= 0 then
				player:dialog(target.name .. " bukan bukan muridmu!", {})
				return
			end

			if target.level >= 15 then
				if target.registry["mentor"] == player.ID then
					local choice_a = player:menuSeq(
						"Anda dapat menyelesaikan mentoring seseorang di level 15. Apakah Anda ingin melanjutkan?",
						{"Ya, tidak masalah.", "Tidak, sama sekali tidak."},
						{}
					)

					if choice_a == 1 then
						player.registry["mentored"] = player.registry["mentored"] + 1
						target.registry["mentor"] = 0

						if player:hasLegend("mentored") then
							player:removeLegendbyName("mentored")
						end

						player:addLegend(
							"Telah menjadi mentor untuk " .. player.registry["mentored"] .. " pemain baru",
							"mentored",
							3,
							1
						)

						if target:hasLegend("being_mentored_by") then
							target:removeLegendbyName("being_mentored_by")
						end
						target:addLegend(
							"Mentored by $player (" .. curT() .. ")",
							"mentored_by",
							3,
							1,
							player.ID
						)

						player:dialog(
							"Ini menandai selesainya mentoring Anda terhadap " .. target.name .. ". Semoga mereka telah belajar banyak dari ajaran Anda.",
							{}
						)
						target:dialog(
							"Ini menandai selesainya mentorship Anda di bawah " .. player.name .. ". Semoga Anda telah belajar banyak dari ajaran mereka.",
							{}
						)
					end
					return
				end
			else
				player:dialog(
					target.name .. " harus berada di antara level 3 dan 8 untuk menerima mentorship.",
					{}
				)
			end
		else
			if target:hasLegend("mentored_by") then
				player:dialog(target.name .. " sudah memiliki mentor!", {})
				return
			end
			if target.registry["mentor"] ~= 0 then
				if target.registry["mentor"] == player.ID then
					player:dialog(
						target.name .. " sudah menjadi murid Anda!",
						{}
					)
				end
				if target.registry["mentor"] ~= player.ID then
					player:dialog(
						target.name .. " sudah memiliki mentor dari orang lain!",
						{}
					)
				end
				return
			end

			if target.level < 3 then
				player:dialogSeq(
					{
						t,
						"Pemain harus memiliki level minimal 3 untuk menerima mentorship Anda."
					},
					0
				)
				return
			end

			player:dialogSeq(
				{
					t,
					"Menjadi mentor bagi seseorang di dunia Toapekong adalah cara yang baik untuk menunjukkan pengetahuan Anda tentang permainan dan mendukung komunitas.",
					"Anda dapat mulai menjadi mentor untuk seseorang selama mereka telah mencapai wawasan ke-3 dan belum melebihi wawasan ke-8.",
					"Mentoree yang diusulkan juga harus bebas dari mentorship orang lain.",
					"Setelah Anda mengajarkan banyak hal kepada mentoree Anda, Anda dapat mengakhiri mentorship ketika mentoree mencapai wawasan ke-15."
				},
				1
			)
			local choice = player:menuSeq(
				"Apakah Anda yakin ingin menawarkan mentorship kepada " .. target.name .. "?",
				{"Ya", "Tidak"},
				{}
			)
			if choice == 1 then
				target:freeAsync()
				target.registry["proposer"] = player.ID
				mentor.prompt(target)
			end
		end
	end),

	prompt = async(function(target)
		local proposer = Player(target.registry["proposer"])
		local accept = target:menuSeq(
			proposer.name .. " ingin menawarkan Anda mentorship. Apakah Anda menerima?",
			{"Ya! Saya butuh panduan.", "Tidak, saya harus menolak."},
			{"close"}
		)

		if accept == 1 then
			if proposer == nil then
				return
			end

			target.registry["proposer"] = 0
			target.registry["mentor"] = proposer.ID
			target:addLegend(
				"Sedang menjadi muridnya $player",
				"being_mentored_by",
				1,
				128,
				proposer.ID
			)

			proposer:dialog(
				target.name .. " menerima tawaran mentorship Anda! Silakan pandu mereka hingga level 15 di mana Anda perlu menggunakan mantra ini lagi untuk mengakhiri mentorship.",
				{}
			)
		elseif accept == 2 then
			target.registry["proposer"] = 0

			proposer:dialog(target.name .. " terpaksa menolak.", {})

			return
		end
	end),

	requirements = function(player)
		local level = 40
		local items = {}
		local itemAmounts = {}

		if player.baseClass == 1 then
			-- warrior
			table.insert(items, Item("maxcaliber").id)
		elseif player.baseClass == 2 then
			-- rogue
			table.insert(items, Item("moonblade").id)
		elseif player.baseClass == 3 then
			-- mage
			table.insert(items, Item("deaths_head").id)
		elseif player.baseClass == 4 then
			-- poet
			table.insert(items, Item("wicked_staff").id)
		end

		table.insert(itemAmounts, 1)
		table.insert(items, 0)
		table.insert(itemAmounts, 1000)
		local desc = "Mantra ini dapat digunakan untuk menjadi mentor bagi pemula."
		return level, items, itemAmounts, desc
	end
}
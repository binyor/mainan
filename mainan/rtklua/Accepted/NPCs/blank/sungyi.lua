sungyi = {
		click = async(function(player, npc)
		local t = {
				graphic = convertGraphic(npc.look, "monster"),
				color = npc.lookColor
			}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
		player.lastClick = npc.ID

		local allSkills = {
			"woodworking",
			"metalworking",
			"jewelry making",
			"fishing",
			"weaving",
			"smelting",
			"gemcutting",
			"woodcutting",
			"mining",
			"farming",
			"food preparation",
			"chef",
			"potion making",
			"scribing",
			"tailoring"
		}
		local allSkillNames = {
			"Carpentry",
			"Smithing",
			"Jewelcrafting",
			"Fishing",
			"Weaving",
			"Smelting",
			"Gemcutting",
			"Woodcutting",
			"Mining",
			"Farming",
			"Food preparation",
			"Chef",
			"Alchemy",
			"Inscription",
			"Tailoring"
		}

		local hasSkills = {}
		local hasSkillsNames = {}
		local skillLevels = {}

		for i = 1, #allSkills do
			if crafting.checkSkillLegend(player, allSkills[i]) then
				table.insert(hasSkills, allSkills[i])
				table.insert(hasSkillsNames, allSkillNames[i])
			end
		end

		for i = 1, #hasSkillsNames do
			local level = crafting.getSkillLevel(player, hasSkills[i])

			if level == nil then
				level = "novice"
			end

			hasSkillsNames[i] = hasSkillsNames[i] .. " (Current level: " .. level .. ")"
		end

		local choice = player:menuSeq(
			"Please select your skill that you would like to inquire about.",
			hasSkillsNames,
			{}
		)


		local chosenSkill = hasSkills[choice]
		local skillPtsTable = crafting.skillPointsPerLevel(chosenSkill)
		local hasPts = player.registry[chosenSkill]

		local nextPts = 0
		if not crafting.checkSkillLevel(player, chosenSkill, "legendary") then
			for i = 1, #skillPtsTable do
				if hasPts >= skillPtsTable[i] then
					nextPts = skillPtsTable[i + 1]
				end
			end
		else
			player:dialogSeq(
				{
					t,
					"You are legendary status and cannot increase your skill any further."
				},
				0
			)
			return
		end
		leftPoints = nextPts - hasPts
		player:sendMinitext("Current Skill Progress: ")
		player:sendMinitext(leftPoints .. " to next rank.")

		local percentage = (hasPts / nextPts) * 100
		percentage = string.format("%.2f", percentage)

		player:dialogSeq(
			{
				t,
				"Current Skill Progress:                             " .. leftPoints .. " to next rank."
			},
			0
		)
	end)

}
FrankNpc = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
		
		if player.quest["knightq"] == 8 then

			if player.sex == 0 then
				player:dialogSeq(
					{
						t,
						"Congratulations on your success, Squire " .. player.name.. ". Your efforts showed bravery in the face of danger and have brought honor to the kingdom as well as protected it's subjects.",
						"Kneel before me.",
						"*the king unsheathes his sword*",
						"I knight thee, Sir " .. player.name.. ", defender of the realm and protector of the people. Rise and be recognized."
					}, 1)
			else
				player:dialogSeq(
					{
						t,
						"Congratulations on your success, Squire " .. player.name.. ". You efforts showed bravery and cunning in the face of danger and have brought honor to the kingdom as well as protected it's subjects.",
						"Kneel before me.",
						"I knight thee, Lady " .. player.name.. ", defender of the realm and protector of the people. Rise and be recognized."
					}, 1)
			end

			player:updatePath(29, player.mark)
			player:addLegend("Knight of Blank Kingdom (" .. curT() ..")", "knighted", 149, 5)
			player.quest["knightq"] = 0

			broadcast(
				-1,
				"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!"
			)
		else
			player:dialogSeq(
				{
					t,
					"Greetings loyal citizen of Blank! Be sure to keep the peace."
				}, 0)
			return
		end
	end)
}
as_giver = {
	click = async(function(player, npc)
    local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
    player.lastClick = npc.ID


		if player:hasSpell("auto_swing") then
			player:dialogSeq({t, "Keep trainin' brother!"}, 0)
			return
		end

    player:dialogSeq({t, "Want arms like THESE? I'll teach ya a new technique!"},1)
    player:addSpell("auto_swing")
    player:sendAnimation(2, 0)
    player:sendMinitext("You've learned auto-swing!")
    

	end)
}
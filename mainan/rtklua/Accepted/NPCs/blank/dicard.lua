dicard = {
	click = async(function(player, npc)
    local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
    player.lastClick = npc.ID

    player:dialogSeq(
        {
            t,
            "I see you've made it all the way to the new kingdom, welcome to my home Blank.",
            "You'll see you can find most amenities around our kingdom, please be wary as not everyone will be as accepting of you as I am."
        },
        1
    )
    player:sendMinitext("Welcome to the Blank Kingdom!")
    

	end)
}
turkey_giver = {
	click = async(function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
        player.lastClick = npc.ID
        local opts = {}


        if player.registry["hasgun"] == 0 then
            table.insert(opts,"Sure!")
            table.insert(opts,"Maybe later")
        end

        if player.registry["hasgun"] == 1 then
            player:dialogSeq({t,"You better get back to shootin them damn turkeys!"},1)
        end


        local menu = player:menuString("Hey youngin, I can't stop hearin gobblin from these damn turkeys. How bout you take this blaster here and shoot them damn turkeys for me.", opts)

        if menu == "Sure!" then
            player:addItem("shot_gun",1)
            player.registry["hasgun"] = 1
            
        end

    end)
}
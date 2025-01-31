leg_scroll = {

use = function(player)
	local invItem = player:getInventoryItem(player.invSlot)
	
	local scrollName = invItem.name
	if not player:canAction(1, 1, 1) then return end
	
	if player.state == 1 then player:sendMinitext("How can you open this with no hands?") return end
	
	if player:hasLegend("legend_test") then -- removeLegendbyName
		for i=1,255 do
			player:removeLegendbyName("legend_test")
		end
	else
		for i=1,255 do
			player:addLegend("icon + colour: "..i,"legend_test",i,i)
		end
	end
	
end
}
	
	consumable = {
		cast = function(player)
			player:setAether("consumable",1000)
			return
		end
	}
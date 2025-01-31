equipment_restore = {

use = function(player)

	local str = ""
	--player:freeAsync()
	local cost=0
	local total=0
	local name = "<b>[Repair All]\n\n"

	local equippedItems = {}
	local equipment = {EQ_HELM,EQ_WEAP,EQ_ARMOR,EQ_SHIELD,
						EQ_LEFT,EQ_RIGHT,EQ_SUBLEFT,EQ_SUBRIGHT,
						EQ_NECKLACE,EQ_BOOTS}

	local inventoryItems = {}
	local equipRepairCost = 0
	local inventoryItemsCost = 0
	local inventoryCost=0
	local totalCost = 0

	local item = player:getInventoryItem(player.invSlot)

	if not player:canAction(1, 1, 0) then return end
	if player.health <= 0 then player:sendMinitext("You need a physical body to do that.") return end

	if player:removeItem("equipment_restore", 1) == true then

		for i = 1, #equipment do
			if player:getEquippedItem(equipment[i]) ~= nil then
				table.insert(equippedItems, player:getEquippedItem(equipment[i]))
			end
		end

		for i = 1, #equippedItems do
			if equippedItems[i] ~= nil then
				if (equippedItems[i].repairable == false) and (equippedItems[i].price~=0) and (equippedItems[i].dura < equippedItems[i].maxDura) then			
					equippedItems[i].dura=equippedItems[i].maxDura
					equippedItems[i].repairCheck = 0
				end
			end
		end
	end

end

}
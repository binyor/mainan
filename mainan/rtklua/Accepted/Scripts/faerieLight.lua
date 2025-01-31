Player.gleamingSword = function(player)
	local t = {graphic = convertGraphic(2573, "item"), color = 3}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	if not player:karmaCheck("angel") then
		player:dialogSeq({t, "You do not possess Angel karma."}, 0)
		return
	end

	local choice = player:menuSeq(
		"Thy karma fills thy soul. Shall it light the way for all?",
		{"Yes, exchange my karma for it.", "No, I will retain my karma."},
		{}
	)

	if choice == 1 then
		player:removeKarma(math.random(25, 30))
		player:addItem("gleaming_sword", 1, 0, player.ID)
		player:dialogSeq({t, "May the gleaming sword guide your soul."}, 0)
		return
	elseif choice == 2 then
		player:dialogSeq({t, "May another opportunity present itself."}, 0)
		return
	end
end

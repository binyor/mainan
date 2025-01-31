subpath_scrolls = {
	use = function(player)
		local item = player:getInventoryItem(player.invSlot)

		player:showBoard(item.yname .. "_board")
		local rand = math.random(1,5)

		if rand == 4 then
			player:removeItem(item.yname, 1)
			player:sendMinitext("The scroll crumbles..")
		end
	end,
}


unified_theory_of_magic = {
	use = function(player)
		--subpath_scrolls.use(player)
		local item = player:getInventoryItem(player.invSlot)

		player:showBoard(item.yname .. "_board")
		
		if player.quest["wizard_scroll"] > 0 and player.quest["wizard_scroll"] < 3 then
			return
		end
		local rand = math.random(1,20)

		if rand == 4 then
			player:removeItem(item.yname, 1)
			player:sendMinitext("The scroll crumbles..")
		end		
	end
}

tales_of_the_bard = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}


divine_chronicles = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
graced_by_the_muse = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
the_wandering_monk = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
tomes_of_the_earth = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
ranger_code = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
kwanhonsagje = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
barbarian_runes = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
ancient_parchment = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
knowledge_of_wealth = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
spys_journal = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
shu_jing = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}
chieko = {
	use = function(player)
		subpath_scrolls.use(player)
	end
}

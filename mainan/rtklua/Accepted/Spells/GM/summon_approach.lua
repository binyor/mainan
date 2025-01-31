approach = {
	cast = function(player, target)
		local nP = Player(player.question)
		if (nP ~= nil) then
			player:warp(nP.m, nP.x, nP.y)
		else
			player:sendMinitext(nP .. " tidak online.")
		end
	end
}

summon = {
	cast = function(player, target)
		local question = Player(player.question)

		if (question == nil) then
			player:sendMinitext("Mereka sedang tidak online.")
		else
			if (player.region == question.region or player.gmLevel > 50) then
				question:warp(player.m, player.x, player.y)
			else
				player:sendMinitext("Pemain itu berada di wilayah yang berbeda dari milikmu.")
				player:setAether("summon", 5000)
			end
		end
	end,
	on_aethers = function(player)
		local question = Player(player.question)

		if (question == nil) then
			player:sendMinitext("Mereka sedang tidak online.")
		else
			if (player.region == question.region) then
				question:warp(player.m, player.x, player.y)
			else
				question:warp(player.m, player.x, player.y)
				player:sendMinitext("Kamu telah memanggil " .. player.question .. " from region " .. question.region ".")
			end
		end
	end
}

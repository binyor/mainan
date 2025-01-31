swing2 = function(player)

	local rand = math.random(0, 1)
	local mobUp = player:getObjectsInCell(
		player.m,
		player.x,
		player.y - 1,
		BL_MOB
	)
	local mobLeft = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y,
		BL_MOB
	)
	local mobRight = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y,
		BL_MOB
	)
	local mobDown = player:getObjectsInCell(
		player.m,
		player.x,
		player.y + 1,
		BL_MOB
	)
	local mobUpExtend = player:getObjectsInCell(
		player.m,
		player.x,
		player.y - 2,
		BL_MOB
	)
	local mobLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 2,
		player.y,
		BL_MOB
	)
	local mobRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 2,
		player.y,
		BL_MOB
	)
	local mobDownExtend = player:getObjectsInCell(
		player.m,
		player.x,
		player.y + 2,
		BL_MOB
	)
	local mobUpLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y - 1,
		BL_MOB
	)
	local mobUpRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y - 1,
		BL_MOB
	)
	local mobDownLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y + 1,
		BL_MOB
	)
	local mobDownRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y + 1,
		BL_MOB
	)
	local pcUp = player:getObjectsInCell(
		player.m,
		player.x,
		player.y - 1,
		BL_PC
	)
	local pcLeft = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y,
		BL_PC
	)
	local pcRight = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y,
		BL_PC
	)
	local pcDown = player:getObjectsInCell(
		player.m,
		player.x,
		player.y + 1,
		BL_PC
	)
	local pcUpExtend = player:getObjectsInCell(
		player.m,
		player.x,
		player.y - 2,
		BL_PC
	)
	local pcLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 2,
		player.y,
		BL_PC
	)
	local pcRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 2,
		player.y,
		BL_PC
	)
	local pcDownExtend = player:getObjectsInCell(
		player.m,
		player.x,
		player.y + 2,
		BL_PC
	)
	local pcUpLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y - 1,
		BL_PC
	)
	local pcUpRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y - 1,
		BL_PC
	)
	local pcDownLeftExtend = player:getObjectsInCell(
		player.m,
		player.x - 1,
		player.y + 1,
		BL_PC
	)
	local pcDownRightExtend = player:getObjectsInCell(
		player.m,
		player.x + 1,
		player.y + 1,
		BL_PC
	)
	local extendHit = player.extendHit

	local objRight = getObject(player.m, player.x + 1, player.y)
	local objLeft = getObject(player.m, player.x - 1, player.y)
	local objUp = getObject(player.m, player.x, player.y - 1)
	local objDown = getObject(player.m, player.x, player.y + 1)

	if (player.side == 0) then
		if (#mobUp > 0) then
			extendHit = false
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#pcUp > 0) then
			extendHit = 0
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (extendHit) then
			if not (#mobUp > 0) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (not (#mobLeft > 0)) and (player.flank) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (not (#mobRight > 0)) and (player.flank) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#mobDown > 0)) and (player.backstab) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if not (#pcUp > 0) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (not (#pcLeft > 0)) and (player.flank) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (not (#pcRight > 0)) and (player.flank) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (not (#pcDown > 0)) and (player.backstab) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobLeft > 0 and player.flank) then -- if (#mobLeft > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#mobRight > 0 and player.flank) then -- if (#mobRight > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#mobDown > 0 and player.backstab) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#pcLeft > 0 and player.flank) then -- if (#pcLeft > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (#pcRight > 0 and player.flank and rand == 1) then -- if (#pcRight > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (#pcDown > 0 and player.backstab) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

	elseif (player.side == 1) then
		if (#mobRight > 0) then
			extendHit = false
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#pcRight > 0) then
			extendHit = false
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (extendHit) then
			if (not (#mobUp > 0)) and (player.flank) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (not (#mobLeft > 0)) and (player.backstab) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (not (#mobRight > 0)) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#mobDown > 0)) and (player.flank) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#pcUp > 0)) and (player.flank) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (not (#pcLeft > 0)) and (player.backstab) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (not (#pcRight > 0)) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (not (#pcDown > 0)) and (player.flank) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobUp > 0 and player.flank) then -- if (#mobUp > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#mobDown > 0 and player.flank) then -- if (#mobDown > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#mobLeft > 0 and player.backstab) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#pcUp > 0 and player.flank) then -- if (#pcUp > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (#pcDown > 0 and player.flank) then -- if (#pcDown > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

		if (#pcLeft > 0 and player.backstab) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

	elseif (player.side == 2) then
		if (#mobDown > 0) then
			extendHit = false
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#pcDown > 0) then
			extendHit = false
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end
		
		if (extendHit) then
			if (not (#mobUp > 0)) and (player.backstab) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (not (#mobLeft > 0)) and (player.flank) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (not (#mobRight > 0)) and (player.flank) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#mobDown > 0)) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#pcUp > 0)) and (player.backstab) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (not (#pcLeft > 0)) and (player.flank) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (not (#pcRight > 0)) and (player.flank) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (not (#pcDown > 0)) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobLeft > 0 and player.flank) then -- if (#mobLeft > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#mobRight > 0 and player.flank) then -- if (#mobRight > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#mobUp > 0 and player.backstab) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#pcLeft > 0 and player.flank) then -- if (#pcLeft > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (#pcRight > 0 and player.flank) then -- if (#pcRight > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end

		if (#pcUp > 0 and player.backstab) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

	elseif (player.side == 3) then
		if (#mobLeft > 0) then
			extendHit = false
			for i = 1, #mobLeft do
				player:swingTarget(mobLeft[i])
			end
		end

		if (#pcLeft > 0) then
			extendHit = false
			for i = 1, #pcLeft do
				if (player:canPK(pcLeft[i])) then
					player:swingTarget(pcLeft[i])
				end
			end
		end

		if (extendHit) then
			if (not (#mobUp > 0)) and (player.flank) then
				if (#mobUpExtend > 0) then
					for i = 1, #mobUpExtend do
						player:swingTarget(mobUpExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end
			end

			if (not (#mobLeft > 0)) then
				if (#mobLeftExtend > 0) then
					for i = 1, #mobLeftExtend do
						player:swingTarget(mobLeftExtend[i])
					end
				end

				if (#mobUpLeftExtend > 0) then
					for i = 1, #mobUpLeftExtend do
						player:swingTarget(mobUpLeftExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end
			end

			if (not (#mobRight > 0)) and (player.backstab) then
				if (#mobRightExtend > 0) then
					for i = 1, #mobRightExtend do
						player:swingTarget(mobRightExtend[i])
					end
				end

				if (#mobUpRightExtend > 0) then
					for i = 1, #mobUpRightExtend do
						player:swingTarget(mobUpRightExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#mobDown > 0)) and (player.flank) then
				if (#mobDownExtend > 0) then
					for i = 1, #mobDownExtend do
						player:swingTarget(mobDownExtend[i])
					end
				end

				if (#mobDownLeftExtend > 0) then
					for i = 1, #mobDownLeftExtend do
						player:swingTarget(mobDownLeftExtend[i])
					end
				end

				if (#mobDownRightExtend > 0) then
					for i = 1, #mobDownRightExtend do
						player:swingTarget(mobDownRightExtend[i])
					end
				end
			end

			if (not (#pcUp > 0)) and (player.flank) then
				if (#pcUpExtend > 0) then
					for i = 1, #pcUpExtend do
						if (player:canPK(pcUpExtend[i])) then
							player:swingTarget(pcUpExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end
			end

			if (not (#pcLeft > 0)) then
				if (#pcLeftExtend > 0) then
					for i = 1, #pcLeftExtend do
						if (player:canPK(pcLeftExtend[i])) then
							player:swingTarget(pcLeftExtend[i])
						end
					end
				end

				if (#pcUpLeftExtend > 0) then
					for i = 1, #pcUpLeftExtend do
						if (player:canPK(pcUpLeftExtend[i])) then
							player:swingTarget(pcUpLeftExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end
			end

			if (not (#pcRight > 0)) and (player.backstab) then
				if (#pcRightExtend > 0) then
					for i = 1, #pcRightExtend do
						if (player:canPK(pcRightExtend[i])) then
							player:swingTarget(pcRightExtend[i])
						end
					end
				end

				if (#pcUpRightExtend > 0) then
					for i = 1, #pcUpRightExtend do
						if (player:canPK(pcUpRightExtend[i])) then
							player:swingTarget(pcUpRightExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end

			if (not (#pcDown > 0)) and (player.flank) then
				if (#pcDownExtend > 0) then
					for i = 1, #pcDownExtend do
						if (player:canPK(pcDownExtend[i])) then
							player:swingTarget(pcDownExtend[i])
						end
					end
				end

				if (#pcDownLeftExtend > 0) then
					for i = 1, #pcDownLeftExtend do
						if (player:canPK(pcDownLeftExtend[i])) then
							player:swingTarget(pcDownLeftExtend[i])
						end
					end
				end

				if (#pcDownRightExtend > 0) then
					for i = 1, #pcDownRightExtend do
						if (player:canPK(pcDownRightExtend[i])) then
							player:swingTarget(pcDownRightExtend[i])
						end
					end
				end
			end
		end

		if (#mobUp > 0 and player.flank) then -- if (#mobUp > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobUp do
				player:swingTarget(mobUp[i])
			end
		end

		if (#mobDown > 0 and player.flank) then -- if (#mobDown > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #mobDown do
				player:swingTarget(mobDown[i])
			end
		end

		if (#mobRight > 0 and player.backstab) then
			for i = 1, #mobRight do
				player:swingTarget(mobRight[i])
			end
		end

		if (#pcUp > 0 and player.flank) then -- if (#pcUp > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcUp do
				if (player:canPK(pcUp[i])) then
					player:swingTarget(pcUp[i])
				end
			end
		end

		if (#pcDown > 0 and player.flank) then -- if (#pcDown > 0) and (player.flank) and (math.random(0,1) == 0) then
			for i = 1, #pcDown do
				if (player:canPK(pcDown[i])) then
					player:swingTarget(pcDown[i])
				end
			end
		end

		if (#pcRight > 0 and player.backstab) then
			for i = 1, #pcRight do
				if (player:canPK(pcRight[i])) then
					player:swingTarget(pcRight[i])
				end
			end
		end
	end
	if player.class == 31 and player:hasDuration("enchant_blade") then
		local strikeChance = 0
		local paraChance = 0
		local shieldGain = math.ceil(player.maxMagic * 0.05)
		local shieldChance = 0
		local shieldCap = math.ceil(player.maxMagic * 0.50)
		if(player.rage >= 8) then
			paraChance = math.random(1,18)
		end
		if(player.rage >= 14) then
			strikeChance = math.random(1,18)
		end
		if(player.rage >= 20) then
			paraChance = math.random(1,12)
		end
		if(player.rage >= 26) then
			strikeChance = math.random(1,8)
		end
		if(player.rage >= 36) then
			shieldChance = math.random(1,4)
		end
		if(player.rage >= 81) then
			local randchan = math.random(1,40)
			if randchan == 1 then
				local hfCost = 100000
				if player.magic >= hfCost then
					local mapstruck = player:getObjectsInArea(BL_MOB)
					--local struck
					local struck = {}
					local hit
					if mapstruck ~= nil then
						if #mapstruck > 0 then
							for i=1, #mapstruck do
								--if(distance(player,mapstruck[i] < 8)) then
								if (distance(player,mapstruck[i]) < 8) then
									table.insert(struck,mapstruck[i])
								end
							end
							if #struck > 0 then --new check
								for p=1, #struck do
									if struck[p].isBoss == 1 then
										hit = struck[p]
										break--when it finds a boss, stop looking for other mobs
									end
									hit = struck[math.random(1,#struck)]
								end
							end
						end
					end
					if hit ~= nil then
						player.magic = player.magic - hfCost
						local hfDamage = math.ceil((player.maxHealth * 0.42) + (player.maxMagic * 1.69))
						player:throw(hit.x,hit.y, 1268, 1, 1)
						hit:sendAnimation(591)
						hit.attacker = player.ID
						hit:removeHealthExtend(hfDamage, 1, 1, 1, 1, 0)
						player:addThreat(hit.ID, hfDamage)
						player:talk(2,"BEGONE HERETIC!")
						player:sendMinitext("Your sword bursts with magical energy.")
						player:calcStat()
					end
				else
					player:sendMinitext("You try to expend spirit, but lack the energy..")
				end
			end
		end
		if not player.backstab and not player.flank or not player.extendHit then
			local pc = getTargetFacing(player, BL_PC)
			local mob = getTargetFacing(player, BL_MOB)
			if mob ~= nil then
				if shieldChance == 1 then
					player.registry["energyShield"] = player.registry["energyShield"] + shieldGain
					if player.registry["energyShield"] >= shieldCap then
						player.registry["energyShield"] = shieldCap
					end
					player:guitext("Energy shield +" ..player.registry["energyShield"].. " ")
					player:sendAnimation(488)
				end
				if (paraChance == 1) and (mob.isBoss == 0) then
					paralyze_spellsword.cast(player, mob)
				end
				if strikeChance == 1 then
					enchantblade_zap.cast(player, mob)
				end
			end
			if pc ~= nil then
				if strikeChance == 1 then
					enchantblade_zap.cast(player, pc)
				end
			end
		else
			local flankTargets = {}
			local backstabTargets = {}
			if player.backstab then
				backstabTargets = getTargetsBackstab(player, BL_MOB)
			end
			if player.flank then
				flankTargets = getTargetsFlank(player, BL_MOB)
			end
			if #backstabTargets > 0 then
				for i = 1, #backstabTargets do
					if paraChance == 1 and backstabTargets[i].isBoss == 0 then
						paralyze_spellsword.cast(player, backstabTargets[i]) 
					end
					if strikeChance == 1 then
						enchantblade_zap.cast(player, backstabTargets[i])
					end
				end
			end
			if #flankTargets > 0 then
				for i = 1, #flankTargets do
					if paraChance == 1 and flankTargets[i].isBoss == 0 then
						paralyze_spellsword.cast(player, flankTargets[i])
					end
					if strikeChance == 1 then
						enchantblade_zap.cast(player, flankTargets[i])
					end
				end
			end
			if (#backstabTargets == 0) and (#flankTargets == 0) then
				local x = {-1, -1,  0,  0,  1,  1, -2,  2}
				local y = {-1,  1,  2, -2, -1,  1,  0,  0}
				for i=1, #x do
					local hit = player:getObjectsInCell(player.m, player.x+x[i], player.y+y[i], BL_MOB)
					for j=1, #hit do
						if(player.rage >= 8) then
							paraChance = math.random(1,18)
						end
						if(player.rage >= 14) then
							strikeChance = math.random(1,18)
						end
						if(player.rage >= 20) then
							paraChance = math.random(1,12)
						end
						if(player.rage >= 26) then
							strikeChance = math.random(1,8)
						end

						if strikeChance == 1 then enchantblade_zap.cast(player, hit[j]) end
						if (hit[j].isBoss == 0) and (paraChance == 1) then paralyze_spellsword.cast(player,hit[j]) end

					end
				end
			end
			if shieldChance == 1 then
				player.registry["energyShield"] = player.registry["energyShield"] + shieldGain
				if player.registry["energyShield"] >= shieldCap then
					player.registry["energyShield"] = shieldCap
				end
				player:guitext("Energy shield +" ..player.registry["energyShield"].. " ")
				player:sendAnimation(488)
			end
		end
	end
end
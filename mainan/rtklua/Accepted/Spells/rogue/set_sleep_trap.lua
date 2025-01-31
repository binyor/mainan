set_sleep_trap = {
	cast = function(player)
		local magic = 2500
		if not player:canCast(1, 1, 0) then
			return
		end

		if (player.magic < magic) then
			player:sendMinitext("You do not have enough mana.")
			return
		end
		if (player.pvp == 1) then
			player:setAether("set_sleep_trap", 20000)
		end

		player:addNPC(
			"SleepTrapNpc",
			player.m,
			player.x,
			player.y,
			2,
			0,
			0,
			player.ID
		)

		player.magic = player.magic - magic
		player:playSound(0)
		player:sendStatus()
		player:sendAction(6, 35)

		player:sendMinitext("You set a trap!")
	end,

	while_cast = function(player)
		player:talk(0,"wow!")
	end,

	requirements = function(player)
		local level = 99
		local items = {"fine_rabbit_meat", 0}
		local itemAmounts = {4, 550}
		local description = "Set a sleep trap."
		return level, items, itemAmounts, description
	end,

}


sleep_trap = {

	cast = function(block)
		local duration = 38000
		block:setDuration("sleep_trap",duration)
		block.sleep = 1.3
		block:playSound(739)
		block:sendStatus()
	end,
	
	while_cast = function(block)
		if block.sleep ~= 1 then
			block:sendAnimation(2)
			block:playSound(739)
		else
			block:setDuration("sleep_trap",0)
		end
	end,

	uncast = function(block)
		block.sleep = 1
		block:sendStatus()
	end,

}
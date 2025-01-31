botcheck = {
	init = function(player)
		local pc = player:getUsers()
		for i=1, #pc do
			if pc[i].gmLevel > 0 then
				pc[i]:msg(0,"[BOT CHECK]: "..player.name.." has begun a bot check.",pc[i].id)
			end
		end
		
		player.registry["botcheck"] = 2
		botcheck.cast(player)

		player:msg(0," ",player.id)
		player:msg(0," ",player.id)
		player:msg(0,"You have been selected for a random bot check. Please read the following carefully:",player.id)
		player:msg(0,"You are being checked for AFK hunting. If you do not reply you will be jailed.",player.id)
		player:msg(0,"You have 3 minutes to respond to the message. The prompt will appear in shortly.",player.id)
		player:msg(0,"During this time your character will be paralyzed but invulnerable.",player.id)
		player:msg(0,"If you fail the prompt three times, your character will be automatically jailed.",player.id)
		player:msg(0,"masukan huruf/kata2 TEPAT seperti yang tertulis di dalam tanda.",player.id)
		player:msg(0," ",player.id)
		player:msg(0,"============================ DO NOT LOG OUT ============================",player.id)
		player:msg(0,"                  If you log out you will be jailed!", player.id)
	end,

	cast = function(player)
		local keywords = {}
		keywords = {"pizzas", "suburban", "assuming", "obstinate", "foramens", "obstinate", "festinate", "partisan", "hanover", 
					"palled", "peacock", "maintain", "foeticide", "iodometry", "quondam", "spang", "blathers", "lapidify", 
					"threequel", "ineffable", "vale", "doddle", "squib", "scherzan", "culture", "legerity", "freshman", "headline",
					"civilian", "lose", "pierce", "ash", "second", "protect", "output", "slippery", "flex", "superior", "eye", "interface", "filter",
					"patience", "cutting", "treasurer", "thumb"}
			
		local keyword1 = keywords[math.random(1,#keywords)]
		local keyword2 = keywords[math.random(1,#keywords)]
		local keyword3 = keywords[math.random(1,#keywords)]
		local keyword4 = keywords[math.random(1,#keywords)]

		local checkString = keyword1.." "..keyword2.." "..keyword3.." "..keyword4
		player.registryString["botcheck_string"] = checkString

		player:setDuration("botcheck", 190000)
		for i=1, #player.group do
			if player.group[i] ~= player.id then
				Player(player.group[i]):msg(0,"[Three Kingdoms]: "..player.name.." is being bot checked. Please be patient while they respond.",Player(player.group[i]).id)
				Player(player.group[i]):msg(0,"[Three Kingdoms]: Don't worry, during this time you won't take damage.",Player(player.group[i]).id)
			end
			Player(player.group[i]):setDuration("botcheck_hb",195000)
			if (Player(player.group[i]):hasDuration("auto_swing") == true) then
				Player(player.group[i]).registry["bc_autoswing"] = 1
				Player(player.group[i]):setDuration("auto_swing",0)
			end
			Player(player.group[i]).paralyzed = true
			Player(player.group[i]):sendStatus()
		end
		
	end,
	
	while_cast = function(player)
		for i=1, #player.group do
			Player(player.group[i]).paralyzed = true
		end

		if player:getDuration("botcheck") == 180000 then
			botcheck.playerEntry(player)
		end
		if player:getDuration("botcheck") == 120000 then
			botcheck.playerEntry(player)
		end
		if player:getDuration("botcheck") == 60000 then
			botcheck.playerEntry(player)
		end
	end,

	playerEntry = async(function(player)
		local player_string = player.registryString["botcheck_string"]
		local player_entry = player:inputLetterCheck(player:inputSeq("Enter the following words EXACTLY as shown between the brackets: ["..player_string.."]","","",{},{})) -- Enter check

		if (string.lower(player_entry) == player_string) then -- Compare strings
			player.registry["botcheck"] = 1
			player:setDuration("botcheck",0)
		end
		
		player:freeAsync()
	end),

	uncast = function(player)

		for i=1, #player.group do
			Player(player.group[i]).paralyzed = false
			Player(player.group[i]):sendStatus()
			if (Player(player.group[i]).registry["bc_autoswing"] == 1) then
				auto_swing.cast(Player(player.group[i]))
				Player(player.group[i]).registry["bc_autoswing"] = 0
			end
		end

		if player.registry["botcheck"] == 2 then -- 2 = fail

			local notify
			local time_fixed = (os.date("%Y-%m-%d %X",time))

			notify = "A player has failed an AFK bot check.\n\nPlayer Name: "..player.name.."\nPlayer ID: "..player.id.."\nTime: "..time_fixed.."\nMap: "..player.m.." - "..player.mapTitle.."\n\n"
			local gms = {3, 20, 105, 722}
			for i=1,#gms do
				player:sendMail(getOfflineID(gms[i]), player.name.." failed AFK bot check", notify)
			end
			print("[BOT CHECK]: "..player.name.." has failed an AFK Bot Check.")
			
			local cell = math.random(1,4)
			local x, y
				if cell == 1 then -- NW corner
					x = math.random(1, 5)
					y = math.random(3, 6)
				elseif cell == 2 then -- NE corner
					x = math.random(11, 15)
					y = math.random(4, 6)
				elseif cell == 3 then -- SW corner
					x = math.random(1, 5)
					y = math.random(10, 11)
				else -- SE corner
					x = math.random(11, 15)
					y = math.random(10, 11)
				end

			player:warp(666, x, y)
			broadcast(-1, "[Three Kingdoms]: "..player.name.." was jailed for failing an AFK Bot Check.")
			player:popUp("<b>You have been jailed for failing to <b>complete the bot check.\n\nIn order to be released, you will need to contact a GM via Discord or n-mail.\nPlease reach out directly to Brutus.")
			player:flushDuration()
			player.registry["botcheck"] = 0
		end

		if player.registry["botcheck"] == 1 then -- 1 = pass
			
			player:msg(0,"=============================================================", player.ID)
			player:msg(0,"               Thank you for your cooperation.               ", player.ID)
			player:msg(0,"=============================================================", player.ID)

			for i=1, #player.group do
				Player(player.group[i]):setDuration("botcheck_hb",10000)
			end

			player.registry["botcheck"] = 0

			local gms = {3, 20, 105}
			local target = player.name
			for i=1,#gms do
				if Player(gms[i]) then
					player = Player(gms[i])
					player:msg(0,"[BOT CHECK]: "..target.." has passed the bot check." ,player.id)
				end
			end
		end

	end
}

botcheck_hb = {
	cast = function(player)
	end,

	while_cast = function(block)
	end,

	uncast = function(player)
		player.paralyzed = false
		player:sendStatus()
		player:updateState()
	end,

	requirements = function(player)
		local level = 85
		local items = {Item("acorn").id, Item("amber").id, 0}
		local itemAmounts = {100, 20, 5000}
		local desc = "Grants temporary immortality."
		return level, items, itemAmounts, desc
	end
}

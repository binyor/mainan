share_wisdom = {
	on_learn = function(player)
		if player:hasSpell("share_wisdom") then
			player:removeSpell("share_wisdom")
		end
		if player:hasSpell("mentors_wisdom") then
			player:removeSpell("mentors_wisdom")
		end
		if player:hasSpell("apprentices_wisdom") then
			player:removeSpell("apprentices_wisdom")
		end
		if player:hasSpell("adepts_wisdom") then
			player:removeSpell("adepts_wisdom")
		end
		if player:hasSpell("sages_wisdom") then
			player:removeSpell("sages_wisdom")
		end
	end,

	cast = async(function(player)
		local magic = 10
		local aethers = 900000

		-- 15 menit
		if (not player:canCast(0, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local text = player.question

		if (text ~= "" or text == nil) then
			broadcast(-1, "[" .. player.name .. "]: " .. text)
			player:setAether("share_wisdom", aethers)
			characterLog.sage(player, player.question)
		end

		player.magic = player.magic - magic
		player:sendStatus()
	end),

	requirements = function(player)
		local level = 50
		local item = {0}
		local amounts = {25000}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Mantra ini adalah yang pertama dari 5 tingkat kebijaksanaan yang dapat dicapai oleh Sage."
		return level, item, amounts, desc
	end
}

mentors_wisdom = {
	on_learn = function(player)
		if player:hasSpell("share_wisdom") then
			player:removeSpell("share_wisdom")
		end
		if player:hasSpell("mentors_wisdom") then
			player:removeSpell("mentors_wisdom")
		end
		if player:hasSpell("apprentices_wisdom") then
			player:removeSpell("apprentices_wisdom")
		end
		if player:hasSpell("adepts_wisdom") then
			player:removeSpell("adepts_wisdom")
		end
		if player:hasSpell("sages_wisdom") then
			player:removeSpell("sages_wisdom")
		end
	end,

	cast = async(function(player)
		local magic = 50
		local aethers = 600000

		-- 10 menit
		if (not player:canCast(0, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local text = player.question

		if (text ~= "" or text == nil) then
			broadcast(-1, "[" .. player.name .. "]: " .. text)
			player:setAether("mentors_wisdom", aethers)
			characterLog.sage(player, player.question)
		end

		player.magic = player.magic - magic
		player:sendStatus()
	end),

	requirements = function(player)
		local level = 90
		local item = {0}
		local amounts = {100000}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Mantra ini adalah yang kedua dari 5 tingkat kebijaksanaan yang dapat dicapai oleh Sage."
		return level, item, amounts, desc
	end
}

apprentices_wisdom = {
	on_learn = function(player)
		if player:hasSpell("share_wisdom") then
			player:removeSpell("share_wisdom")
		end
		if player:hasSpell("mentors_wisdom") then
			player:removeSpell("mentors_wisdom")
		end
		if player:hasSpell("apprentices_wisdom") then
			player:removeSpell("apprentices_wisdom")
		end
		if player:hasSpell("adepts_wisdom") then
			player:removeSpell("adepts_wisdom")
		end
		if player:hasSpell("sages_wisdom") then
			player:removeSpell("sages_wisdom")
		end
	end,

	cast = async(function(player)
		local magic = 100
		local aethers = 300000

		-- 5 menit
		if (not player:canCast(0, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local text = player.question

		if (text ~= "" or text == nil) then
			broadcast(-1, "[" .. player.name .. "]: " .. text)
			player:setAether("apprentices_wisdom", aethers)
			characterLog.sage(player, player.question)
		end

		player.magic = player.magic - magic
		player:sendStatus()
	end),

	requirements = function(player)
		local level = 90
		local item = {0}
		local amounts = {100000}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Mantra ini adalah yang ketiga dari 5 tingkat kebijaksanaan yang dapat dicapai oleh Sage."
		return level, item, amounts, desc
	end
}

adepts_wisdom = {
	on_learn = function(player)
		if player:hasSpell("share_wisdom") then
			player:removeSpell("share_wisdom")
		end
		if player:hasSpell("mentors_wisdom") then
			player:removeSpell("mentors_wisdom")
		end
		if player:hasSpell("apprentices_wisdom") then
			player:removeSpell("apprentices_wisdom")
		end
		if player:hasSpell("adepts_wisdom") then
			player:removeSpell("adepts_wisdom")
		end
		if player:hasSpell("sages_wisdom") then
			player:removeSpell("sages_wisdom")
		end
	end,

	cast = async(function(player)
		local magic = 250
		local aethers = 150000

		-- 2.5 menit
		if (not player:canCast(0, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local text = player.question

		if (text ~= "" or text == nil) then
			broadcast(-1, "[" .. player.name .. "]: " .. text)
			player:setAether("adepts_wisdom", aethers)
			characterLog.sage(player, player.question)
		end

		player.magic = player.magic - magic
		player:sendStatus()
	end),

	requirements = function(player)
		local level = 90
		local item = {0}
		local amounts = {100000}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Mantra ini adalah yang keempat dari 5 tingkat kebijaksanaan yang dapat dicapai oleh Sage."
		return level, item, amounts, desc
	end
}

sages_wisdom = {
	on_learn = function(player)
		if player:hasSpell("share_wisdom") then
			player:removeSpell("share_wisdom")
		end
		if player:hasSpell("mentors_wisdom") then
			player:removeSpell("mentors_wisdom")
		end
		if player:hasSpell("apprentices_wisdom") then
			player:removeSpell("apprentices_wisdom")
		end
		if player:hasSpell("adepts_wisdom") then
			player:removeSpell("adepts_wisdom")
		end
		if player:hasSpell("sages_wisdom") then
			player:removeSpell("sages_wisdom")
		end
	end,

	cast = async(function(player)
		local magic = 300
		local aethers = 60000

		-- 1 menit
		if (not player:canCast(0, 1, 0)) then
			return
		end
		if (player.magic < magic) then
			player:sendMinitext("Anda tidak memiliki cukup mana.")
			return
		end

		local text = player.question

		if (text ~= "" or text == nil) then
			broadcast(-1, "[" .. player.name .. "]: " .. text)
			player:setAether("sages_wisdom", aethers)
			characterLog.sage(player, player.question)
		end

		player.magic = player.magic - magic
		player:sendStatus()
	end),

	requirements = function(player)
		local level = 90
		local item = {0}
		local amounts = {100000}
		local txt = "Untuk mempelajari mantra ini, Anda harus membawakan saya:\n\n"
		for i = 1, #item do
			txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
		end

		local desc = "Mantra ini adalah yang terakhir dari 5 tingkat kebijaksanaan yang dapat dicapai oleh Sage."
		return level, item, amounts, desc
	end
}

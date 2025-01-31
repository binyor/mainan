local _showInsufficientExp = function(player, cost)
	player:sendMinitext("You do not understand enough of your true nature to unleash your potential any further. Please return when you possess at least " .. Tools.formatNumber(cost) .. " experience.")
end

local _calculateBaseStats = function(player)
	player:calcStat()
	player:sendStatus()
end

local _finalizeExpSale = function(player)
	player:sendAnimation(18)
	player:playSound(708)
	_calculateBaseStats(player)
end

local _awardBonuses = function(player, nextCost, iterations)
	local smallExpBonus = math.ceil(nextCost / 20)
	local bigExpBonus = math.ceil(nextCost / 10)

	local bonusExp = 0
	local bonusKarma = 0

	for _ = 1, iterations do
		local rand = math.random(100)

		if (rand == 1) then
			bonusExp = bonusExp + bigExpBonus
			bonusKarma = bonusKarma + 0.01
		elseif (rand > 95) then
			bonusExp = bonusExp + smallExpBonus
		end
	end

	if (bonusExp > 0) then
		player.exp = player.exp + bonusExp
		player:addKarma(bonusKarma)
		player:sendStatus()
		player:sendMinitext("Your training was very efficient. It cost you " .. Tools.formatNumber(bonusExp) .. " experience less than expected.")
	end
end

local _getVitaOrManaCost = function(currentValue, statIndex)
	local minimumCost = 20000000
	local calculatedCost = math.floor((currentValue * statIndex - 80000 * Config.expSellFactor1) / 20000) * 2000000 * Config.expSellFactor2 + 20000000
	local cost = math.max(minimumCost, calculatedCost)

	return cost
end

local _shadowVitaOrMana = function(player, statIndex, all, shadowCount)
	local reactions = {"Your body strengthens.", "Your mind strengthens."}

	local isMinor = player.level < 99
	local statValueCap = 0

	if (isMinor) then
		statValueCap = 20000 / statIndex
	end

	local shadowsPossible = 0
	local exp = player.exp
	local statInterval = 100 / statIndex
	local currentValue = player.baseHealth
	local statLabel = "Vitality"

	if (statIndex == 2) then
		currentValue = player.baseMagic
		statLabel = "Mana"
	end

	player.registry["base" .. statLabel] = currentValue
	_calculateBaseStats(player)

	local tempValue = currentValue
	local tempCost

	while (exp > 0) do
		local nextValue = tempValue + statInterval

		if (isMinor and nextValue > statValueCap) then
			break
		end

		tempCost = _getVitaOrManaCost(tempValue, statIndex)

		if (exp >= tempCost) then
			shadowsPossible = shadowsPossible + 1
		end

		exp = exp - tempCost
		tempValue = nextValue
	end

	if (shadowsPossible < 1) then
		if (isMinor and statValueCap - currentValue < statInterval) then
			player:sendMinitext("You have reached your limit for now, young one. Return to me when you have achieved the final insight.")
		else
			_showInsufficientExp(player, tempCost)
		end
		return
	end

	if all or shadowCount > shadowsPossible then
		shadowCount = shadowsPossible
	end

	if shadowCount <= 0 then
		return
	end

	local expCost = 0
	local newValue = currentValue

	for _ = 1, shadowCount do
		expCost = expCost + _getVitaOrManaCost(newValue, statIndex)
		newValue = newValue + statInterval
	end

	player.exp = player.exp - expCost
	player.registry["base" .. statLabel] = newValue

	if (statIndex == 1) then
		player.expSoldHealth = player.expSoldHealth + expCost
		player.baseHealth = newValue
	else
		player.expSoldMagic = player.expSoldMagic + expCost
		player.baseMagic = newValue
	end

	player:sendMinitext(reactions[statIndex])
	--characterLog.xpSellWrite(player, statLabel:lower(), statInterval, expCost)

	_finalizeExpSale(player)

	local nextCost = _getVitaOrManaCost(newValue, statIndex)
	_awardBonuses(player, nextCost, shadowCount)
end

local _shadowStat = function(player, statIndex, all, shadowCount)
	local smallReactions = {"Your muscles feel a surge.", "You feel more fluid.", "Your mind expands."}
	local bigReactions = {"Your muscles scream.", "Your nerves scream.", "Your mind screams."}
	local statLabels = {"Might", "Grace", "Will"}

	local statLabel = statLabels[statIndex]
	local baseStatValues = {player.baseMight, player.baseGrace, player.baseWill}
	local baseStatValue = baseStatValues[statIndex]

	player.registry["base" .. statLabel] = baseStatValue
	_calculateBaseStats(player)

	local maxShadowsPossible = math.floor(player.exp / 10000000)
	local maxShadowsAllowed = 130 - baseStatValue
	local maxShadows = math.min(maxShadowsPossible, maxShadowsAllowed)

	if all or shadowCount > maxShadows then
		shadowCount = maxShadows
	end

	if shadowCount <= 0 then
		return
	end

	local newStatValue = baseStatValue + shadowCount
	local expCost = shadowCount * 10000000

	player.exp = player.exp - expCost
	player.expSoldStats = player.expSoldStats + expCost
	player.registry["base" .. statLabel] = newStatValue

	if (statIndex == 1) then
		player.baseMight = newStatValue
	elseif (statIndex == 2) then
		player.baseGrace = newStatValue
	else
		player.baseWill = newStatValue
	end

	local reaction = smallReactions[statIndex]

	if (shadowCount > 9) then
		reaction = bigReactions[statIndex]
	end

	player:sendMinitext(reaction)
	--characterLog.xpSellWrite(player, statLabel:lower(), shadowCount, expCost)

	_finalizeExpSale(player)
	_awardBonuses(player, 10000000, shadowCount)
end

verbalScriptCheckXP = function(player, npc, speech)
	Tools.configureDialog(player, npc)

	local words = {}
	for word in speech:gmatch("[%w\'%-%[%]]+") do
		table.insert(words, word)
	end

	-- only support: I will sell xp for [all] {vita,mana,might,grace,will} [number <number>]
	if (words[1] ~= "i" or words[2] ~= "will" or words[3] ~= "sell" or words[4] ~= "xp" or words[5] ~= "for" ) then
		return
	end

	local all = words[6] == "all"

	local pos = 6
	if all then pos = 7 end

	local want = nil
	if words[pos] == "vita" then want = "vita" end

	if words[pos] == "mana" then want = "mana" end
	if words[pos] == "might" then want = "might" end
	if words[pos] == "grace" then want = "grace" end
	if words[pos] == "will" then want = "will" end

	-- Didn't match any of our wants
	if want == nil then
		return
	end

	pos = pos + 1

	local number = nil
	if words[pos] == "number" then
		pos = pos + 1
		number = tonumber(words[pos])
	end

	if not all and (number == nil or number == 0) then
		return
	end

	if want == "vita" then
		_shadowVitaOrMana(player, 1, all, number)
	elseif want == "mana" then
		_shadowVitaOrMana(player, 2, all, number)
	elseif want == "might" then
		_shadowStat(player, 1, all, number)
	elseif want == "grace" then
		_shadowStat(player, 2, all, number)
	elseif want == "will" then
		_shadowStat(player, 3, all, number)
	end
end
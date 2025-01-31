thunder_touch = {
	cast = function(mob, target)
		target:sendAnimation(4)
		target:playSound(8)
		target.attacker = mob.ID
		if target.blType == BL_PC then
			target:sendMinitext(mob.name .. " attacks you with Thunder touch spell.")
		end
		target:removeHealthExtend(6496, 1, 1, 1, 1, 0)
	end
}

thunder_touch_mage = {
	cast = function(mob, target)
		target:sendAnimation(195)
		target:playSound(8)
		target.attacker = mob.ID
		if target.blType == BL_PC then
			target:sendMinitext(mob.name .. " engulfs you in a swirling flame!")
		end
		local damage = round(target.maxHealth * .10)
		target:removeHealthExtend(damage, 1, 0, 0, 0, 0)
	end
}


thunder_touch_spellsword = {
	cast = function(mob, target)
		target:sendAnimation(592)
		target:playSound(8)
		target.attacker = mob.ID
		if target.blType == BL_PC then
			target:sendMinitext(mob.name .. " Void magic echoes in through your body.")
		end
		local damage = round(target.maxHealth * .05)
		target:removeHealthExtend(damage, 1, 0, 0, 0, 0)
	end
}

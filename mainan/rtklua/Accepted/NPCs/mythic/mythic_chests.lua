amounts = {1, 1, 1, 1, 1, 1, 20, 20}
chance = {100, 3000, 5000, 15000, 25000, 27500, 55000, 85000}
global_rare_item = "ice_garb"
global_rare_itemDesc = "Ice Garb"

function calculateXPBonus(player)
	if (player.level < 99) then
		local totalExpForNextLevel = getXPforLevel(player.baseClass, player.level)
		local totalExpForCurrentLevel = getXPforLevel(player.baseClass, player.level - 1)
		local tnl = totalExpForNextLevel - totalExpForCurrentLevel
		local expFactor = 1
		local expBonus = math.ceil(tnl * 0.10 * expFactor)

		expBonus = math.max(expBonus, 300)
		player:giveXP(expBonus)
	  else
		local expFactor = 1
		local expBonus = ExpSellerNpc.getVitaCost(player.baseHealth)
		expBonus = expBonus + ExpSellerNpc.getVitaCost(player.baseHealth + 100)
		expBonus = expBonus + ExpSellerNpc.getManaCost(player.baseMagic)
		expBonus = expBonus + ExpSellerNpc.getManaCost(player.baseMagic + 50)
		expBonus = math.ceil(expBonus * expFactor)
		expBonus = math.min(expBonus, 276000000)

		player:giveXP(expBonus)
	end
end

function rollForChestItem(player, items, itemsDesc)
	for i = 1, #chance do
		math.randomseed(os.time())
		local roll = math.random(1, 100000)	

		if roll <= chance[i] then
			local amt = math.random(1, amounts[i])
			player:addItem(items[i], amt)
			player:sendMinitext("You manage to open the treasure box!")
			player:talk(0,"Wow! I got ["..amt.."] "..itemsDesc[i].." from the chest!")
			calculateXPBonus(player)
			break
		elseif roll > 85000 then
			player:sendMinitext("The chest was empty.")
			break
		end
	end
end

Rooster1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"blue_rooster_mount",
			"cursed_ring",
			"key_to_heaven",
			"sen_glove",
			"whisper_bracelet",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Blue Rooster Mount",
			"Cursed Ring",
			"Key to Heaven",
			"Sen Glove",
			"Whisper Bracelet",
			"Yellow Amber",
			"Dark Amber"
		}

		rollForChestItem(player, items, itemsDesc)
	end
}

Rooster2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"white_chicken_mount",
			"corrupted_ring",
			"key_to_heaven",
			"sen_glove",
			"whisper_bracelet",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"White chicken mount",
			"Corrupted ring",
			"Key to Heaven",
			"Sen Glove",
			"Whisper Bracelet",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rooster3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"brown_chicken_mount",
			"forsaken_ring",
			"il_san_savage_gauntlet",
			"substratum_gauntlet",
			"key_to_heaven",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Brown chicken mount",
			"Forsaken ring",
			"Il san savage gauntlet",
			"Substratum gauntlet",
			"Key to Heaven",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Horse1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"armored_horse_saddle",
			"blood",
			"pal_mok",
			"titanium_glove",
			"holy_ring",
			"white_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Armored Horse Saddle",
			"Blood",
			"Pal Mok",
			"Titanium Glove",
			"Holy Ring",
			"White Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Horse2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 13
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"headless_horsemans_horse",
			"mythic_sabre",
			"shee_lee_ring",
			"stealth_glove",
			"titanium_glove",
			"white_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Headless Horseman Mount",
			"Mythic Sabre",
			"Shee Lee Ring",
			"Stealth Glove",
			"Titanium Glove",
			"White Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Horse3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 13
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_itemDesc,
			"mountain_goat_pan_flute",
			"flameblade",
			"il_san_savage_gauntlet",
			"il_san_stealth_glove",
			"titanium_glove",
			"white_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Unique mountain goat pan flute",
			"Flameblade",
			"Il san savage gauntlet",
			"Il San Stealth Glove",
			"Titanium Glove",
			"White Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rabbit1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"purple_stuffed_bunny",
			"bone",
			"key_to_earth",
			"ambrosia",
			"lucky_coin",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Purple Stuffed Bunny",
			"Bone",
			"Key to Earth",
			"Ambrosia",
			"Lucky Coin",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rabbit2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 23
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"midnight_cutlass",
			"magical_dust",
			"key_to_earth",
			"ambrosia",
			"steelthorn",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Midnight Cutlass",
			"Magical Dust",
			"Key to Earth",
			"Ambrosia",
			"Steel Thorn",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rabbit3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 23
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"midnight_cutlass",
			"sun_helm",
			"key_to_earth",
			"enchanted_crystal_ball",
			"enchanted_savage_gauntlet",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Midnight Cutlass",
			"Sun helm",
			"Key to Earth",
			"Enchanted crystal ball",
			"Enchanted savage gauntlet",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Monkey1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"random_mount_i",
			"scorched_bone",
			"key_to_fire",
			"ambrosia",
			"lucky_coin",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Random Mount I",
			"Scorched Bone",
			"Key to Fire",
			"Ambrosia",
			"Lucky Coin",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Monkey2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 45
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()

		local items = {
			global_rare_item,
			"lava_shades",
			"azure_diamond",
			"spike",
			"whisper_bracelet",
			"key_to_fire",
			"white_amber",
			"dark_amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"Lava Shades",
			"Azure Diamond",
			"Spike",
			"Whisper Bracelet",
			"Key to Fire",
			"White Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Monkey3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 45
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"lava_shades",
			"night_diamond",
			"spike",
			"enchanted_crystal_ball",
			"key_to_fire",
			"white_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Lava Shades",
			"Night Diamond",
			"Spike",
			"Enchanted Crystal Ball",
			"Key to Fire",
			"White Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dog1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"husky_mount",
			"scorched_bone",
			"key_to_wind",
			"fragile_rose",
			"cursed_blade",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Husky Mount",
			"Scorched Bone",
			"Key to Wind",
			"Fragile Rose",
			"Cursed Blade",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dog2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 77
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"forest_dragon_dog",
			"purified_water",
			"messengers_feather",
			"fragile_rose",
			"corrupted_blade",
			"dark_amber",
			"wool"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Forest Dragon Dog",
			"Purified Water",
			"Messenger's Feather",
			"Fragile Rose",
			"Corrupted Blade",
			"Dark Amber",
			"Wool"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dog3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 77
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"topaz_dragon_dog",
			"purified_water",
			"il_san_crystal_ball",
			"fragile_rose",
			"forsaken_blade",
			"dark_amber",
			"wool"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Unique Topaz Dragon Dog",
			"Purified Water",
			"Il-san Crystal Ball",
			"Fragile Rose",
			"Forsaken Blade",
			"Dark Amber",
			"Wool"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rat1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"black_bandito",
			"titanium_glove",
			"key_to_pond",
			"Battle_helm",
			"cursed_blade",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Black Bandito",
			"Titanium Glove",
			"Key to Pond",
			"Battle Helm",
			"Cursed Blade",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rat2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"white_bandito",
			"messengers_feather",
			"key_to_pond",
			"tao_stone",
			"cursed_staff",
			"dark_amber",
			"amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"White Bandito",
			"Messenger's Feather",
			"Key to Pond",
			"Tao Stone",
			"Cursed Staff",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Rat3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"black_turban",
			"il_san_soul_crystal",
			"key_to_pond",
			"battle_helm",
			"forsaken_staff",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Black Turban",
			"Il-san soul crystal",
			"Key to Pond",
			"Battle Helm",
			"Forsaken Staff",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Ox1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"red_bull_mount",
			"military_fork",
			"key_to_water",
			"tao_stone",
			"whisper_bracelet",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Red Bull Mount",
			"Military Fork",
			"Key to Water",
			"Tao Stone",
			"Whisper Bracelet",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Ox2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"white_bull_mount",
			"might_spear",
			"key_to_water",
			"messengers_feather",
			"whisper_bracelet",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"White Bull Mount",
			"Might spear",
			"Key to Water",
			"Messenger's Feather",
			"Whisper Bracelet",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Ox3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"blue_bull_mount",
			"stone_axe",
			"searing_diamond",
			"ee_san_savage_gauntlet",
			"ee_san_stealth_glove",
			"dark_amber",
			"amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Unique Blue Bull Mount",
			"Stone axe",
			"Searing Diamond",
			"Ee San Savage Gauntlet",
			"Ee san stealth glove",
			"Dark Amber",
			"Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Pig1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"pig_mount",
			"dark_staff",
			"key_to_mountain",
			"lucky_silver_coin",
			"magical_dust",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Pig Mount",
			"Dark Staff",
			"Key to Mountain",
			"Lucky Silver Coin",
			"Magic Dust",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Pig2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"brown_warthog_mount",
			"bright_staff",
			"key_to_mountain",
			"lucky_silver_coin",
			"magical_dust",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Brown Warthog Mount",
			"Bright Staff",
			"Key to Mountain",
			"Lucky Silver Coin",
			"Magic Dust",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Pig3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"black_pig_mount",
			"crystal_staff",
			"key_to_mountain",
			"cerise_diamond",
			"crimson_diamond",
			"yellow_amber",
			"dark_amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"Unique Black pig mount",
			"Crystal Staff",
			"Key to Mountain",
			"Cerise Diamond",
			"Crimson Diamond",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Snake1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"white_snake_mount",
			"enchanted_charm",
			"hyun_moo_key",
			"charm",
			"scribes_book",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"White Snake Mount",
			"Enchanted Charm",
			"Hyun moo Key",
			"Charm",
			"Scribe's Book",
			"Yellow Amber",
			"Dark Amber"
		}
	rollForChestItem(player, items, itemsDesc)
	end
}

Snake2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"black_snake_mount",
			"il_san_charm",
			"hyun_moo_key",
			"charm",
			"scribes_book",
			"yellow_amber",
			"dark_amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"Black Snake Mount",
			"Il san charm",
			"Hyun moo key",
			"Charm",
			"Scribe's Book",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Snake3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"purple_snake_mount",
			"lucent_diamond",
			"ee_san_crystal_ball",
			"il_san_charm",
			"charm",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Unique Purple Snake Mount",
			"Lucent Diamond",
			"Ee san crystal ball",
			"Il san charm",
			"Charm",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Sheep1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"yearn_blade",
			"enchanted_surge",
			"ju_jak_key",
			"surge",
			"lucky_silver_coin",
			"yellow_amber",
			"dark_amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"Yearn Blade",
			"Enchanted Surge",
			"Ju jak Key",
			"Surge",
			"Lucky Silver Coin",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Sheep2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"yearn_blade",
			"il_san_surge",
			"ju_jak_key",
			"surge",
			"lucky_silver_coin",
			"yellow_amber",
			"dark_amber"
		}

		local itemsDesc = {
			global_rare_itemDesc,
			"Yearn Blade",
			"Il san surge",
			"Ju jak Key",
			"Surge",
			"Lucky Silver Coin",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Sheep3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"yearn_blade",			
			"radiant_diamond",
			"ee_san_savage_gauntlet",
			"surge",
			"lucky_silver_coin",
			"yellow_amber",
			"dark_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Yearn Blade",
			"Radiant Diamond",
			"Ee san savage gauntlet",
			"Surge",
			"Lucky Silver Coin",
			"Yellow Amber",
			"Dark Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Tiger1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"tiger_blitz",
			"enchanted_blood",
			"baekho_key",
			"blood",
			"purified_water",
			"yellow_amber",
			"white_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Tiger Blitz",
			"Enchanted Blood",
			"Baekho Key",
			"Blood",
			"Purified Water",
			"Yellow Amber",
			"White Amber"
		}	
		rollForChestItem(player, items, itemsDesc)
	end
}

Tiger2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"tiger_blitz",
			"shade_diamond",
			"il_san_blood",
			"blood",
			"purified_water",
			"yellow_amber",
			"white_amber",
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Tiger Blitz",
			"Shade Diamond",
			"Il san blood",
			"Blood",
			"Purified Water",
			"Yellow Amber",
			"White Amber",
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Tiger3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"tiger_blitz",
			"torrid_diamond",
			"ee_san_stealth_glove",
			"blood",
			"purified_water",
			"yellow_amber",
			"white_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Tiger Blitz",
			"Torrid Diamond",
			"Ee san stealth glove",
			"Blood",
			"Purified Water",
			"Yellow Amber",
			"White Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dragon2chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"festive_dragon_mount",
			"crimson_diamond",
			"Il_san_spike",
			"spike",
			"dragons_liver",
			"yellow_amber",
			"white_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Festive dragon mount",
			"Crimson Diamond",
			"Il san spike",
			"Spike",
			"Dragon's Liver",
			"Yellow Amber",
			"White Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dragon1chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"brown_firetail_mount",
			"enchanted_spike",
			"chung_ryong_key",
			"spike",
			"dragons_liver",
			"yellow_amber",
			"white_amber"
		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Brown Firetail Mount",
			"Enchanted Spike",
			"Chung Ryong Key",
			"Spike",
			"Dragon's Liver",
			"Yellow Amber",
			"White Amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

Dragon3chest = {
	on_spawn = function(npc)
		npc.subType = 0
		npc.look = 154
		npc.lookColor = 3
		npc.side = 2
		npc:sendSide()
	end,

	action = function(npc)
		npc.side = 2
		npc:sendSide()
	end,

	open = function(player, npc)
		npc.side = 1
		npc:sendSide()
		local items = {
			global_rare_item,
			"festive_dragon_mount",
			"searing_diamond",
			"ee_san_savage_gauntlet",
			"ee_san_stealth_glove",
			"ee_san_crystal_ball",
			"yellow_amber",
			"white_amber"

		}
		local itemsDesc = {
			global_rare_itemDesc,
			"Unique Festive dragon mount",
			"Searing Diamond",
			"Ee san savage gauntlet",
			"Ee san Stealth glove",
			"Ee san Crystal ball",
			"Yellow amber",
			"White amber"
		}
		rollForChestItem(player, items, itemsDesc)
	end
}

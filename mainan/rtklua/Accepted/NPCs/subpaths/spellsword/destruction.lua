destruction = {
	click = async(function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
        local opts = {}
		if player.class == 31 and not player:hasSpell("enchant_blade") and player.level >= 75 then
			table.insert(opts, "Learn Enchant Blade")
		end
		if player.class == 1 and player.quest["subpath_trials"] == 0 then --player.quest["subpath_trials"] = 31
			table.insert(opts, "Are you Destruction?")
		end
		if player.level >= 99 and player.class == 31 then
			table.insert(opts, "Forge weapon")
		end
		if player.class == 31 then
			table.insert(opts, "Leave subpath")
		end

		if player.quest["subpath_trials"] == 31 then
			if player.registry["sstrial"] == 1 then
				table.insert(opts, "Trial of Unity")
			end

			if player.registry["sstrial"] == 2 then
				table.insert(opts, "Trial of Intelligence")
			end

			if player.registry["sstrial"] == 3 then
				table.insert(opts, "Trial of Cleansing")
			end

			if player.registry["sstrial"] == 4 then
				table.insert(opts, "Trial of Creation")
			end


			table.insert(opts, "Abandon Trials")
		end


		local menu = player:menuString("You were able to withstand my portal, impressive. What is it you want?", opts)

		if menu == "Leave subpath" then
            local confirm1 = player:menuString("Your spirit will take a hit. Are you SURE you want to abandon subapth?",{"Yes","No"})
            if confirm1 == "Yes" then
                local SSSpells = {"enchant_blade"}
                for i = 1, #SSSpells do
                    player:removeSpell(SSSpells[i])
                end
                player:removeLegendbyName("spellsword_joined_mark")
                player:removeKarma(4.0)
                player:updatePath(player.baseClass, player.mark)
                player:dialogSeq({t,"It is done."},0)
            end
        end

		if menu == "Are you Destruction?" then
			local opts1 = {}
			table.insert(opts1,"That's exactly what I want.")
			table.insert(opts1,"No, sorry.")
			local begintrial = player:menuString("You even know who I am? You must want to forge a spellsword..",opts1)

			if begintrial == "That's exactly what I want." then
				player.quest["subpath_trials"] = 31
				player.registry["sstrial"] = 1
				player:dialogSeq({t,"Very well."},1)
			end
		end


		if menu == "Trial of Unity" then
			player:dialogSeq({t,"There are many ways to destroy an enemy.","A weapon as dark and wide as the sky.","A weapon as electric as lightning striking the earth.","A weapon as mysterious as the moon","Return to me when you have these and we can proceed."},1)
			if(player:hasItem("maxcaliber",1) == true and player:hasItem("moonblade",1) == true and player:hasItem("electra",1) == true) then
				player.registry["sstrial"] = 2
				player:removeItem("maxcaliber",1)
				player:removeItem("moonblade",1)
				player:removeItem("electra",1)
				player:dialogSeq({t,"Fantastically done, let's continue."},1)
			end
		end


		if menu == "Trial of Intelligence" then
			player:dialogSeq({t,"Now that we have those, I need you to locate lost tomes of a brilliant scribe. Four of them should do."},1)
			if(player:hasItem("scribes_book",4) == true) then
				player.registry["sstrial"] = 3
				player:removeItem("scribes_book",4)
				player:dialogSeq({t,"Already? That was quick. Good job."},1)
			end
		end

		if menu == "Trial of Cleansing" then
			if(player.registry["oncleansing"] == 1) then
				player:dialogSeq({t,"Kugnae's beach has waters known to have cleansing properties.","Take this and dip it into the water and return. I will be waiting."},0)
			end
			player:dialogSeq({t,"I have crudely extracted and combined the materials into this dormant sword.","Thanks to that book, I understood how to do so correctly.","Now we need to cleanse this weapon in pereparation for the next step.","Kugnae's beach has waters known to have cleansing properties.","Take this and dip it into the water and return. I will be waiting."},1)
			player:addItem("crude_spellsword",1)
			player.registry["oncleansing"] = 1
		end

		if menu == "Trial of Creation" then
			player:dialogSeq({t,"Masterfully done. It is ready.","I've located a source of large energy coming from a small, dormant cave outside of buya.","They seem to be alone and forgotten.","Take the sword there and slay the enemy within."},1)
			if (player.registry["sstrialkk"] == 1) then
				player:dialogSeq({t,"No longer do I sense the energy of a magic user. And I see the sword has captured their essence.","You've been a great asset. Welcome aboard."},1)
				player:addLegend("Discovered lineage of the Spellsword (" .. curT() .. ")","spellsword_joined_mark",71,1)
				player:updatePath(31, player.mark)
				player:sendAnimation(5,0)
				broadcast(-1,"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!")
				player:removeItem("crude_spellsword",1)
				player.registry["sstrialkk"] = 0
				player.registry["sstrial"] = 0
				player.registry["sstrialspawn"] = 0
				player.quest["subpath_trials"] = 0
			end
		end



		if menu == "Learn Enchant Blade" then
			player:dialogSeq({t,"This ability is the very essence of a Spellsword. It enables you to empower your weapon.","The cost is high, though. It will require:","1 Ice sabre. 1 Flamefang. 1 Spike. 1 Frozen spear. 1 Dark dagger.","60 Yellow ambers. 100 Dark ambers.","Press next ONLY if you have all items necessary."},1)
			if(player:hasItem("ice_sabre",1) == true and player:hasItem("flamefang",1) == true and player:hasItem("spike",1) == true and player:hasItem("frozen_spear",1) == true and player:hasItem("dark_dagger",1) == true and player:hasItem("yellow_amber",60) == true and player:hasItem("dark_amber",100) == true) then
				player:removeItem("ice_sabre",1)
				player:removeItem("flamefang",1)
				player:removeItem("spike",1)
				player:removeItem("frozen_spear",1)
				player:removeItem("dark_dagger",1)
				player:removeItem("dark_amber",100)
				player:removeItem("yellow_amber",60)
				player:addSpell("enchant_blade")
				player:sendMinitext("Enchant Blade learned!")
				player:sendAnimation(598,10)
			end
		end
		

		if menu == "Forge weapon" then
			opts2 = {}
			table.insert(opts2,"Spellsword (25000)")
			if((player.maxHealth >= 80000) or (player.maxMagic >= 40000)) then
				table.insert(opts2,"Enchanted Spellsword (50000)")
			end
			if(player.mark >= 1) then
				table.insert(opts2,"Il-san Spellsword (100000)")
			end
			if(player.mark >= 2) then
				table.insert(opts2, "EE-san Spellsword (200000)")
            end
			local weapselect = player:menuString("Which type of sword can you handle?", opts2)

			if weapselect == "Spellsword (25000)" then
				if player.money >= 25000 then
					player:removeGold(25000)
					player:addItem("spellsword",1,0,player.ID)
					player:sendAnimation(598,10)
				end
			end

			if weapselect == "Enchanted Spellsword (50000)" then
				if player.money >= 50000 then
					player:removeGold(50000)
					player:addItem("enchanted_spell_sword",1,0,player.ID)
					player:sendAnimation(598,10)
				end
			end


			if weapselect == "Il-san Spellsword (100000)" then
				if player.money >= 100000 then
					player:removeGold(100000)
					player:addItem("il_san_spell_sword",1,0,player.ID)
					player:sendAnimation(598,10)
				end
			end



			if weapselect == "Ee-san Spellsword (200000)" then
				if player.money >= 200000 then
					player:removeGold(200000)
					player:addItem("ee_san_spell_sword",1,0,player.ID)
					player:sendAnimation(598,10)
				end
			end





		end


		if menu == "Abandon Trials" then
			player:dialogSeq({t,"Hit next only if you are SURE YOU WISH TO ABANDON YOUR TRIALS."},1)
			player.registry["sstrial"] = 0
			player.quest["subpath_trials"] = 0
		end

	end)
}
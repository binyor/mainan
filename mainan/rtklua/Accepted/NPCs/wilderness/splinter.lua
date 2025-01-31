local _waypointId = "splinter"

SplinterNpc = {
	click = async(function(player, npc)
		Tools.configureDialog(player, npc)

		local opts = {
			"Buy",
			"Sell",
			"Crafting Skills",
			"Gathering Wood",
			"Don't Knock Woodworking",
			"Woodworking Devotion"
		}

		if (not Waypoint.isEnabled(player, _waypointId)) then
			table.insert(opts, "Waypoint")
		end
		if (player.registry["hunterq"] == 4) then
			table.insert(opts,"Can you teach me how to build a cabin?")
		end
		if (player.registry["hunterq"] == 5) then
			table.insert(opts,"First stack of wood")
		end
		if (player.registry["hunterq"] == 6) then
			table.insert(opts,"Second stack of wood")
		end
		if (player.registry["hunterq"] == 7) then
			table.insert(opts,"Third stack of wood")
		end
		if (player.registry["hunterq"] == 8) then
			table.insert(opts,"Fourth stack of wood")
		end
		if (player.registry["hunterq"] == 9) then
			table.insert(opts,"Fifth stack of wood")
		end
		if (player.registry["hunterq"] == 10) then
			table.insert(opts,"I have the seaweed and metal")
		end
		if (player.registry["hunterq"] == 11) then
			table.insert(opts,"Time to PARTAY!")
		end
		if player.registry["bardq"] == 2 then
			player:dialogSeq({"Ah I'm glad you made it. Sadly my tools are broken, I'll need your help. Luckily for you, I'm not going to give it as a riddle.",
			"Gather me a blade from the nine tailed fox. I'll also need something to keep things tight. a sen glove should work.",
			"And finally, I'll need you to bring me 100 ambers, as a woodworker's life isn't as rich as those gemcutters!"},1)
			if (player:hasItem("sen_glove", 1) == true and player:hasItem("amber", 100) == true and player:hasItem("fox_blade", 1) == true) then
				player:removeItem("sen_glove",1)
				player:removeItem("amber",100)
				player:removeItem("fox_blade",1)
				player.registry["bardq"] = 3
				player:setDuration("SplinterQuest", 3600000)
				player:dialogSeq({"Fantastic! please come back in a few hours. In the mean time, you should go see if Seong has anything else for you."} , 0)
			end
		end

		if player.registry["bardq"] == 4 then
			player.registry["bardq"] = 5
			player:addItem("perfect_cliath",1)
			player:dialogSeq({"Hello! You've timed this nicely, I've just put the finishing touches on this!","Please let Seong know that I can't make any more for a while.",1})
		end

		if player.registry["bardq"] == 14 then
			player.registry["bardq"] = 15
			player:dialogSeq({"Oh a feast? I'll show up, but on one condition.","There's a woman in Kaming who I really adore.","Confirm her invitation and I'll surely come along too."},0)
		end
		if player.registry["bardq"] == 15 then
			player:dialogSeq({"Oh a feast? I'll show up, but on one condition.","There's a woman in Kaming who I really adore.","Confirm her invitation and I'll surely come along too."},1)
		end

		if player.registry["bardq"] == 19 then
			player.registry["bardq"] = 20
			player:dialogSeq({"She said she'll come!?","Woo-hoo! Thank you! You won't regret it!"},1)
		end
		











		local menu = player:menuString(
			"Hello! What would you like to do today?",
			opts
		)

		if menu == "Buy" then
			player:buyExtend(
				"I think I can accomodate some of the things you need. What would you like?",
				SplinterNpc.buyItems()
			)
		elseif menu == "Sell" then
			player:sellExtend(
				"What are you willing to sell today?",
				SplinterNpc.sellItems()
			)
		elseif menu == "Crafting Skills" then
			generalNPC.crafting_skills(player, npc)
		elseif menu == "Gathering Wood" then
			player:dialogSeq(
				{
					"Yup, I know about that. Go to a place with trees and hack at 'em with your axe.",
					"Sometimes you'll find stuff. You should find a 'grove' to cut lumber in. There are a few around in the different forests.",
					"For example, there's one near Buya at 46, 20 and one near Kugnae at 111, 178. I doubt you'll have much luck lumbering outside of the groves."
				},
				0
			)
			return
		elseif menu == "Don't Knock Woodworking" then
			player:dialogSeq(
				{
					"A fine skill. Sure, you can make any armor, or those so-called 'superior' metal weapons. But we woodworkers are much more versatile.",
					"Woodworking allows you to make wooden weapons and arrows. Also, woodworking is needed to make weaving tools. When you're ready, just tell me 'wood'.",
					"If you do poor work, you'll end up with wood scraps. Show them to me, ask me about 'scraps' and we'll see what we can salvage."
				},
				0
			)
			return
		elseif menu == "Woodworking Devotion" then
			SplinterNpc.woodworkingDevotion(player, npc)
		elseif menu == "Waypoint" then
			Waypoint.add(player, npc, _waypointId)


		elseif menu == "Can you teach me how to build a cabin?" then
			player:dialogSeq({"Well, hoooowdy! Sure I can. Especially 'cuz I smell Artemis' on ya.","First bring me some ginko wood.. Five full stacks is the perfect amount for a cabin."},0)
			player.registry["hunterq"] = 5


		elseif menu == "First stack of wood" then
			if(player:hasItem("ginko_wood",100) == true) then
				player:removeItem("ginko_wood",100)
				player.registry["hunterq"] = 6
				player:dialogSeq({"*She takes the wood from you*","400 to go!"},0)
			else
				player:dialogSeq({"..Where's the wood?"},0)
			end



		elseif menu == "Second stack of wood" then
			if(player:hasItem("ginko_wood",100) == true) then
				player:removeItem("ginko_wood",100)
				player.registry["hunterq"] = 7
				player:dialogSeq({"*She takes the wood from you*","300 to go!"},0)
			else
				player:dialogSeq({"..Where's the wood?"},0)
			end

		elseif menu == "Third stack of wood" then
			if(player:hasItem("ginko_wood",100) == true) then
				player:removeItem("ginko_wood",100)
				player.registry["hunterq"] = 8
				player:dialogSeq({"*She takes the wood from you*","200 to go!"},0)
			else
				player:dialogSeq({"..Where's the wood?"},0)
			end
		
		elseif menu == "Fourth stack of wood" then
			if(player:hasItem("ginko_wood",100) == true) then
				player:removeItem("ginko_wood",100)
				player.registry["hunterq"] = 9
				player:dialogSeq({"*She takes the wood from you*","100 to go!"},0)
			else
				player:dialogSeq({"..Where's the wood?"},0)
			end

		elseif menu == "Fifth stack of wood" then
			if(player:hasItem("ginko_wood",100) == true) then
				player:removeItem("ginko_wood",100)
				player.registry["hunterq"] = 10
				player:dialogSeq({"*She takes the wood from you*","You did it!","Next, we'll need some bindings. A full stack of seaweed should do.","Finally, a full stack of metal, half that of fine.","Bring me those things and we can finish reinforcing the cabin."},0)
				player:sendAnimation(270)
			else
				player:dialogSeq({"..Where's the wood?"},0)
			end

		elseif menu == "I have the seaweed and metal" then
			if((player:hasItem("seaweed",20) == true) and (player:hasItem("metal",100) == true) and (player:hasItem("fine_metal",50) == true)) then
				player:removeItem("seaweed",20)
				player:removeItem("metal",100)
				player:removeItem("fine_metal",50)
				player.registry["hunterq"] = 11
				player:dialogSeq({t,"*you both string the weed tightly around the joints of the structure*","*the metal acts as reinforcement for the base structure*","Know what's left?","A celebration!","Get us 10 hot-hot coals and 2 bottles of aged wine, and we can get this party STARTED!~"},0)
				player:sendAnimation(270)
			else
				player:dialogSeq({t,"A full stack of seaweed should do. You also need that metal and fine..."},0)
			end

		elseif menu == "Time to PARTAY!" then
			if ((player:hasItem("aged_wine",2) == true) and (player:hasItem("hot_coal",10) == true)) then
				player:removeItem("aged_wine",2)
				player:removeItem("hot_coal",10)
				player.registry["hunterq"] = 12
				player:dialogSeq({"WOOOHOOOO~","*over the next few hours, you and Splinter manage through both bottles*","I-i-I-I-'m pretty h-h-h-ic-ha-appy ye liv out h-here now, " ..player.name ,"YOU'RE SUCH A GOOD FRIEND!!! *sobs*","*Splinter passes out on his carpet*","(Guess I should go see Artemis now)"},0)
				player:sendAnimation(2)
			else
				player:dialogSeq({t,"Where's the aged wine & coal?"},0)
			end



		end



















	end),

	woodworkingDevotion = function(player, npc)
		Tools.configureDialog(player, npc)

		if (player.level < 25) then
			player:dialogSeq({"You are not ready to devote to a craft yet, come back later."}, 0)
			return
		end

		if crafting.checkSkillLegend(player, "woodworking") then
			player:dialogSeq({"You have already devoted yourself to the study of Woodworking."}, 0)
			return
		end

		crafting.checkSkill(player, npc, "jewelry making")
		crafting.checkSkill(player, npc, "tailoring")
		crafting.checkSkill(player, npc, "metalworking")

		player:dialogSeq({"Woodworkers can make wooden weapons, bows, arrows, and weaving tools. Do you wish to become a woodworker?"}, 1)

		crafting.addSkill(player, npc, "woodworking")
	end,

	buyItems = function()
		local buyItems = {"axe"}
		return buyItems
	end,

	sellItems = function()
		local sellItems = {
			"axe",
			"ginko_wood",
			"weaving_tools",
			"fine_weaving_tools",
			"spring_quiver",
			"summer_quiver",
			"wooden_sword",
			"viperhead_woodsaber",
			"viperhead_woodsword",
			"wooden_blade",
			"supple_wooden_sword",
			"supple_viperhead_woodsaber",
			"supple_viperhead_woodsword",
			"supple_wooden_blade",
			"oaken_sword",
			"supple_oaken_sword",
			"oaken_blade",
			"supple_oaken_blade"
		}
		return sellItems
	end,

	onSayClick = async(function(player, npc)
		Tools.configureDialog(player, npc)
		local speech = string.lower(player.speech)

		if speech == "wood" or speech == "scrap" or speech == "scraps" then
			crafting.craftingDialog(player, npc, speech)
		end

		if (speech == "waypoint" and not Waypoint.isEnabled(player, _waypointId)) then
			Waypoint.add(player, npc, _waypointId)
			return
		end
	end),
}

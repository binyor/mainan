artemis = {
    click = async(function(player, npc)
        local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
        player.npcGraphic = t.graphic
        player.npcColor = t.color
        player.dialogType = 0
        player.lastClick = npc.ID
        local opts = {}
        local hunteropts = {}

        if (player.class ~= 2) and (player.class ~= 24) then
            player:dialogSeq({t,"Welcome to my home, city-dweller.",0})
        end

        if (player.quest["subpath_trials"] == 0) then
            table.insert(opts, "I'm interested in joining the hunters.")
        end

        if (player.class == 24) then
            table.insert(hunteropts,"Just checkin' in on you, brother.")

            if player.level >= 70 then
                table.insert(hunteropts,"Artemis' Bow")
            end

            if ((player.maxHealth >= 80000) or (player.maxMagic >= 40000)) then
                table.insert(hunteropts,"Enchanted Artemis' Bow")
            end

            if player.mark >= 1 then
                table.insert(hunteropts,"Il san Artemis' Bow")
            end

            if player.mark >= 2 then
                table.insert(hunteropts,"Ee san Artemis' Bow")
            end

            if player:hasSpell("volatile_shot") == false then
                if player.level >= 99 then
                    table.insert(hunteropts,"Learn Volatile Shot")
                end
            end
            if player:hasSpell("artemiss_blessing") == false then
                if player.level >= 90 then
                    table.insert(hunteropts,"Learn Artemis' Blessing")
                end
            end
            if player:hasSpell("set_snare_trap_row") == false then
                if player.level >= 75 then
                    table.insert(hunteropts,"Learn Set Snare Trap Row")
                end
            end
            if player:hasSpell("set_flash_trap_row") == false then
                if player.level >= 75 then
                    table.insert(hunteropts,"Learn Set Flash Trap Row")
                end
            end
            if player:hasSpell("hunters_mark") == false then
                if player.level >= 75 then
                    table.insert(hunteropts,"Hunter's Mark")
                end
            end
            table.insert(hunteropts,"Leave subpath")
        end

        -- ================HUNTER TRIAL 1
        if ((player.class == 2) and (player.quest["subpath_trials"] == 0)) then                 -- for the first hunter trial only.
            local trialsmenu = player:menuString("Welcome to our home, friend. What can I help you with?", opts)
            if trialsmenu == "I'm interested in joining the hunters." then
                if (player.country ~= 0) then
                    player:dialogSeq({t,"Seek out the old man in rags and vow to live in the wild. Only then may you continue.",0})
                else
                    player.quest["subpath_trials"] = 24
                    player.registry["hunterq"] = 1
                    player:dialogSeq({t,"I see you've made your vow, well done.",0})
                end
            end
        end


        --     ======================HUNTER SPELLS


        if (player.class == 24) then
            local huntermenu = player:menuString("Good seeing you, brother. What can I do for you?",hunteropts)
            if huntermenu == "Learn Volatile Shot" then
                player:dialogSeq({t,"This cunning maneuver launches a feisty arrow at the weakpoint of your target. Might hit their allies too.","This costs two whisper bracelets, two steelthorns, and 25,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
                if((player:hasItem("whisper_bracelet",2) == true) and (player:hasItem("steelthorn",2) == true) and (player.money >= 25000)) then
                    player:removeItem("whisper_bracelet",2)
                    player:removeItem("steelthorn",2)
                    player:removeGold(50000)
                    player:addSpell("volatile_shot")
                else
                    player:dialogSeq({t,"You don't have those items.."},0)
                end
            end

            if huntermenu == "Learn Artemis' Blessing" then
                player:dialogSeq({t,"This spell calls upon all our ancestors and grants us their blessing of the wild.","This costs 2 dark daggers, 4 hunang's axes, 2 steelthorns, 2 whisper bracelets, 100 ambers, and 20k.","Hit next ONLY if you have the required items and wish to learn."},1)
                if((player:hasItem("dark_dagger",2)) == true and (player:hasItem("hunangs_axe",4) == true) and (player:hasItem("steelthorn",2) == true) and (player:hasItem("whisper_bracelet",2) ==true) and (player:hasItem("amber",100) ==true) and (player.money >= 20000)) then
                    player:removeItem("dark_dagger",2)
                    player:removeItem("hunangs_axe",4)
                    player:removeItem("steelthorn",2)
                    player:removeItem("whisper_bracelet",2)
                    player:removeItem("amber",100)
                    player:removeGold(20000)
                    player:addSpell("artemiss_blessing")
                else
                    player:dialogSeq({t,"You don't have those items.."},0)
                end
            end

            if huntermenu == "Learn Set Snare Trap Row" then
                player:dialogSeq({t,"This advanced trap lets you lay them to your sides as well.","This costs half a stack of fine rabbit meat and 10k.","Hit next ONLY if you have the required items and wish to learn."},1)
                if((player:hasItem("fine_rabbit_meat",1)) == true and (player.money >= 10000)) then
                    player:removeItem("fine_rabbit_meat",2)
                    player:removeGold(10000)
                    player:addSpell("set_snare_trap_row")
                else
                    player:dialogSeq({t,"You don't have those items.."},0)
                end
            end

            if huntermenu == "Learn Set Flash Trap Row" then
                player:dialogSeq({t,"This advanced trap lets you lay them to your sides as well.","This costs five gold acorns, 20 broiled meat, and 20 fried eggs. Animals *loooove* fried eggs.","Hit next ONLY if you have the required items and wish to learn."},1)
                if((player:hasItem("gold_acorn",5)) == true and (player:hasItem("fried_egg",20) == true) and (player:hasItem("broiled_meat",20) == true)) then
                    player:removeItem("gold_acorn",5)
                    player:removeItem("fried_egg",20)
                    player:removeItem("broiled_meat",20)
                    player:addSpell("set_flash_trap_row")
                else
                    player:dialogSeq({t,"You don't have those items.."},0)
                end
            end

            if huntermenu == "Hunter's Mark" then
                player:dialogSeq({t,"I've taught ya how to kill rabbits, now I'll teach ya how to do it with precision.","This costs ten amethysts, ten gold acorns, and 10,000 gold.","Hit next ONLY if you have the required items and wish to learn."},1)
                if((player:hasItem("amethyst",10)) == true and (player:hasItem("gold_acorn",10)) == true and (player.money >= 10000)) then
                    player:removeItem("amethyst",10)
                    player:removeItem("gold_acorn",10)
                    player:removeGold(10000)
                    player:addSpell("hunters_mark")
                else
                    player:dialogSeq({t,"You don't have those items.."},0)
                end
            end

            if huntermenu == "Artemis' Bow" then
                player:dialogSeq({t,"Of course I can forge my bow for ya.","To create it, it'll take a stack of wool, a stack of ginko wood, a stack of ambers, a stack of dark ambers...","And why don'tcha bring 10 tiger meat for chow? For the pack!","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("ginko_wood",100) == true) and (player:hasItem("wool",100) == true) and (player:hasItem("amber",100) == true) and (player:hasItem("tiger_meat",10) == true) and (player:hasItem("dark_amber",100) == true)) then
                    player:dialogSeq({t,"*Artemis effortlessly weaves metal and wool around the bow, as if he were playing an instrument*","Here's your weapon, bro. Be safe out there."},1)
                    player:removeItem("ginko_wood",100)
                    player:removeItem("wool",100)
                    player:removeItem("amber",100)
                    player:removeItem("dark_amber",100)
                    player:removeItem("tiger_meat",10)
                    player:addItem("wilderness_bow",1,0,player.ID)
                else
                    player:dialogSeq({t,"Where's the stuff?"},0)
                end
            end

            if huntermenu == "Enchanted Artemis' Bow" then
                player:dialogSeq({t,"Of course I can forge my bow for ya.","To create it, it'll take a stack of wool, a stack of ginko wood, a stack of ambers, a stack of dark ambers...","And why don'tcha bring 50 tiger meat for chow? For the pack!","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("ginko_wood",100) == true) and (player:hasItem("wool",100) == true) and (player:hasItem("amber",100) == true) and (player:hasItem("tiger_meat",50) == true) and (player:hasItem("dark_amber",100) == true)) then
                    player:dialogSeq({t,"*Artemis effortlessly weaves metal and wool around the bow, as if he were playing an instrument*","Here's your weapon, bro. Be safe out there."},1)
                    player:removeItem("ginko_wood",100)
                    player:removeItem("wool",100)
                    player:removeItem("amber",100)
                    player:removeItem("dark_amber",100)
                    player:removeItem("tiger_meat",50)
                    player:addItem("enchanted_wilderness_bow",1,0,player.ID)
                else
                    player:dialogSeq({t,"Where's the stuff?"},0)
                end
            end

            if huntermenu == "Il san Artemis' Bow" then
                player:dialogSeq({t,"Of course I can forge my bow for ya.","To create it, it'll take a stack of wool, a stack of ginko wood, a stack of ambers, a stack of dark ambers...","And why don'tcha bring a stack of tiger meat for chow? For the pack!","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("ginko_wood",100) == true) and (player:hasItem("wool",100) == true) and (player:hasItem("amber",100) == true) and (player:hasItem("tiger_meat",100) == true) and (player:hasItem("dark_amber",100) == true)) then
                    player:dialogSeq({t,"*Artemis effortlessly weaves metal and wool around the bow, as if he were playing an instrument*","Here's your weapon, bro. Be safe out there."},1)
                    player:removeItem("ginko_wood",100)
                    player:removeItem("wool",100)
                    player:removeItem("amber",100)
                    player:removeItem("dark_amber",100)
                    player:removeItem("tiger_meat",100)
                    player:addItem("il_san_wilderness_bow",1,0,player.ID)
                else
                    player:dialogSeq({t,"Where's the stuff?"},0)
                end
            end

            if huntermenu == "Ee san Artemis' Bow" then
                player:dialogSeq({t,"Of course I can forge my bow for ya.","To create it, it'll take a stack of wool, a stack of ginko wood, a stack of ambers, a stack of dark ambers, 100k...","And why don'tcha bring a stack of tiger meat for chow? For the pack!","Press next ONLY if you wish to continue."},1)
                if ((player:hasItem("ginko_wood",100) == true) and (player:hasItem("wool",100) == true) and (player:hasItem("amber",100) == true) and (player:hasItem("tiger_meat",100) == true) and (player:hasItem("dark_amber",100) == true) and (player.money >= 100000)) then
                    player:dialogSeq({t,"*Artemis effortlessly weaves metal and wool around the bow, as if he were playing an instrument*","Here's your weapon, bro. Be safe out there."},1)
                    player:removeItem("ginko_wood",100)
                    player:removeItem("wool",100)
                    player:removeItem("amber",100)
                    player:removeItem("dark_amber",100)
                    player:removeItem("tiger_meat",100)
                    player:removeGold(100000)
                    player:addItem("ee_san_wilderness_bow",1,0,player.ID)
                else
                    player:dialogSeq({t,"Where's the stuff?"},0)
                end
            end

            if huntermenu == "Leave subpath" then
                local confirm1 = player:menuString("Your spirit will take a hit. Are you SURE you want to abandon subapth?",{"Yes","No"})
                if confirm1 == "Yes" then
                    local hunterSpells = {"hunters_mark","set_snare_trap_row","set_blind_trap_row","volatile_shot"}
                    for i = 1, #hunterSpells do
                        player:removeSpell(hunterSpells[i])
                    end
                    player:removeLegendbyName("hunter_joined_mark")
                    player:removeKarma(4.0)
                    player:updatePath(player.baseClass, player.mark)
                    player:dialogSeq({t,"It is done."},0)
                end
            end


        end







        --      ===================HUNTER TRIALS 2+
        if ((player.class == 2) and (player.quest["subpath_trials"] == 24)) then

            if (player.registry["hunterq"] == 1) then
                player:dialogSeq({t,"It's going to get cold tonight.","My friend Yon lives nearby, she can help get you some warm clothes.",0})
            end

            if (player.registry["hunterq"] == 2) then
                player.registry["hunterq"] = 3
                player:dialogSeq({t,"Lookin' warmmmm, brother.","But you won't be for long on an empty stomach.","Fishing is an invaluable skill that all hunter's oughta know.",1})
            end

            if (player.registry["hunterq"] == 3) then
                if((player:hasItem("tiny_fish",100) == true) and (player:hasItem("small_fish",100) == true) and (player:hasItem("scrawny_fish",100) == true) and (player:hasItem("magical_fish",1) == true) and (crafting.checkSkillLevel(player, "fishing", "adept"))) then
                    player:removeItem("tiny_fish",100)
                    player:removeItem("small_fish",100)
                    player:removeItem("scrawny_fish",100)
                    player:removeItem("magical_fish",1)
                    player.registry["hunterq"] = 4
                    player:dialogSeq({t,"That'll help feed the pack for days! Err, you. Good fishin', "..player.name,0})
                else
                    player:dialogSeq({t,"I need a couple hundred fish for the pack. Bring me some variety, will ya? They're picky.",0})
                end
            end

            if (player.registry["hunterq"] == 4) then
                player:dialogSeq({t,"Now that you're self-sustainable, it couldn't hurt to learn some cabin-buildin' techniques.","In the southern part of the wild, you'll find a carpenter named Splinter.","They have a... way with wood. Have him show you the basics.",0})
            end

            if (player.registry["hunterq"] == 12) then
                player.registry["hunterq"] = 13
                player:dialogSeq({t,"And then Splinter threw up on you!? Oh man, that sounds like him alright.","Glad you had fun, but hope you're not TOO hungover.","Next you must learn to perfect your shot.","*he gestures southwards*","There's a course over there to to help master your technique."},0)
            end

            if (player.registry["hunterq"] == 13) then
                if(player.registry["rabbit_invasion_highest_score"] >= 5000) then
                    player.registry["hunterq"] = 14
                    player:dialogSeq({t,"Woooaw, you're a real sharp-shooter!"},0)
                else
                    player:dialogSeq({t,"Come see me again once you've gotten a score of 5000 or higher."},0)
                end
            end

            if (player.registry["hunterq"] == 14) then
                player:dialogSeq({t,"Listen carefully, "..player.name, "This hunt is quite dangerous, we're on the lookout for a rare panther spotted recently..","You'll need your traps handy to help weaken it.","*PRESS NEXT ONLY IF YOU'RE READY TO FIGHT*","WOAH, what's that!?"},1)
                npc:spawn(820, 14, 6, 1, 3619)
                local panth = npc:getObjectsInCell(3619, 14,6, BL_MOB)
                for i=1, #panth do
                    if panth[i].yname == "hunter_panther" then
                        panth[i].owner = player.ID
                        panth[i].target = panth[i].owner
                    end
                end
            end
            
            if (player.registry["hunterq"] == 15) then
                player:dialogSeq({t,"That was some of the finest trapping I've ever seen, "..player.name..".","You've done more than enough to share a home with us.","Welcome to the pack, "..player.name},1)
                player:addLegend("Walked into the Wild (" .. curT() .. ")","hunter_joined_mark",212,224)
                player:updatePath(24, player.mark)
                broadcast(-1,"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!")
                player:sendAnimation(5,0)
                player:sendAnimation(241)
                player:sendAnimation(242)
                player:sendAnimation(243)
                player:sendAnimation(244)
                player.registry["hunterq"] = 0
                player.quest["subpath_trials"] = 0
                player:warp(3619, 17, 13)
                npc:spawn(821, 15, 11, 1, 3619)
                npc:spawn(821, 14, 13, 1, 3619)
                npc:spawn(821, 15, 15, 1, 3619)
                npc:spawn(821, 17, 16, 1, 3619)
                npc:spawn(821, 19, 15, 1, 3619)
                npc:spawn(821, 20, 13, 1, 3619)
                npc:spawn(821, 19, 11, 1, 3619)
                npc:spawn(821, 17, 10, 1, 3619)
            end
        end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    end)
}
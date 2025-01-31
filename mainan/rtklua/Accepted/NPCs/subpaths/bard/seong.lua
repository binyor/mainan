seong = {
	click = async(function(player, npc)
		local t = {graphic = convertGraphic(npc.look, "monster"),color = npc.lookColor}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID
        local opts = {}
		if player.class == 32 and not player:hasSpell("sonata_of_songh") then
			table.insert(opts, "Sonata of Songh (50000)")
        end
        if player.class == 32 and not player:hasSpell("ballad_of_speed") then
            table.insert(opts, "Ballad of Speed (75000)")
        end
		if player.class == 4 and player.quest["subpath_trials"] == 0 then
			table.insert(opts, "Yes, you've piqued my interest!")
        end
		if player.class == 4 and player.quest["subpath_trials"] == 0 then
			table.insert(opts, "I have no need to listen to this matter.")
		end

		if player.quest["subpath_trials"] == 32 then
			table.insert(opts, "Abandon Trials")
		end
		if player.level >= 99 and player.class == 32 then
			table.insert(opts, "Cliath (25000)")
		end
		if (player.maxHealth >= 80000 or player.maxMagic >= 40000) and player.class == 32 then
			table.insert(opts, "Enchanted Cliath (50000)")
		end
		if player.mark >= 1 and player.class == 32 then
			table.insert(opts, "Il-san Cliath (100000)")
        end
        if player.mark >= 2 and player.class == 32 then
			table.insert(opts, "Ee-san Cliath (200000)")
        end
        if player.class == 32 then
            table.insert(opts, "Leave subpath")
        end
        if player.registry["bardq"] == 1 then
            table.insert(opts, "Trial 1")
        end

        if player.registry["bardq"] == 2 then
            player:dialogSeq({t, "Out in the wilderness lives a person with skills immense, with those crafty hands, they'll turn our ideas into sense~",0})
            return
        end


        if player.registry["bardq"] == 4 then
            player:dialogSeq({t, "Still waiting on Splinter? Have some of our tales to read~",1})
            player:addItem("tales_of_the_bard_board",1)
        end
    

        if (player:hasItem("perfect_cliath",1) == true and player.registry["bardq"] == 5) then
            player:dialogSeq({t, "Well done, you're on your way, you've done what we've asked, Such heroism can never not be rewarded for what you were tasked~"},1)
            player:removeItem("perfect_cliath",1)
            player.registry["bardq"] = 6
        end

        if(player.registry["bardq"] == 6) then
            player:dialogSeq({t, "Welcome back, it seems you're still eager, The next task you'll see, won't be so meagre.","It seems we're running a little short on our supply, We'll need five of each from where literary bosses lie."},1)
            if(player:hasItem("scribes_pen", 5) == true and player:hasItem("scribes_book",5) == true) then
                player:removeItem("scribes_pen",5)
                player:removeItem("scribes_book",5)
                player.registry["bardq"] = 7
                player:dialogSeq(t,"Thank you for your efforts, I'm sure you're tired, But there are still more things that are required.","We'll need some more, but those ones aren't tough. Seek the messenger, but don't fall for his bluff~",1)
            end
        end

        if(player.registry["bardq"] == 7) then
            player:dialogSeq({t,"We'll need some more, but those ones aren't tough. Seek the messenger, but don't fall for his bluff~"},1)
            return
        end

        if(player.registry["bardq"] == 8) then
            player:dialogSeq({t,"Welcome back, have you brought back our ink? Oh, I see you fell for his little hoodwink~","Nevertheless, he'll have it done soon, Atleast this time, it wasn't a spoon!","For now you can head over to the mountain peak, there's a man there who would like to speak.","Bring him back home, as we'll need his skill, Lucky for us, no tests are needed for his quill."},1)
        end

        if(player.registry["bardq"] == 9) then
            player:dialogSeq({t,"Hoh hoh hoh. How foolish I might look, but it's in the journey that you took.","I'm sure by now, the ink is complete. So lift up those legs and move those feet!"},1)
        end

        if(player.registry["bardq"] == 10) then
            player.registry["bardq"] = 11
            player:removeItem("barrel_of_ink",1)
            player:dialogSeq({t,"Fantastic! You're really showing your hard work, You're even putting up with my rambling quirk!"},1)
        end

        if(player.registry["bardq"] == 11) then
            player:dialogSeq({t,"Looks like you're back for more, or so it would seem, We're putting on a feast so we'll need meats and bream.","With a hiss, an oink, a neigh, a cluck, and a bellow, Gather a score of these foods and share with our fellow~"},1)
            if(player:hasItem("snake_meat", 20) == true and player:hasItem("horse_meat",20) == true and player:hasItem("rare_pork",20) == true and player:hasItem("beef",20) == true) then
                player.registry["bardq"] = 12
                player:removeItem("snake_meat",20)
                player:removeItem("horse_meat",20)
                player:removeItem("rare_pork",20)
                player:removeItem("beef",20)
                player:dialogSeq({t,"Great, this should fill our gusts up quite well. Now headover to calm waters without any swell."},1)
            end
        end

        if(player.registry["bardq"] == 12) then
            player:dialogSeq({t,"Our guests require the most savoury of trawl, Head on over and bring us back a haul~"},1)
            if(player:hasItem("tasty_fish",25) == true) then
                player.registry["bardq"] = 13
                player:removeItem("tasty_fish",25)
                player:dialogSeq({t,"Great! these fish should bring everyone joy, It's a shame there weren't any koi.."},1)
            end
        end


        if(player.registry["bardq"] == 13) then
            player:dialogSeq({t,"Now for something with a little more teeth. Head into the wilderness and seek underneath.","Gather me a tenfold of meat from a beast that roards, But be sure to take an extra clean pair of drawers!!"},1)
            if(player:hasItem("tiger_meat",10) == true) then
                player:removeItem("tiger_meat",10)
                player.registry["bardq"] = 14
                player:dialogSeq({t,"You've come back and smelling as fresh as ever! I'm glad that you've decided to fund our endeavour.","First visit those who you've already met. No need to climb the mountain"},0)
            end
        end

        if(player.registry["bardq"] == 14) then
            player:dialogSeq({t,"You've come back and smelling as fresh as ever! I'm glad that you've decided to fund our endeavour.","First visit those who you've already met. No need to climb the mountain"},1)
        end


        if player.registry["bardq"] == 20 then
            player.registry["bardq"] = 21
            player:dialogSeq({t,"Our guest list has exploded and it's all thanks to you, There's just one final task I would like you to do.","We're going to need something to wash it all down. Five of each, that's old and costly. Just make sure that it's brown~"},0)
        end

        if player.registry["bardq"] == 21 then
            player:dialogSeq({t,"Our guest list has exploded and it's all thanks to you, There's just one final task I would like you to do.","We're going to need something to wash it all down. Five of each, that's old and costly. Just make sure that it's brown~"},1)
            if(player:hasItem("aged_wine",5) == true and player:hasItem("rich_wine",5) == true) then
                player:dialogSeq({t,"At last, the final piece and the feast can begin! The time for celebration with our beloved kin!"},1)
                player:removeItem("aged_wine",5)
                player:removeItem("rich_wine",5)
                player.registry["bardq"] = 22
                player:warp(3994, 15, 9)
                local boss = player:getObjectsInMap(3994,BL_MOB)
                for i=1, #boss do
                    boss[i]:delete()
                end
                npc:spawn(808, 14, 5,1,3994)
            end
        end


        if player.registry["bardq"] == 55 then
            player:dialogSeq({t,"Thank you so much, you really helped us out there, It was a really close call with little blood to spare.","You've shown us all that you belong with us here, With your compassinon and sheer course of will to endear."},1)
            player:addLegend("Ascended through versification (" .. curT() .. ")","bard_joined_mark",96,15)
            player:updatePath(32, player.mark)
            broadcast(-1,"[SUBPATH]: Congratulations to our newest " .. player.classNameMark .. " " .. player.name .. "!")
            player:sendAnimation(5,0)
            player.registry["bardq"] = 0
            player.quest["subpath_trials"] = 0
        end


        local menu = player:menuString("Greetings my friend, it seems you've stumbled upon our little hideaway! Should you wish to find out more, we're gonna have to see a display!", opts)
        
        if menu == "Leave subpath" then
            local confirm1 = player:menuString("Your spirit will take a hit. Are you SURE you want to abandon subapth?",{"Yes","No"})
            if confirm1 == "Yes" then
                local bardSpells = {"sonata_of_songh","ballad_of_speed"}
                for i = 1, #bardSpells do
                    player:removeSpell(bardSpells[i])
                end
                player:removeLegendbyName("bard_joined_mark")
                player:removeKarma(4.0)
                player:updatePath(player.baseClass, player.mark)
                player:dialogSeq({t,"It is done."},0)
            end
        end

        if menu == "Enchanted Cliath (50000)" then
            if player.money >= 50000 then
                player:removeGold(50000)
                player:addItem("enchanted_cliath",1,0,player.ID)
                player:sendAnimation(5,0)
            end
        end

        if menu == "Ee-san Cliath (200000)" then
            if player.money >= 200000 then
                player:removeGold(200000)
                player:addItem("ee_san_cliath",1,0,player.ID)
                player:sendAnimation(5,0)
            end
        end




        if menu == "Il-san Cliath (100000)" then
            if player.money >= 100000 then
                player:removeGold(100000)
                player:addItem("il_san_cliath",1,0,player.ID)
                player:sendAnimation(5,0)
            end
        end


        if menu == "Cliath (25000)" then
            if player.money >= 25000 then
                player:removeGold(25000)
                player:addItem("cliath",1,0,player.ID)
                player:sendAnimation(5,0)
            end
        end

        if menu == "Ballad of Speed (75000)" then
            if player.money >= 75000 then
                player:removeGold(75000)
                player:addSpell("ballad_of_speed")
                player:sendMinitext("Ballad of Speed learned!")
            end
        end

        if menu == "Sonata of Songh (50000)" then
            if player.money >= 50000 then
                player:removeGold(50000)
                player:addSpell("sonata_of_songh")
                player:sendMinitext("Sonata of Songh learned!")
            end
        end
        if menu == "Yes, you've piqued my interest!" then
            player.quest["subpath_trials"] = 32
            player.registry["bardq"] = 1
            player:dialogSeq({t, "First thing's first, the thing we need from you falls from these, Strong and sturdy, 100 pieces should do, just watch out for bees!",1})
            end


        if menu == "I have no need to listen to this matter." then
        end


        if menu == "Trial 1" then
            if player:hasItem("ginko_wood", 100) == true then
                player:removeItem("ginko_wood", 90)
                player.registry["bardq"] = 2
                player:dialogSeq({t, "Great! You've successfully figured it out, congratulations! But now comes the next task, can you fulfill the expectations?","Out in the wilderness lives a person with skills immense, with those crafty hands, they'll turn our ideas into sense~",1})
            else
                player:dialogSeq({t, "First thing's first, the thing we need from you falls from these, Strong and sturdy, 100 pieces should do, just watch out for bees!",1})
            end
        end





    end)
}




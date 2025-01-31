twofactor = {
    uncast = function(player)
        twofactorauth.input(player)
    end,

    duration = function(player)
    end,

}

twofactorauth = {
    input = async(function(player)
        local sha = require("sha2")
		local t = {graphic = convertGraphic(19, "item"), color = 0}
        player.npcGraphic = t.graphic													 
        player.npcColor = t.color														
        player.dialogType = 0
        local counter = 0
        local auth = player.registryString["twofactor_key"]
		local time = player.registryString["twofactor_time"]
        
        repeat
            local check = player:inputSeq("Enter your Pin:","","",{},{})
                check = player.id..check..time
				check = sha.sha256(check)
				if (check == auth) then
                    player:flushDurationNoUncast(13, 13)
                    print("[PIN]: "..player.name.." passed PIN prompt.")
                    return
                end
                counter=counter+1
        until counter == 3

        twofactorauth.uncast(player)

    end),

    uncast = function(player)
        if player.gmLevel > 0 then
            print("[PIN]: Disconnected "..player.name.." from "..player.ipaddress.." | Reason: Failed GM PIN")
            player:disconnect()
        else
            print("[PIN]: Disconnected "..player.name.." from "..player.ipaddress.." | Reason: Failed PIN")
            player:disconnect()
        end
    end,
}
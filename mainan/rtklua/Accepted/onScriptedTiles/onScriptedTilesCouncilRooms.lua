onScriptedTilesCouncilRooms = function(player)

  local mapName = player.mapTitle
  local m = player.m
  local x = player.x
  local y = player.y
  local clanID = player.clan
  local clanRank = player.clanRank

----- Clans Council Rooms -----

----- Cartel Clan -----
  if m == 5066 then
    if (x == 23 or x == 24) and y == 27 then
      if clanID == 25 and clanRank >= 3 then
          player:warp(5068, 8, 13)
      else 
        player:sendMinitext("You lack sufficient rank to enter.")
        player:warp(m,x,y+1)
      end
    end
  end
end
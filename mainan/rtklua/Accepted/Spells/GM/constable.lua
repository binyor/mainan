constable_ally = {
    cast = function(player)
      if player.m ~= 666 then 
        player:warp(666,8,8)
      else
        player:warp(38, 9, 1)
      end    
    end
}
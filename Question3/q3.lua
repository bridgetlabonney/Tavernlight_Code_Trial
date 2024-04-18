--[[ original code

function do_sth_with_PlayerParty(playerId, membername)

player = Player(playerId)

local party = player:getParty()

 

for k,v in pairs(party:getMembers()) do

    if v == Player(membername) then

        party:removeMember(Player(membername))

    end

end

end


]]--

--[[ explanation

    This looks like its supposed to remove party members matching the member name.

    I had to dig through OTClient's source code agan to see how I could get the info of a player.
    It looks like Player() can work for both name and ID so no need to fix that part, 

    Edits:
    - removed unnessecary lines
    - added check for player 
]]--

function removePartyMember(playerID, membername) 

    for k,v in pairs(Player(playerID).getParty().getMembers()) do
        if Player(membername) ~= nil and v == Player(membername) then

            party:removeMember(Player(membername))
    
        end
    
    end 


end
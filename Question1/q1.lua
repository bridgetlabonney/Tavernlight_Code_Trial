--[[ original code
local function releaseStorage(player)

player:setStorageValue(1000, -1)

end

 
function onLogout(player)

if player:getStorageValue(1000) == 1 then

addEvent(releaseStorage, 1000, player)

end

return true

end

--]]

--[[ explanation

This code appears to "release" the storage of the player on logout. If they have storage, 
(getStorageValue returns 1), add the event of releaseStorage where you set the storage value to -1.

I assume the (1000) being passed to each function is a wait time which is also using
addEvent (or is just another required value, but I do not want to change parameters!)

Since we have access to get/set in the onLogout, why not cut out the helper function all together?
    
Edits:

- removed an unneeded function and replaced it in the onLogout function.
]]--

function onLogout(player)
    if player:getStorageValue(1000) == 1 then 
        addEvent(player:setStorageValue, 1000, 1000, -1) 
    end
    return true
end
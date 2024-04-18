--[[ original code
function printSmallGuildNames(memberCount)

-- this method is supposed to print names of all guilds that have less than memberCount max members

local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

local guildName = result.getString("name")

print(guildName)

end]]--

--[[ explanation

    Taking a look at OTClient's source code, queries work a little different in this than what I'm used to!

    I had to figure out some lua stuff (repeat until, specifically, which is just a do while) to do this.

    There was some general issues, such as saving lines at the beginning of the function (so many useless local variables)
    And according to the source code, the getString would not work! There was also a glaring issue related to the print() as
    it would only print out one of the results, when there could be several.

    Edits:
    - removed unneeded lines
    - fixed query -- according to what I've seen some '' need to be added around each item
    - added checking if query returned anything
    - added result.free
    - fixed result.getString call, as it was missing the resultID
    - fixed priting issue
    ]]--
    
function printSmallGuildNames(memberCount) 

   local resultId = db.storeQuery(string.format("SELECT 'name' FROM 'guilds' WHERE 'max_members' < %d;", memberCount))
   if resultId ~= false then
    repeat
    print(result.getString(resultId, "name"))
    until result.next(resultId) == false
   end

   result.free(resultId)
   return true
end
    
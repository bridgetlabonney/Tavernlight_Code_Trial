/*original code
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)

{

Player* player = g_game.getPlayerByName(recipient);

if (!player) {

player = new Player(nullptr);

if (!IOLoginData::loadPlayerByName(player, recipient)) {

return;

}

}

 

Item* item = Item::CreateItem(itemId);

if (!item) {

    return;

}

 

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

 

if (player->isOffline()) {

    IOLoginData::savePlayer(player);

}

} */

/* explanation

OTClient's coding guide says to never use pointers/delete if you can help it, so 
I wondered if I could replace the pointer, thus fixing the memory leak. After reading through more source
code and the coding guide, I realized you can just use smart pointers to fix the memory leak issues!

*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)

{

std::unique_ptr<Player> player = g_game.getPlayerByName(recipient);

if (!player) {

player = std::make_unique<Player>(nullptr); 

if (!IOLoginData::loadPlayerByName(player, recipient)) {

return;

}

}

 

std::unique_ptr<Item> item = Item::CreateItem(itemId);

if (!item) {

    return;

}

 

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

if (player->isOffline()) {

    IOLoginData::savePlayer(player);

}

}

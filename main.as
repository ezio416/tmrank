bool permissionPlayMaps = false;
Window _window;

void Main() {
    permissionPlayMaps = Permissions::PlayLocalMap();
    Async::Await(Nadeo::Api::Authenticate);
    TMRank::Service::LoadAllMapPacks();
    
}

void Update(float dt) {
    _window.Update(dt);
}

void RenderInterface() {
    if(!UI::IsGameUIVisible()) return;
    _window.Render();
}

void RenderMenu() {
    string menuItemText = Colors::MEDAL_GOLD + Icons::Kenney::Podium + Colors::WHITE + " TMRank";
    if(UI::MenuItem(menuItemText, "", S_Open)) {
       S_Open = !S_Open;
    }
}
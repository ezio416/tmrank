namespace TMRank {
    namespace Service {

        const int LEADERBOARD_MAX = 100;

        void LoadAllMapPacks() {
            trace("loading map packs...");

            auto mapPacks = TMRank::Api::GetMapPacks();
            string userId = NadeoServices::GetAccountID();
            auto userPackStats = TMRank::Api::GetUserPackStats(userId);

            for(uint i = 0; i < userPackStats.Length; i++) {
                auto userPackStat = userPackStats[i];
                for(uint j = 0; j < mapPacks.Length; j++) {
                    auto mapPack = mapPacks[j];
                    if(userPackStat.TypeID == mapPack.TypeID) {
                        mapPack.SetUserPackStats(userPackStat);
                    }
                }
            }

            for(uint i = 0; i < mapPacks.Length; i++) {
                TMRank::Model::MapPack@ mapPack = mapPacks[i];
                trace("(" + (i + 1) + "/" + mapPacks.Length + ") getting maps for pack " + mapPack.TypeName + "...");
                mapPack.SetMaps(TMRank::Api::GetMapsForPack(mapPack));
                mapPack.UpdateUserStats(TMRank::Api::GetUserMapStats(mapPack, userId));
                mapPack.SetDrivers(TMRank::Api::GetRankings(mapPack, 100, 0));                
                TMRank::Cache::CacheMapPack(mapPack);
            }

            trace("done loading map packs!");
        }

    }
}
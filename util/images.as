namespace Util {
    namespace Images {
        dictionary cache;
        bool downloading = false;

        void DownloadAsync(const string&in url) {
            if (false
                or downloading
                or cache.Exists(url)
            ) {
                return;
            }

            downloading = true;

            trace("downloading image: " + url);

            Net::HttpRequest@ req = Http::GetAsyncRaw(url);
            UI::Texture@ tex = UI::LoadTexture(req.Buffer());
            if (true
                and tex !is null
                and tex.GetSize().x > 0
            ) {
                cache.Set(url, @tex);
            }

            downloading = false;
        }

        UI::Texture@ Get(const string&in url) {
            if (cache.Exists(url)) {
                return cast<UI::Texture>(cache[url]);
            }

            startnew(DownloadAsync, url);

            return null;
        }
    }
}

import 'package:dit/helper/spotify_helper.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';

class SearchControllerAtha extends GetxController {
  var searchQuery = ''.obs;
  var tracks = <Track>[].obs;
  var artists = <Artist>[].obs;
  var albums = <AlbumSimple>[].obs;
  var playlists = <PlaylistSimple>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (_) => fetchSearchResults(),
        time: Duration(milliseconds: 500));
  }

  void fetchSearchResults() async {
    if (searchQuery.isEmpty) return;
    isLoading(true);
    try {
      List<Page> results = await SpotifyApiHelper.getIstance()
          .search(searchQuery: searchQuery.value);
      tracks.clear();
      artists.clear();
      albums.clear();
      playlists.clear();

      for (var page in results) {
        for (var item in page.items!) {
          if (item is Artist) {
            artists.add(item);
          } else if (item is Track) {
            tracks.add(item);
          } else if (item is AlbumSimple) {
            albums.add(item);
          } else if (item is PlaylistSimple) {
            playlists.add(item);
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}

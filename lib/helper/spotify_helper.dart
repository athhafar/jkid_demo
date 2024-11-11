//

import 'dart:async';
import 'package:spotify/spotify.dart';

class SpotifyApiHelper {
  SpotifyApiHelper._privateConstructor();
  static final SpotifyApiHelper _instance =
      SpotifyApiHelper._privateConstructor();

  static SpotifyApiHelper getIstance() {
    return _instance;
  }

  final String _clientId = "3f85ceca65b7486686dbb07ea8844358";
  final String _clientSecret = "0697c3e4495040b0adde4ca1885e3524";
  late final SpotifyApiCredentials _credentials;
  late final SpotifyApi _spotify;

  void init() {
    _credentials = SpotifyApiCredentials(_clientId, _clientSecret);
    _spotify = SpotifyApi(_credentials);
  }

  Future<List<PlaylistSimple>?> featuredPlaylists() async {
    Page<PlaylistSimple> featuredPlaylists =
        await _spotify.playlists.featured.first();
    return featuredPlaylists.items?.toList();
  }

  Future<List<AlbumSimple>?> newReleases() async {
    Page<AlbumSimple> newReleases =
        await _spotify.browse.getNewReleases(country: "IN").first(6);
    return newReleases.items?.toList();
  }

  Future<List<Track>?> playlistTracks({required String playlistId}) async {
    Page<Track> tracks = await _spotify.playlists
        .getTracksByPlaylistId(playlistId)
        .getPage(50, 0);
    return tracks.items?.toList() ?? [];
  }

  Future<List<Track>> artistTopTracks({required String artistId}) async {
    Iterable<Track> tracks =
        await _spotify.artists.getTopTracks(artistId, "IN");
    return tracks.toList();
  }

  Future<List<Album>> artistAlbums({required String artistId}) async {
    Iterable<Album> albums =
        await _spotify.artists.albums(artistId, country: Market.IN).all(10);
    return albums.toList();
  }

  Future<List<Artist>> relatedArtists({required String artistId}) async {
    Iterable<Artist> relatedArtists =
        await _spotify.artists.relatedArtists(artistId);
    return relatedArtists.toList();
  }

  Future<List<Category>> categories() async {
    Iterable<Category> categories =
        await _spotify.categories.list(country: Market.IN, locale: "IN").all();
    return categories.toList();
  }

  // Future<List<Page<dynamic>>> search(
  //     {required String searchQuery, List<SearchType>? searchTypes}) async {
  //   return await _spotify.search
  //       .get(searchQuery, types: searchTypes , market: Market.IN)
  //       .first(4);
  // }

  Future<List<Page<dynamic>>> search(
      {required String searchQuery, List<SearchType>? searchTypes}) async {
    // Specify valid search types instead of using 'all'
    final validSearchTypes = searchTypes ??
        [
          SearchType.track,
          SearchType.album,
          SearchType.artist,
          SearchType.playlist
        ];

    final searchResults = _spotify.search
        .get(searchQuery, types: validSearchTypes, market: Market.IN);
    return await searchResults.getPage(40);
  }

  Future<Track> getTrack(String trackId) async {
    return await _spotify.tracks.get(trackId);
  }
}

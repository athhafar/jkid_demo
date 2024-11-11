import 'dart:async';

import 'package:dit/controllers/home/home_controller.dart';
import 'package:dit/helper/spotify_helper.dart';
import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:url_launcher/url_launcher.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

var ctrlSearch = TextEditingController().obs;
Timer? _timer;

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  Future<List<spotify.Page>>? searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = SpotifyApiHelper.getIstance().search(searchQuery: "");
  }

  void performSearch(String query) {
    setState(() {
      searchResults = SpotifyApiHelper.getIstance().search(searchQuery: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.white,
      body: Column(
        children: [
          const SizedBox(
            height: 24.0,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: ctrlSearch.value,
                onChanged: (value) {
                  if (_timer?.isActive ?? false) _timer?.cancel();
                  _timer = Timer(const Duration(milliseconds: 1500), () {
                    performSearch(value);
                  });
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(1000.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1000.0),
                    ),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                    hintText: "What do you want listen to?",
                    fillColor: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<spotify.Page>>(
                future: searchResults,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 200,
                        vertical: 32,
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'SILAHKAN MASUKKAN KATA PADA SEARCH BAR',
                            style: TStyle.medium32,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<spotify.Track> tracks = [];
                    List<spotify.Artist> artists = [];
                    List<spotify.AlbumSimple> albums = [];
                    List<spotify.PlaylistSimple> playlists = [];

                    snapshot.data?.forEach((pages) {
                      pages.items?.forEach((item) {
                        if (item is spotify.Artist) {
                          artists.add(item);
                        } else if (item is spotify.Track) {
                          tracks.add(item);
                        } else if (item is spotify.AlbumSimple) {
                          albums.add(item);
                        } else if (item is spotify.PlaylistSimple) {
                          playlists.add(item);
                        }
                      });
                    });

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("text"),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    children: [
                                      // const Text(
                                      //   "INI FILENYA",
                                      //   style: TextStyle(
                                      //     fontSize: 32.0,
                                      //   ),
                                      // ),
                                      for (int i = 0; i < tracks.length; i++)
                                        TrackTile(
                                          showDuration: true,
                                          showHoverEffect: true,
                                          track: tracks[i],
                                          onTap: () async {
                                            final trackUrl = tracks[i].uri!;
                                            print('card di klik ');
                                            final uri = Uri.parse(trackUrl);

                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri,
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            } else {
                                              throw 'Could not launch ';
                                            }
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackTile extends StatefulWidget {
  final spotify.Track track;
  final Function onTap;
  final bool showDuration;
  final bool showHoverEffect;
  const TrackTile({
    required this.onTap,
    required this.track,
    this.showDuration = false,
    this.showHoverEffect = false,
    super.key,
  });

  @override
  State<TrackTile> createState() => _TrackTileState();
}

class _TrackTileState extends State<TrackTile> {
  bool _isMouseHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isMouseHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isMouseHover = false;
        });
      },
      child: ListTile(
        onTap: () {
          widget.onTap();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(widget.track.name ?? ""),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.track.explicit ?? false
                ? const Icon(Icons.explicit_rounded)
                : const SizedBox(),
            const SizedBox(width: 5),
            Text(
              widget.track.artists!.map((e) => e.name).join(", "),
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                widget.track.album?.images?.first.url ?? "",
                filterQuality: FilterQuality.none,
                colorBlendMode: _isMouseHover && widget.showHoverEffect
                    ? BlendMode.darken
                    : null,
                color: _isMouseHover && widget.showHoverEffect
                    ? Colors.black54
                    : null,
              ),
              _isMouseHover && widget.showHoverEffect
                  ? const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        trailing: widget.showDuration
            ? Text(
                "${widget.track.duration!.inMinutes.remainder(60)}:${widget.track.duration!.inSeconds.remainder(60)}",
                style: const TextStyle(color: Colors.grey),
              )
            : null,
      ),
    );
  }
}

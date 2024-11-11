import 'package:dit/controllers/spotify/spotify_controller.dart';
import 'package:dit/pages/spotify/search_result_screen.dart';
import 'package:dit/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';

import 'package:url_launcher/url_launcher.dart';

class SearchResultsScreenAtha extends StatelessWidget {
  final SearchControllerAtha searchController = Get.put(SearchControllerAtha());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) {
                      searchController.searchQuery(value);
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
                      hintText: "What do you want to listen to?",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Results Section
              GetBuilder<SearchControllerAtha>(
                builder: (_) {
                  if (searchController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Top result",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Songs",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Display top artist and tracks
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TopResultCard(
                      //         artist: searchController.artists.first,
                      //         onTap: () {
                      //           // Navigate to artist screen
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(width: 20),
                      //     Expanded(
                      //       child: Column(
                      //         children: [
                      //           for (var track in searchController.tracks)
                      //             TrackTile(
                      //               track: track,
                      //               onTap: () async {
                      //                 final trackUrl = track.uri!;
                      //                 final uri = Uri.parse(trackUrl);
                      //                 if (await canLaunchUrl(uri)) {
                      //                   await launchUrl(uri,
                      //                       mode:
                      //                           LaunchMode.externalApplication);
                      //                 }
                      //               },
                      //             ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 40),
                      // Artists List
                      Text(
                        "Artists",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 320,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: searchController.artists.length,
                      //     itemBuilder: (context, index) {
                      //       return CollectionCard(
                      //         imageUrl: searchController
                      //                 .artists[index].images?.first.url ??
                      //             "",
                      //         title: searchController.artists[index].name,
                      //         subtitle: "Artist",
                      //         onTap: () {
                      //           // Navigate to artist screen
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),

                      const SizedBox(height: 40),
                      // Albums List
                      Text(
                        "Albums",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 320,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: searchController.albums.length,
                      //     itemBuilder: (context, index) {
                      //       return CollectionCard(
                      //         imageUrl: searchController
                      //                 .albums[index].images?.first.url ??
                      //             "",
                      //         title: searchController.albums[index].name,
                      //         subtitle: "Album",
                      //         onTap: () {},
                      //       );
                      //     },
                      //   ),
                      // ),

                      const SizedBox(height: 40),
                      // Playlists List
                      Text(
                        "Playlists",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 320,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: searchController.playlists.length,
                      //     itemBuilder: (context, index) {
                      //       return CollectionCard(
                      //         imageUrl: searchController
                      //                 .playlists[index].images?.first.url ??
                      //             "",
                      //         title: searchController.playlists[index].name,
                      //         subtitle: "Playlist",
                      //         onTap: () {
                      //           // Navigate to playlist screen
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopResultCard extends StatefulWidget {
  final Artist artist;
  final Function onTap;
  const TopResultCard({required this.artist, required this.onTap, super.key});

  @override
  State<TopResultCard> createState() => _TopResultCardState();
}

class _TopResultCardState extends State<TopResultCard> {
  bool _isMouseHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isMouseHover
              ? Colors.grey.withOpacity(0.13)
              : Colors.grey.withOpacity(0.05),
        ),
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.artist.images?.first.url ?? ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        widget.artist.name ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Chip(label: Text("Artist")),
                  ],
                ),
                _isMouseHover
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 140, 0, 0),
                          child: FloatingActionButton(
                            mouseCursor: SystemMouseCursors.forbidden,
                            heroTag: UniqueKey().toString(),
                            child: const Icon(Icons.play_arrow),
                            onPressed: () {},
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

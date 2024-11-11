import 'dart:async';

import 'package:dit/helper/spotify_helper.dart';
import 'package:dit/utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:spotify/spotify.dart';
import 'package:url_launcher/url_launcher.dart';

class TestDuaController extends GetxController {
  var ctrlSearch = TextEditingController().obs;
  var isLoading = false.obs;
  var searchResults = <spotify.Track>[].obs;

  void searchTracks(String query) async {
    if (query.isEmpty) return;

    isLoading(true);

    try {
      var results = await SpotifyApiHelper.getIstance().search(
        searchQuery: query,
        searchTypes: [SearchType.track], // Only search for tracks
      );

      // Filter and extract track items from results
      searchResults.clear();
      for (var page in results) {
        for (var item in page.items ?? []) {
          if (item is Track) {
            searchResults.add(item);
          }
        }
      }
    } catch (e) {
      print("Error occurred during search: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> launchSpotify() async {
    // const trackUri = 'spotify:track:57XxjBWEg4bU5nnW5WCSBG';
    // const webUrl = 'https://open.spotify.com/track/57XxjBWEg4bU5nnW5WCSBG';

    String spotifyUrl = 'spotify:track:57XxjBWEg4bU5nnW5WCSBG';
    Uri spotifyUri = Uri.parse(spotifyUrl);

    if (await canLaunchUrl(spotifyUri)) {
      await launchUrl(spotifyUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Instagram profile.';
    }
  }

  Future<void> launchInstagram(String username) async {
    String instagramUrl = 'https://instagram.com/$username';
    Uri instagramUri = Uri.parse(instagramUrl);

    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Instagram profile.';
    }
  }
}

class TestDuaPage extends StatelessWidget {
  TestDuaPage({super.key});

  TestDuaController controller = Get.put(TestDuaController());
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          InkWell(
            onTap: () {
              controller.launchSpotify();
              // controller.launchInstagram('athafrl_');
            },
            child: const Text(
              "text",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Obx(() => TextFormField(
                autofocus: false,
                controller: controller.ctrlSearch.value,
                onChanged: (value) {
                  if (_timer?.isActive ?? false) _timer?.cancel();
                  _timer = Timer(const Duration(milliseconds: 1500), () {
                    controller.searchTracks(value);
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Cari di sini",
                  border: InputBorder.none,
                ),
              )),
          const SizedBox(
            height: 24.0,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.searchResults.isEmpty) {
              return const Center(child: Text("No tracks found."));
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  spotify.Track track = controller.searchResults[index];
                  return ListTile(
                    // leading: track.album?.images?.isNotEmpty == true
                    //     ? Image.network(track.album!.images!.first.url!)
                    //     : const Icon(Icons.music_note),
                    title: Text(track.name ?? "No title"),
                    subtitle: Text(track.artists?.first.name ?? "No artist"),
                    onTap: () async {
                      String trackUri = track.uri ?? "";
                      Uri spotifyUri = Uri.parse(trackUri);

                      if (await canLaunchUrl(spotifyUri)) {
                        await launchUrl(spotifyUri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        Helper.setSnackbar("Could not open track in Spotify.");
                      }
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

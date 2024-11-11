// import 'package:dit/pages/test_dua.dart';
// import 'package:dit/utilities/api_key.dart';
// import 'package:dit/utilities/helper.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeController extends GetxController {
//   final ctrlInput = TextEditingController().obs;
//   final ctrlAnswer = TextEditingController().obs;
//   final speechToText = SpeechToText().obs;
//   var speechEnabled = false.obs;
//   var lastWords = "".obs;
//   var loading = DataLoad.done.obs;
//   var isListening = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     listenForPermissions();
//     if (!speechEnabled.value) {
//       initSpeech();
//     }
//   }

//   void sendMessage() {
//     loading.value = DataLoad.loading;
//     var text = ctrlInput.value.text
//         .toLowerCase(); // Convert to lowercase for easier comparison

//     if (text.isEmpty) {
//       loading.value = DataLoad.done;
//       return;
//     }

//     // Check for keywords and navigate accordingly
//     if (text.contains('youtube')) {
//       // Navigate to YouTube view
//       Get.to(() => TestDuaPage()); // Replace with your actual YouTube page
//     } else if (text.contains('spotify')) {
//       // Navigate to Spotify view
//       Get.to(() => TestDuaPage()); // Replace with your actual Spotify page
//     } else {
//       ctrlAnswer.value.text = "No matching service found.";
//     }

//     loading.value = DataLoad.done;
//   }

//   void listenForPermissions() async {
//     final status = await Permission.microphone.status;
//     if (status.isDenied) {
//       await requestForPermission();
//     }
//   }

//   Future<void> requestForPermission() async {
//     await Permission.microphone.request();
//   }

//   void initSpeech() async {
//     speechEnabled.value = await speechToText.value.initialize();
//   }

//   void startListening() async {
//     if (speechEnabled.value) {
//       isListening.value = true; // Set isListening to true
//       await speechToText.value.listen(
//         onResult: onSpeechResult,
//         listenFor: const Duration(seconds: 30),
//         localeId: "en_En",
//         cancelOnError: false,
//         partialResults: false,
//         listenMode: ListenMode.confirmation,
//       );
//     }
//   }

//   void stopListening() async {
//     await speechToText.value.stop();
//     isListening.value = false; // Set isListening to false
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     lastWords.value = "${lastWords.value}${result.recognizedWords} ";
//     ctrlInput.value.text = lastWords.value;

//     if (result.finalResult) {
//       stopListening();
//       sendMessage();
//     }
//   }

//   Future<void> launchMap(double latitude, double longitude) async {
//     String googleUrl = 'https://maps.google.com/?q=$latitude,$longitude';
//     Uri googleUri = Uri.parse(googleUrl);

//     if (await canLaunchUrl(googleUri)) {
//       await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }

//   Future<void> launchMapPlaceId({String? placeId}) async {
//     String googleUrl;

//     if (placeId != null) {
//       // Menggunakan Place ID
//       googleUrl = 'https://maps.google.com/?q=place_id:$placeId';
//     } else {
//       throw 'Place ID is required';
//     }

//     Uri googleUri = Uri.parse(googleUrl);

//     if (await canLaunchUrl(googleUri)) {
//       await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }

//   Future<void> launchInstagram(String username) async {
//     String instagramUrl = 'https://instagram.com/$username';
//     Uri instagramUri = Uri.parse(instagramUrl);

//     if (await canLaunchUrl(instagramUri)) {
//       await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open Instagram profile.';
//     }
//   }

//   Future<void> launchYouTube(
//       {String? username, String? channelId, String? videoId}) async {
//     String youtubeUrl = '';

//     if (videoId != null) {
//       youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
//     } else if (channelId != null) {
//       youtubeUrl = 'https://www.youtube.com/channel/$channelId';
//     } else if (username != null) {
//       youtubeUrl = 'https://www.youtube.com/user/$username/';
//     } else {
//       throw 'Username or Channel ID is required';
//     }

//     Uri youtubeUri = Uri.parse(youtubeUrl);

//     if (await canLaunchUrl(youtubeUri)) {
//       await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not open the YouTube profile.';
//     }
//   }

//   Future<void> launchSpotify() async {
//     var clientId = "3f85ceca65b7486686dbb07ea8844358".obs;
//     var redirectUri =
//         "https://open.spotify.com/track/3qmm9AdG0TnShv0drgXNIQ?si=9a8e3cf06e9f40dc"
//             .obs;
//     final String spotifyUrl =
//         'https://accounts.spotify.com/authorize?client_id=${clientId.value}&response_type=token&redirect_uri=$redirectUri&scope=user-read-private,user-read-email';

//     Uri spotifyUri = Uri.parse(spotifyUrl);
//     if (await canLaunchUrl(spotifyUri)) {
//       await launchUrl(spotifyUri);
//     } else {
//       throw 'Could not launch $spotifyUri';
//     }
//   }
// }

import 'dart:convert';
import 'package:dit/pages/test_dua.dart';
import 'package:dit/utilities/api_key.dart';
import 'package:dit/utilities/helper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final ctrlInput = TextEditingController().obs;
  final ctrlAnswer = TextEditingController().obs;
  final speechToText = SpeechToText().obs;
  var speechEnabled = false.obs;
  var lastWords = "".obs;
  var loading = DataLoad.done.obs;
  var isListening = false.obs;
  var videoList = <Map<String, dynamic>>[].obs;
  var spotifyList = <Map<String, dynamic>>[].obs;
  var gasStationList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // speak('testing female voices', isAnimeVoice: true);
    listenForPermissions();
    if (!speechEnabled.value) {
      initSpeech();
    }
  }

  var listMascot = ['Profesional', 'Hatsune Miku', 'Steve Jobs'].obs;

  var selectedIndex = 0.obs;

  FlutterTts flutterTts = FlutterTts();

  // Future<void> speak(String text) async {
  //   List<dynamic> voices = await flutterTts.getVoices;
  //   bool isAnimeVoice = selectedIndex.value == 1;
  //   // bool isProfesionalVoice = selectedIndex.value == 0;

  //   var femaleVoice = voices.firstWhere(
  //     (voice) => voice['name'].toLowerCase().contains('female'),
  //     orElse: () => null,
  //   );

  //   // if (femaleVoice != null) {
  //   //   await flutterTts.setVoice(femaleVoice['name']);
  //   // } else {
  //   //   debugPrint('Suara wanita tidak ditemukan');
  //   // }

  //   if (isAnimeVoice) {
  //     await flutterTts.clearVoice();
  //     await flutterTts.setVoice(femaleVoice['name']);
  //     await flutterTts.setPitch(1.8);
  //     await flutterTts.setSpeechRate(0.8);
  //   } else {
  //     await flutterTts.clearVoice();
  //     await flutterTts
  //         .setVoice({'name': 'en-us-x-iol-local', 'locale': 'en-US'});
  //     await flutterTts.setPitch(1.0);
  //     await flutterTts.setSpeechRate(0.5);
  //   }

  //   await flutterTts.speak(text);
  // }

  Future<void> speak(String text) async {
    bool isAnimeVoice = selectedIndex.value == 1;
    bool isNormal = selectedIndex.value == 0;

    if (isAnimeVoice) {
      await flutterTts.setPitch(1.5);
      await flutterTts.setSpeechRate(0.7);
    } else if (isNormal) {
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
    } else {
      await flutterTts
          .setVoice({'name': 'en-us-x-iol-local', 'locale': 'en-US'});
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
    }

    await flutterTts.speak(text);
  }

  void sendMessage() async {
    loading.value = DataLoad.loading;
    var text = ctrlInput.value.text.toLowerCase();

    if (text.isEmpty) {
      loading.value = DataLoad.done;
      return;
    }

    // Daftar video
    var allVideos = [
      {
        "thumbnailUrl": "https://i.ytimg.com/vi/PyQQJWmV1LE/maxresdefault.jpg",
        "title": "Exploring the Mountains",
        "duration": "3,1 M",
        "date": "November 18, 2021",
        "channelImageUrl":
            "https://yt3.googleusercontent.com/odOvnf0qVTMU0_iwuwHhugaT76cqkidOlEsQAIxmuDU8RDXmLK2gpq4fTULvjkgT8-1gmg8KKg=s160-c-k-c0x00ffffff-no-rj",
        "channelName": "Kraig Adams",
        "subscriberCount": "777 rb Subscribers",
        "url": "https://www.youtube.com/watch?app=desktop&v=PyQQJWmV1LE",
        "tags": ["mountain"],
      },
      {
        "thumbnailUrl": "https://i.ytimg.com/vi/WPKKp3hkVx0/maxresdefault.jpg",
        "title": "5 Tips for BETTER Cooking Videos",
        "duration": "151 rb",
        "date": "August 27, 2022",
        "channelImageUrl":
            "https://yt3.googleusercontent.com/vDZ8SKzsrxO1WzjCyBU0byvOvYowi-KPmXrxLFLoCQrYq2eMQ4dy_aSZUQSR8VrlCEPrerf4=s160-c-k-c0x00ffffff-no-rj",
        "channelName": "Philip Lemoine",
        "subscriberCount": "223 rb Subscribers",
        "url": "https://www.youtube.com/watch?app=desktop&v=WPKKp3hkVx0",
        "tags": ["cooking"],
      },
      {
        "thumbnailUrl": "https://i.ytimg.com/vi/gmTw5vp8qCI/maxresdefault.jpg",
        "title": "Extreme Saltwater Fishing 2",
        "duration": "11,3 M",
        "date": "March 23, 2021",
        "channelImageUrl":
            "https://yt3.googleusercontent.com/hfM0zcgUaXThL_sVH1TWvGaqu5nmekZ_NkCTZWVYWce5BI-TG5HoCPotr39b0hjYyhBkAWsuZw=s160-c-k-c0x00ffffff-no-rj",
        "channelName": "Blacktip H",
        "subscriberCount": "4,73 M Subscribers",
        "url": "https://www.youtube.com/watch?app=desktop&v=gmTw5vp8qCI",
        "tags": ["fishing"],
      },
    ];

    var allSpotifyTracks = [
      {
        "thumbnailUrl":
            "https://i.scdn.co/image/ab67616d0000b273dec2e6bae5062b94fc4eeb84",
        "title": "It Will Rain",
        "artist": "Bruno Mars",
        "duration": "4:05",
        "url": "https://open.spotify.com/intl-id/album/4A0vJtV9ok7vmr9ursSKj8",
        "tags": ["bruno mars, it will rain"],
      },
      {
        "thumbnailUrl":
            "https://i.scdn.co/image/ab67616d00001e02c464fabb4e51b72d657f779a",
        "title": "Blinding Lights",
        "artist": "The Weeknd",
        "duration": "3:45",
        "url": "https://open.spotify.com/intl-id/track/0VjIjW4GlUZAMYd2vXMi3b",
        "tags": ["the weeknd, the weekend, blinding lights"],
      },
      {
        "thumbnailUrl":
            "https://i.scdn.co/image/ab67616d00001e02f8c8297efc6022534f1357e1",
        "title": "APT",
        "artist": "Rose",
        "duration": "4:05",
        "url": "https://open.spotify.com/intl-id/track/5vNRhkKd0yEAg8suGBpjeY",
        "tags": ["rose, ross, apt"],
      },
    ];

    await Future.delayed(
        Duration(seconds: 2)); // Tambahkan delay 2 detik sebelum melanjutkan

    if (text.contains('youtube')) {
      videoList.clear();
      spotifyList.clear();
      gasStationList.clear();
      List<Map<String, dynamic>> filteredVideos = [];

      if (text.contains('mountain')) {
        filteredVideos.addAll(allVideos
            .where((video) => video['tags'].toString().contains('mountain')));
      }
      if (text.contains('fishing')) {
        filteredVideos.addAll(allVideos
            .where((video) => video['tags'].toString().contains('fishing')));
      }
      if (text.contains('cooking')) {
        filteredVideos.addAll(allVideos
            .where((video) => video['tags'].toString().contains('cooking')));
      }

      filteredVideos = filteredVideos.toSet().toList();

      if (filteredVideos.isEmpty) {
        filteredVideos = allVideos;
      }

      videoList.value = filteredVideos;
      loading.value = DataLoad.done;
    } else if (text.contains('spotify')) {
      videoList.clear();
      spotifyList.clear();
      gasStationList.clear();
      List<Map<String, dynamic>> filteredSpotifyTracks = [];

      if (text.contains('bruno mars')) {
        filteredSpotifyTracks.addAll(allSpotifyTracks
            .where((track) => track['tags'].toString().contains('bruno mars')));
      }
      if (text.contains('the weeknd')) {
        filteredSpotifyTracks.addAll(allSpotifyTracks
            .where((track) => track['tags'].toString().contains('the weeknd')));
      }
      if (text.contains('rose')) {
        filteredSpotifyTracks.addAll(allSpotifyTracks
            .where((track) => track['tags'].toString().contains('rose')));
      }

      filteredSpotifyTracks = filteredSpotifyTracks.toSet().toList();

      if (filteredSpotifyTracks.isEmpty) {
        filteredSpotifyTracks = allSpotifyTracks;
      }

      spotifyList.value = filteredSpotifyTracks;
      loading.value = DataLoad.done;
    } else if (text.contains('gas station')) {
      videoList.clear();
      spotifyList.clear();
      gasStationList.clear();
      gasStationList.value = [
        {
          "imageUrl":
              "https://lh3.googleusercontent.com/p/AF1QipMnnGK57-eFQEgqkM8UfY73g3moUgHAt-_LG1lK=s1360-w1360-h1020",
          "title": "SPBU Pertamina 34",
          "subtitle":
              "Jl. Boulevard Bar. Raya No.2 Blok B, RT.10/RW.5, Klp. Gading Bar., Kec, Jkt Utara, Daerah Khusus Ibukota Jakarta 14240",
          "lat": "-6.155841490294658",
          "long": "106.90146282142932",
        },
        {
          "imageUrl":
              "https://lh5.googleusercontent.com/p/AF1QipOsnD6J0d5IdnX-fTN8LqYh3RZ-mG7OJgZ3CJYf=w325-h218-n-k-no",
          "title": "Shell Kelapa Gading -Do",
          "subtitle":
              "RWR2+R5P, Jl. Boulevard Bukit Gading Raya, RW.5, Klp. Gading Bar., Kec. Klp. Gading, Jkt Utara, Daerah Khusus Ibukota Jakarta 14240",
          "lat": "-6.1499425887109505",
          "long": "106.89865629563626",
        },
      ];
      loading.value = DataLoad.done;
    } else {
      Helper.setSnackbar('Data Tidak Di Temukkan');
      loading.value = DataLoad.done;
    }
  }

  // void sendMessage() {
  //   loading.value = DataLoad.loading;
  //   var text = ctrlInput.value.text;

  //   if (text.isEmpty) {
  //     loading.value = DataLoad.done;
  //     return;
  //   }

  //   var model = GenerativeModel(
  //       model: 'gemini-1.5-flash-latest', apiKey: ApiKey.geminiKey);

  //   model.generateContent([Content.text(text)]).then((value) {
  //     ctrlAnswer.value.text = value.text ?? "Error: No response";
  //     loading.value = DataLoad.done;
  //   }).catchError((error) {
  //     ctrlAnswer.value.text = "Error: $error";
  //     loading.value = DataLoad.failed;
  //   });
  // }

  // void sendMessage() {
  //   loading.value = DataLoad.loading;
  //   var text = ctrlInput.value.text;

  //   if (text.isEmpty) {
  //     loading.value = DataLoad.done;
  //     return;
  //   }

  //   text = 'youtube';
  //   // Check for keywords
  //   if (text.contains('youtube')) {
  //     // Navigate to YouTube view
  //     Get.to(() => TestDuaPage());
  //     loading.value = DataLoad.done;
  //     return;
  //   } else if (text.contains('spotify')) {
  //     // Navigate to Spotify view
  //     Get.to(() => TestDuaPage());
  //     loading.value = DataLoad.done;
  //     return;
  //   }

  //   var model = GenerativeModel(
  //       model: 'gemini-1.5-flash-latest', apiKey: ApiKey.geminiKey);

  //   model.generateContent([Content.text(text)]).then((value) {
  //     ctrlAnswer.value.text = value.text ?? "Error: No response";
  //     loading.value = DataLoad.done;
  //   }).catchError((error) {
  //     ctrlAnswer.value.text = "Error: $error";
  //     loading.value = DataLoad.failed;
  //   });
  // }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      await requestForPermission();
    }
    if (status.isGranted) {
      await initSpeech();
    } else {
      Helper.setSnackbar("Microphone permission is not granted.");
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  Future<void> initSpeech() async {
    speechEnabled.value = await speechToText.value.initialize();
    if (!speechEnabled.value) {
      Helper.setSnackbar("Speech recognition could not be initialized.");
    } else {
      Helper.setSnackbar("Speech recognition initialized successfully.");
    }
  }

  var changeLanguage = ChangeLanguage.inggris.obs;

  String getLanguageCode(ChangeLanguage language) {
    switch (language) {
      case ChangeLanguage.inggris:
        return 'en';
      case ChangeLanguage.jepang:
        return 'jp';
      case ChangeLanguage.indonesia:
        return 'id';
      default:
        return 'en';
    }
  }

  void startListening(String languageCode) async {
    if (speechEnabled.value) {
      ctrlInput.value.clear();
      isListening.value = true; // Set isListening to true
      try {
        String localeId;
        switch (languageCode) {
          case 'en': // Bahasa Inggris
            localeId = "en_US";
            break;
          case 'id': // Bahasa Indonesia
            localeId = "id_ID";
            break;
          case 'jp': // Bahasa Jepang
            localeId = "ja_JP";
            break;
          default:
            localeId = "en_US"; // Default ke Bahasa Inggris
            break;
        }
        await speechToText.value.listen(
          onResult: onSpeechResult,
          listenFor: const Duration(seconds: 30),
          // localeId: "en_En",
          localeId: localeId,
          cancelOnError: false,
          partialResults: false,
          listenMode: ListenMode.confirmation,
        );
      } catch (e) {
        isListening.value = false;
        Helper.setSnackbar(
          "Failed to start listening: ${e.toString()}",
        );
      }
    } else {
      Helper.setSnackbar(
        "Speech recognition is not enabled.",
      );
    }
  }

  String getLocalizedTextYoutube(ChangeLanguage language) {
    switch (language) {
      case ChangeLanguage.inggris:
        return 'This is the result of the YouTube list.';
      case ChangeLanguage.indonesia:
        return 'Ini adalah hasil dari daftar YouTube.';
      case ChangeLanguage.jepang:
        return 'これはYouTubeリストの結果です。';
      default:
        return 'This is the result of the YouTube list.';
    }
  }

  String getLocalizedTextSpotify(ChangeLanguage language) {
    switch (language) {
      case ChangeLanguage.inggris:
        return 'This is the result of the Spotify playlist.';
      case ChangeLanguage.indonesia:
        return 'Ini adalah hasil dari daftar putar Spotify.';
      case ChangeLanguage.jepang:
        return 'これはSpotifyプレイリストの結果です。';
      default:
        return 'This is the result of the Spotify playlist.';
    }
  }

  String getLocalizedTextMaps(ChangeLanguage language) {
    switch (language) {
      case ChangeLanguage.inggris:
        return 'This is the result of the gas station locations.';
      case ChangeLanguage.indonesia:
        return 'Ini adalah hasil dari lokasi pompa bensin.';
      case ChangeLanguage.jepang:
        return 'これはガソリンスタンドの位置の結果です。';
      default:
        return 'This is the result of the gas station locations.';
    }
  }

  void stopListening() async {
    await speechToText.value.stop();
    isListening.value = false;
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    ctrlInput.value.text = lastWords.value;

    if (result.finalResult) {
      stopListening();
      sendMessage();
    }
  }

  Future<void> launchMap(double latitude, double longitude) async {
    String googleUrl = 'https://maps.google.com/?q=$latitude,$longitude';
    Uri googleUri = Uri.parse(googleUrl);

    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<void> launchMapPlaceId({String? placeId}) async {
    String googleUrl;

    if (placeId != null) {
      // Menggunakan Place ID
      googleUrl = 'https://maps.google.com/?q=place_id:$placeId';
    } else {
      throw 'Place ID is required';
    }

    Uri googleUri = Uri.parse(googleUrl);

    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
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

  Future<void> launchYouTube(
      {String? username, String? channelId, String? videoId}) async {
    String youtubeUrl = '';

    if (videoId != null) {
      youtubeUrl = 'https://www.youtube.com/watch?v=$videoId';
    } else if (channelId != null) {
      youtubeUrl = 'https://www.youtube.com/channel/$channelId';
    } else if (username != null) {
      youtubeUrl = 'https://www.youtube.com/user/$username/';
    } else {
      throw 'Username or Channel ID is required';
    }

    Uri youtubeUri = Uri.parse(youtubeUrl);

    if (await canLaunchUrl(youtubeUri)) {
      await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the YouTube profile.';
    }
  }

  Future<void> launchSpotify(String redirectUri) async {
    var clientId = "3f85ceca65b7486686dbb07ea8844358".obs;
    // var redirectUri =
    //     "https://open.spotify.com/track/3qmm9AdG0TnShv0drgXNIQ?si=9a8e3cf06e9f40dc"
    // .obs;
    final String spotifyUrl =
        'https://accounts.spotify.com/authorize?client_id=${clientId.value}&response_type=token&redirect_uri=$redirectUri&scope=user-read-private,user-read-email';

    Uri spotifyUri = Uri.parse(spotifyUrl);
    if (await canLaunchUrl(spotifyUri)) {
      await launchUrl(spotifyUri);
    } else {
      throw 'Could not launch $spotifyUri';
    }
  }
}

import 'package:dit/helper/spotify_helper.dart';
import 'package:dit/pages/home/home_jkid_page.dart';
import 'package:dit/pages/home/home_page.dart';
import 'package:dit/pages/spotify/search_result_screen.dart';
import 'package:dit/pages/spotify/testing_spotify.dart';
import 'package:dit/pages/test_dua.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  SpotifyApiHelper.getIstance().init();
  WidgetsFlutterBinding.ensureInitialized();
  // YoutubeExplodeHelper.getIstance().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JKID',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeJkidPage(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dit/controllers/home/home_controller.dart';
import 'package:dit/pages/home/home_page.dart';
import 'package:dit/pages/home/widgets/bottom_sheet_language.dart';
import 'package:dit/pages/home/widgets/bottom_sheet_mascot.dart';
import 'package:dit/utilities/asset_constant.dart';
import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/decoration.dart';
import 'package:dit/utilities/helper.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeJkidPage extends StatelessWidget {
  HomeJkidPage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFe8e9f9),
      resizeToAvoidBottomInset: false,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Get.height,
              decoration: const BoxDecoration(
                color: Color(0XFFe8e9f9),
                border: Border(
                  right: BorderSide(
                    color: Color(0XFFd0d2ee),
                    width: 4,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Image.asset(
                AssetConstant.imgBackground,
                // fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                // PopupMenuButton<ChangeLanguage>(
                //   onSelected: (order) {
                //     controller.changeLanguage.value = order;

                //     String languageCode = controller.getLanguageCode(order);
                //     controller.startListening(languageCode);
                //   },
                //   itemBuilder: (context) => [
                //     const PopupMenuItem(
                //       value: ChangeLanguage.inggris,
                //       child: Text("English"),
                //     ),
                //     const PopupMenuItem(
                //       value: ChangeLanguage.jepang,
                //       child: Text("Japanese"),
                //     ),
                //     const PopupMenuItem(
                //       value: ChangeLanguage.indonesia,
                //       child: Text("Indonesian"),
                //     ),
                //   ],
                //   icon: const Icon(
                //     Icons.language,
                //     color: BaseColor.white,
                //   ),
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                          var text =
                              controller.ctrlInput.value.text.toLowerCase();
                          if (controller.loading.value == DataLoad.loading) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.25,
                                ),
                                Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                ),
                              ],
                            );
                          } else if (controller.videoList.isNotEmpty) {
                            controller.speak(controller.getLocalizedTextYoutube(
                                controller.changeLanguage.value));

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.videoList.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  var video = controller.videoList[index];
                                  return VideoCard(
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse(video['url']!),
                                      );
                                    },
                                    thumbnailUrl: video['thumbnailUrl']!,
                                    title: video['title']!,
                                    duration: video['duration']!,
                                    date: video['date']!,
                                    channelImageUrl: video['channelImageUrl']!,
                                    channelName: video['channelName']!,
                                    subscriberCount: video['subscriberCount']!,
                                  );
                                });
                          } else if (controller.spotifyList.isNotEmpty) {
                            controller.speak(controller.getLocalizedTextSpotify(
                                controller.changeLanguage.value));

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.spotifyList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                var spotify = controller.spotifyList[index];
                                return InstagramCard(
                                  image: spotify['thumbnailUrl']!,
                                  bio: spotify['title']!,
                                  text: spotify['artist'],
                                  onTap: () async {
                                    await launchUrl(
                                      Uri.parse(spotify['url']!),
                                    );
                                  },
                                );
                              },
                            );
                          } else if (controller.gasStationList.isNotEmpty) {
                            controller.speak(controller.getLocalizedTextMaps(
                                controller.changeLanguage.value));
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.gasStationList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                var gasStation =
                                    controller.gasStationList[index];
                                return terdekatCard(
                                  onTap: () async {
                                    await launchUrl(
                                      Uri.parse(
                                          'https://maps.google.com/?q=${gasStation['lat']},${gasStation['long']}'),
                                    );
                                  },
                                  image: gasStation['imageUrl'],
                                  subtitle: gasStation['subtitle'],
                                  title: gasStation['title'],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Obx(() {
                                  //   return Container(
                                  //     margin: const EdgeInsets.symmetric(
                                  //         horizontal: 16),
                                  //     child: TextFormField(
                                  //       controller: controller.ctrlInput.value,
                                  //       onChanged: (value) {
                                  //         controller.ctrlInput.value.text ==
                                  //             value;
                                  //       },
                                  //       decoration: kDecorationForm,
                                  //     ),
                                  //   );
                                  // }),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        FloatingActionButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              BottomSheetLanguageSelector(),
                                              isScrollControlled: true,
                                            );
                                          },
                                          backgroundColor: Colors.blue,
                                          child: const Icon(
                                            Icons.filter_list_rounded,
                                            color: Color(0XFFe8e9f9),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              BottomSheetFilter(),
                                              isScrollControlled: true,
                                            );
                                          },
                                          backgroundColor: Colors.blue,
                                          child: const Icon(
                                            Icons.filter_list_rounded,
                                            color: Color(0XFFe8e9f9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.isListening.value) {
                                          controller.stopListening();
                                          controller.sendMessage();
                                        } else {
                                          controller.startListening('');
                                          // controller.sendMessAage();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      child: Center(
                                        child: Image.asset(
                                          width: 200,
                                          height: 200,
                                          controller.selectedIndex.value == 0
                                              ? AssetConstant.imgMascot1
                                              : AssetConstant.imgMascot2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Obx(
                  () => controller.videoList.isNotEmpty ||
                          controller.spotifyList.isNotEmpty ||
                          controller.gasStationList.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: BaseColor.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        controller.ctrlInput.value.clear();
                                        controller.videoList.clear();
                                        controller.gasStationList.clear();
                                        controller.spotifyList.clear();
                                        controller.loading.value ==
                                            DataLoad.done;
                                        controller.flutterTts.clearVoice();
                                        controller.flutterTts.stop();
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          'Clear',
                                          style: TStyle.medium14
                                              .copyWith(color: BaseColor.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: BaseColor.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.sendMessage();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  'Send',
                                  style: TStyle.medium16
                                      .copyWith(color: BaseColor.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

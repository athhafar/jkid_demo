// import 'package:dit/controllers/home/home_controller.dart';
// import 'package:dit/utilities/colors.dart';
// import 'package:dit/utilities/decoration.dart';
// import 'package:dit/utilities/typography.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     HomeController controller = Get.put(HomeController());
//     return Scaffold(
//       floatingActionButton: Obx(
//         () => FloatingActionButton(
//           onPressed: controller.speechToText.value.isNotListening
//               ? controller.startListening
//               : controller.stopListening,
//           tooltip: 'Listen',
//           backgroundColor: Colors.blueGrey,
//           child: Obx(
//             () => Icon(
//               controller.speechToText.value.isNotListening == true
//                   ? Icons.mic_off
//                   : Icons.mic,
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: BaseColor.white,
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: Get.height * 0.05,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: controller.ctrlInput.value,
//                       minLines: 4,
//                       maxLines: 4,
//                       decoration: kDecorationForm,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                   Expanded(
//                     child: Obx(() => TextFormField(
//                           controller: controller.ctrlAnswer.value,
//                           minLines: 4,
//                           maxLines: 4,
//                           decoration: kDecorationForm,
//                         )),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 24.0,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: BaseColor.red,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () {
//                             controller.ctrlInput.value.clear();
//                           },
//                           borderRadius: BorderRadius.circular(12),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Text(
//                               'Clear',
//                               style: TStyle.medium14
//                                   .copyWith(color: BaseColor.white),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12.0,
//                   ),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: BaseColor.green,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () {
//                             controller.sendMessage();
//                           },
//                           borderRadius: BorderRadius.circular(12),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: const Text(
//                               'Replay',
//                               style: TStyle.medium14,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/typography.dart';
import 'package:dit/controllers/home/home_controller.dart';
import 'package:dit/utilities/asset_constant.dart';
import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/decoration.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.white,
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            if (controller.isListening.value) {
              controller.stopListening();
              controller.sendMessage();
            } else {
              controller.startListening('');
              // controller.sendMessage();
            }
          },
          tooltip: 'Listen',
          backgroundColor: Colors.blueGrey,
          child: Icon(
            controller.isListening.value ? Icons.mic : Icons.mic_off,
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Get.height,
              color: const Color(0XFFe8e9f9),
              child: Image.asset(
                AssetConstant.imgBackground,
                // fit: BoxFit.cover,
              ),
            ),
            // child: SingleChildScrollView(
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(
            //       horizontal: 16,
            //       vertical: 32,
            //     ),
            //     child: MasonryGridView.count(
            //       physics: const NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: 100,
            //       crossAxisSpacing: 8,
            //       mainAxisSpacing: 8,
            //       padding: EdgeInsets.zero,
            //       crossAxisCount: 4,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               Image.network(
            //                 'https://play-lh.googleusercontent.com/o4Id_6NwvQcdvUzAT7D52UpThB62Hh-RzSjIZdJ9Bh1SfmzexT-JwAoa-n8r_ooGUMom=w240-h480-rw',
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     onTap: controller.startListening,
                //     borderRadius: BorderRadius.circular(100),
                //     child: Center(
                //       child: Image.asset(
                //         width: 120,
                //         height: 120,
                //         AssetConstant.imgMascot2,
                //       ),
                //     ),
                //   ),
                // ),
                // spp (serial port protocol) flutter with bluetooh,
                // compient app dan tap mobil
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Obx(() {
                        return TextFormField(
                          controller: controller.ctrlInput.value,
                          onChanged: (value) {
                            controller.ctrlInput.value.text == value;
                          },
                          decoration: kDecorationForm,
                        );
                      }),
                      //  const SizedBox(
                      //   height: 12,
                      // ),
                      // Obx(
                      //   () => TextFormField(
                      //     controller: controller.ctrlAnswer.value,
                      //     minLines: 4,
                      //     maxLines: 4,
                      //     decoration: kDecorationForm,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: TextFormField(
                //         controller: controller.ctrlInput.value,
                //         minLines: 4,
                //         maxLines: 4,
                //         decoration: kDecorationForm,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 12,
                //     ),
                //     Expanded(
                //       child: Obx(() => TextFormField(
                //             controller: controller.ctrlAnswer.value,
                //             minLines: 4,
                //             maxLines: 4,
                //             decoration: kDecorationForm,
                //           )),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 12.0,
                ),

                Container(
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
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BaseColor.green,
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
                                child: const Text(
                                  'Replay',
                                  style: TStyle.medium14,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        var text =
                            controller.ctrlInput.value.text.toLowerCase();

                        if (controller.videoList.isNotEmpty) {
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
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.gasStationList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              var gasStation = controller.gasStationList[index];
                              return terdekatCard(
                                onTap: () async {
                                  await await launchUrl(
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
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: const Text(
                                " please say something",
                                style: TStyle.medium20,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ))

                // Obx(
                //   () => controller.isListening.value
                //       ? LoadingAnimationWidget.progressiveDots(
                //           color: BaseColor.blue,
                //           size: Get.width * 0.2,
                //         )
                //       : TextFormField(
                //           controller: controller.ctrlInput.value,
                //           minLines: 4,
                //           maxLines: 4,
                //           decoration: kDecorationForm,
                //         ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.onTap,
    required this.thumbnailUrl,
    required this.title,
    required this.duration,
    required this.date,
    required this.channelImageUrl,
    required this.channelName,
    required this.subscriberCount,
  });

  final VoidCallback onTap;
  final String thumbnailUrl;
  final String title;
  final String duration;
  final String date;
  final String channelImageUrl;
  final String channelName;
  final String subscriberCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: BaseColor.softGrey,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: thumbnailUrl,
                  width: Get.width,
                  height: Get.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TStyle.medium16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "$duration | ",
                          style: TStyle.regular12.copyWith(
                            color: BaseColor.grey,
                          ),
                        ),
                        Text(
                          date,
                          style: TStyle.regular12.copyWith(
                            color: BaseColor.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: channelImageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                channelName,
                                style: TStyle.medium16,
                              ),
                              Text(
                                subscriberCount,
                                style: TStyle.regular12,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstagramCard extends StatelessWidget {
  const InstagramCard({
    super.key,
    required this.onTap,
    required this.text,
    required this.bio,
    required this.image,
  });

  final VoidCallback onTap;
  final String text;
  final String bio;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: BaseColor.softGrey,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TStyle.medium16,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        bio,
                        style: TStyle.medium14,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: BaseColor.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class terdekatCard extends StatelessWidget {
  const terdekatCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onTap;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 16,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: BaseColor.softGrey,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: TStyle.medium16,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  subtitle,
                  style: TStyle.regular12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: BaseColor.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rute',
                              style: TStyle.medium16.copyWith(
                                color: BaseColor.white,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: BaseColor.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

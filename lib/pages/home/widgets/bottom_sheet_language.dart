import 'package:dit/utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dit/controllers/home/home_controller.dart';
import 'package:dit/utilities/colors.dart';

class BottomSheetLanguageSelector extends StatelessWidget {
  BottomSheetLanguageSelector({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                    color: BaseColor.lightGrey,
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Language Options List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ChangeLanguage.values.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final language = ChangeLanguage.values[index];
                return Obx(
                  () => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.changeLanguage.value = language;
                        String languageCode =
                            controller.getLanguageCode(language);
                        controller.startListening(languageCode);
                        Get.back(); // Close the bottom sheet after selection
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.getLanguageCode(language),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: BaseColor.white,
                                border: Border.all(
                                  color: controller.changeLanguage.value ==
                                          language
                                      ? BaseColor.blue
                                      : BaseColor.lightGrey,
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: controller.changeLanguage.value == language
                                  ? Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: BaseColor.blue,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

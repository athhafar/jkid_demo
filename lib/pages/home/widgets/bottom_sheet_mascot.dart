import 'package:dit/controllers/home/home_controller.dart';
import 'package:dit/pages/home/widgets/button_primary.dart';
import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetFilter extends StatelessWidget {
  BottomSheetFilter({super.key});

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
              'Pilih Mascot',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Filter Options
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.listMascot.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Obx(
                  () => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = index;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.listMascot[index],
                              style: TStyle.medium12,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: BaseColor.white,
                                border: Border.all(
                                  color: controller.selectedIndex.value == index
                                      ? BaseColor.blue
                                      : BaseColor.lightGrey,
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: controller.selectedIndex.value == index
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
            const SizedBox(height: 20),
            ButtonPrimary(
              onTap: () {
                Get.back();
              },
              text: 'Filter',
            ),
          ],
        ),
      ),
    );
  }
}

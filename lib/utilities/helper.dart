import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DataLoad { loading, done, failed }

enum ChangeLanguage { inggris, jepang, indonesia }

class Helper {
  static setSnackbar(String message, {durations = 2}) {
    Get.snackbar(
      '',
      "",
      borderRadius: 8,
      titleText: const SizedBox(),
      margin: const EdgeInsets.all(16),
      messageText: Container(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          message,
          style: TStyle.regular12.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      padding: const EdgeInsets.only(top: 4, bottom: 6, left: 16, right: 16),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      duration: Duration(seconds: durations),
    );
  }
}

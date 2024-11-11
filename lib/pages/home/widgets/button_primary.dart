import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonPrimary extends StatelessWidget {
  ButtonPrimary({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: BaseColor.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: Text(
              text,
              style: TStyle.medium12.copyWith(
                color: BaseColor.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

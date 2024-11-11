import 'package:dit/utilities/colors.dart';
import 'package:dit/utilities/typography.dart';
import 'package:flutter/material.dart';

InputDecoration kDecorationForm = InputDecoration(
  contentPadding: const EdgeInsets.only(left: 16, right: 16),
  filled: true,
  fillColor: BaseColor.white.withOpacity(0.8),
  hintStyle: TStyle.regular14.copyWith(color: BaseColor.lightGrey),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: BaseColor.red,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: BaseColor.red,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  ),
  // errorStyle: TStyle.body.copyWith(color: kColorRed100),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  ),
);

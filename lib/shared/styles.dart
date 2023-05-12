import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

TextStyle? signUpPageTitleStyle() {
  return const TextStyle(
    color: AppColors.primaryAppColor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle? welcomeTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 65),
      fontWeight: FontWeight.bold);
}

TextStyle? faintTextStyle() {
  return const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500);
}

TextStyle? homeScreenMainTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 35),
      color: Colors.black.withOpacity(0.78));
}

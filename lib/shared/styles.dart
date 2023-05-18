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
  return TextStyle(color: AppColors.faintTextColor, fontWeight: FontWeight.w500);
}

TextStyle? homeScreenMainTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 35),
      color: AppColors.homeScreenMainTextColor);
}

TextStyle? profileScreenNameTextStyle(BuildContext context) {
return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 35),
      color: AppColors.homeScreenMainTextColor);
}

double appScreenPadding(BuildContext context) {
  return (MediaQuery.of(context).size.aspectRatio * 20);
}
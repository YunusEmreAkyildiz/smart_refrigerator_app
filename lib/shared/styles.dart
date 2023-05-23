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
      fontWeight: FontWeight.w500,
      color: AppColors.homeScreenWelcomeMessageTitleColor);
}

TextStyle? faintTextStyle() {
  return TextStyle(
      color: AppColors.faintTextColor, fontWeight: FontWeight.w500);
}

TextStyle? homeScreenMainTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 35),
      color: AppColors.homeScreenMainTextColor);
}

TextStyle? profileScreenNameTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 40),
      color: AppColors.homeScreenMainTextColor);
}

TextStyle? listTitleTextStyle() {
  return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

TextStyle? emptyFridgeTextStyle() {
  return const TextStyle(fontSize: 18);
}

TextStyle? foodDurationTextStyle() {
  return TextStyle(
      fontSize: 18,
      color: AppColors.faintTextColor,
      fontWeight: FontWeight.w500);
}

TextStyle? aboutTitleTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: (MediaQuery.of(context).size.aspectRatio * 35),
      fontWeight: FontWeight.w400);
}

TextStyle? aboutMainTextStyle(BuildContext context) {
  return TextStyle(
      fontSize: MediaQuery.of(context).size.aspectRatio * 27,
      color: Colors.black.withOpacity(0.78));
}

TextStyle? fridgeDataDateTitleTextStyle() {
  return const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

TextStyle? fridgeDataDateTextStyle() {
  return const TextStyle(fontSize: 17, fontWeight: FontWeight.w400);
}

TextStyle? fridgeDataDateDifferenceTextStyle() {
  return const TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
}

double appScreenPadding(BuildContext context) {
  return (MediaQuery.of(context).size.aspectRatio * 20);
}

EdgeInsets itemLeadingAndTitlePadding() {
  return const EdgeInsets.symmetric(horizontal: 8.0);
}

double appListTileHorizontalTitleGap() {
  return 5;
}

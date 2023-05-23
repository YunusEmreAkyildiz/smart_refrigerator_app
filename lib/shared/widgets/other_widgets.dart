import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

Widget profileDividerWidget() {
  return const Divider(
    color: AppColors.primaryAppColor,
    height: 60,
    thickness: 0.2,
  );
}

Widget foodDataDividerWidget() {
  return const Divider(
    color: AppColors.primaryAppColor,
    height: 35,
    thickness: 0.25,
  );
}

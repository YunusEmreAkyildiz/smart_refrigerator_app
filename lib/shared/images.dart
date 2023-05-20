import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

class AppImages {
  static const String logoWithNoBackground = 'assets/logo-no-background.png';
  static const String profileImageDefaultSvg = 'assets/profile_icon.svg';
}

Widget profileImageWidget() {
  return SizedBox(
    child: SvgPicture.asset(
      AppImages.profileImageDefaultSvg,
      fit: BoxFit.cover,
      color: AppColors.primaryAppColor,
    ),
  );
}

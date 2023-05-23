import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

class AppImages {
  static const String logoWithNoBackground = 'assets/logo-no-background.png';
  static const String profileImageDefaultSvg = 'assets/profile_icon.svg';

  static fridgeImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.fridgeImageBorderColor,
        //color: Colors.black54,
        width: 1.8,
      )),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
      ),
    );
  }
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

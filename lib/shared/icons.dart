import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

class AppIcons {
  static const IconData emailIcon = Icons.mail;
  static const IconData passwordIcon = Icons.lock;
  static const IconData confirmPasswordIcon = Icons.lock_reset;
  static const IconData firstNameIcon = Icons.person;
  static const IconData lastNameIcon = Icons.person;
  static const IconData homeLeadingIcon = Icons.home;
  static const IconData homeActionsAccountIcon = Icons.account_circle;
  static const IconData profileScreenBackButtonIcon = Icons.arrow_back;
  static const IconData signOutIcon = Icons.exit_to_app;
  //static const Icon fridgeContentItemIcon = Icon(Icons.food_bank, size: 30); // Previously used icon
  static const Icon fridgeContentItemIcon =
      Icon(Icons.done_outlined, color: AppColors.primaryAppColor, size: 30);
  static const Icon addedFoodIcon = Icon(
    Icons.add,
    color: Colors.green,
    size: 30,
  );
  static Icon removedFoodIcon = Icon(
    Icons.remove,
    color: Colors.red.shade100,
    size: 30,
  );
  static const Icon runOutFoodIcon = Icon(
    Icons.warning_rounded,
    //color: Colors.amber.shade700, // Alternative color
    color: Colors.red,
    size: 30,
  );
  static const Icon imageReplacerIcon = Icon(
    Icons.cloud_download,
    size: 120,
  );
  static aboutTitleIcon(BuildContext context) {
    return Icon(
      Icons.info,
      color: AppColors.profileScreenAboutTitleColor,
      size: (MediaQuery.of(context).size.aspectRatio * 45),
    );
  }
}

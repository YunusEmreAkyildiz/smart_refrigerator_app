import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

Material appButton(BuildContext context, String text, Function()? onPressed) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: AppColors.primaryAppColor,
    child: MaterialButton(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20,
            color: AppColors.buttonTextColor,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

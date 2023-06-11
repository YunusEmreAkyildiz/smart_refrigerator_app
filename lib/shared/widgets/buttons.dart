import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';

Material appButton(BuildContext context, String text, Function()? onPressed,
    {IconData? icon, bool autofocus = false}) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: AppColors.primaryAppColor,
    child: MaterialButton(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: onPressed,
      autofocus: autofocus,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: AppColors.buttonTextColor,
            ),
            const SizedBox(width: 10),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.buttonTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

ElevatedButton shopOnlineButton(String item) {
  return ElevatedButton(
              onPressed: () => shopOnline(item),
              child: const Text(AppTexts.shoppingButtonText));
}
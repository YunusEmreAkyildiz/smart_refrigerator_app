import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

Widget textFormFieldWidget(bool autofocusEnable, bool isPasswordType,
    TextEditingController controller, Icon prefixIcon, String hintText,
    {String? Function(String?)? validator,
    TextInputAction? textInputAction,
    TextInputType? inputType}) {
  return TextFormField(
    cursorColor: AppColors.primaryAppColor,
    autofocus: autofocusEnable,
    obscureText: isPasswordType,
    controller: controller,
    keyboardType: inputType ?? TextInputType.text,
    onSaved: (newValue) {
      controller.text = newValue!;
    },
    textInputAction: textInputAction ?? TextInputAction.none,
    validator: validator,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

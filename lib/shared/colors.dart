import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryAppColor = Color(0xff471AA0);
  static const Color appBackgroundColor = Color.fromARGB(255, 250, 250, 250);
  static const Color buttonTextColor = Colors.white;
  static Color? toastErrorColor = Colors.red[900];
  static Color? toastSuccessfulColor = Colors.green[700];
  static Color? faintTextColor = Colors.black54;
  static Color? homeScreenMainTextColor = Colors.black.withOpacity(0.78);
  static Color? profileScreenNameTextColor = Colors.black.withOpacity(0.78);
  static Color profileScreenAboutTitleColor = Colors.black87;
  static const MaterialColor appPrimarySwatch = MaterialColor(0xff471AA0, {
    50: Color.fromRGBO(71, 26, 160, .1),
    100: Color.fromRGBO(71, 26, 160, .2),
    200: Color.fromRGBO(71, 26, 160, .3),
    300: Color.fromRGBO(71, 26, 160, .4),
    400: Color.fromRGBO(71, 26, 160, .5),
    500: Color.fromRGBO(71, 26, 160, .6),
    600: Color.fromRGBO(71, 26, 160, .7),
    700: Color.fromRGBO(71, 26, 160, .8),
    800: Color.fromRGBO(71, 26, 160, .9),
    900: Color.fromRGBO(71, 26, 160, 1),
  });
}

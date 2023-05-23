import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/screens/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FridgeTracker',
        theme: ThemeData(
          //primaryColor: AppColors.primaryAppColor,
          primarySwatch: AppColors.appPrimarySwatch,
          //bottomAppBarColor: AppColors.appPrimarySwatch,
        ),
        home: const SignInScreen());
  }
}

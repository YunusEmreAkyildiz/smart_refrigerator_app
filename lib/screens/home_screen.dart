import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/screens/profile_screen.dart';
import 'package:smart_refrigerator_app/shared/icons.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
import 'package:smart_refrigerator_app/shared/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  Widget changeWidget1 = AppIcons.imageReplacerIcon;
  Widget changeWidget2 = const SizedBox();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        loggedInUser = UserModel.fromMap(value.data());
      } else {
        throw Exception('User document not found');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(AppIcons.homeLeadingIcon),
        leadingWidth: 45,
        title: const Text(AppTexts.homeScreenAppBarTitle),
        titleSpacing: 5,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(AppIcons.homeActionsAccountIcon),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(appScreenPadding(context)),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width),
                child: Text(
                  loggedInUser.firstName == null
                      ? 'Hello,'
                      : getWelcomeText('${loggedInUser.firstName}'),
                  style: welcomeTextStyle(context),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                AppTexts.homeScreenMainText,
                style: homeScreenMainTextStyle(context),
              ),
              const SizedBox(height: 15),
              Center(
                child: changeWidget1,
              ),
              const SizedBox(height: 30),
              Center(
                child: changeWidget2,
              ),
              const SizedBox(height: 15),
              appButton(context, AppTexts.showFridgeButtonText, () {
                setState(() {
                  debugPrint('getImage CALLED!');
                  changeWidget1 = getImage()!;
                  debugPrint('getImage FINISHED, showFridge CALLED!');
                  changeWidget2 =
                      showFridge(loggedInUser.userId.toString());
                  debugPrint('showFridge FINISHED!');
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/shared/icons.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
import 'package:smart_refrigerator_app/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool isLoading = false;
  static String url =
      'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png';
  Widget? changeWidget = Image.network(
    url,
    fit: BoxFit.fitHeight,
  );

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
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
              onPressed: () {})
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all((MediaQuery.of(context).size.aspectRatio * 20)),
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
            // const SizedBox(height: 10),
            // Text(loggedInUser.email == null ? '...' : '${loggedInUser.email}',
            //     style: faintTextStyle()),
            const SizedBox(height: 15),
            Text(
              AppTexts.homeScreenMainText,
              style: homeScreenMainTextStyle(context),
            ),
            const SizedBox(height: 15),
            Center(child: changeWidget),
            const SizedBox(height: 15),
            const Icon(
              Icons.cloud_download,
              size: 120,
            ),
            appButton(
                context,
                AppTexts.getFridgePhoto,
                isLoading
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        await getImageUrl().then((value) => setState(() {
                              url = value;
                              isLoading = false;
                            }));
                      }
                    : () {
                        setState(() {
                          const CircularProgressIndicator(
                            color: AppColors.primaryAppColor,
                          );
                        });
                      }),
            const SizedBox(height: 15),
            ActionChip(
              avatar: const Icon(AppIcons.signOutIcon),
              label: const Text(AppTexts.signOutText),
              onPressed: () {
                signOut(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

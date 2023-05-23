import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
import 'package:smart_refrigerator_app/shared/icons.dart';
import 'package:smart_refrigerator_app/shared/images.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:smart_refrigerator_app/shared/widgets/buttons.dart';
import 'package:smart_refrigerator_app/shared/widgets/other_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String firstNameText = '';
  String lastNameText = '';
  String nameText = '';
  String emailText = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        firstNameText =
            loggedInUser.firstName == null ? '' : '${loggedInUser.firstName}';
        lastNameText =
            loggedInUser.lastName == null ? '' : '${loggedInUser.lastName}';
        nameText = '$firstNameText $lastNameText';
        emailText = loggedInUser.email == null ? '' : '${loggedInUser.email}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(AppIcons.profileScreenBackButtonIcon),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        leadingWidth: 45,
        title: const Text(AppTexts.profileScreenAppBarTitle),
        titleSpacing: 5,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(appScreenPadding(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        profileImageWidget(),
                        profileDividerWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(nameText,
                                style: profileScreenNameTextStyle(context))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(emailText, style: faintTextStyle()),
                        profileDividerWidget(),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppIcons.aboutTitleIcon(context),
                                  const SizedBox(width: 5),
                                  Text(
                                    AppTexts.profileScreenAboutTitle,
                                    style: aboutTitleTextStyle(context),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppTexts.profileScreenAboutText,
                                style: aboutMainTextStyle(context),
                              ),
                            ],
                          ),
                        ),
                        profileDividerWidget(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: appButton(
                          context,
                          AppTexts.signOutText,
                          () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      AppTexts.alertDialogSignOutTitle),
                                  content: const Text(
                                      AppTexts.alertDialogSignOutContent),
                                  actions: [
                                    TextButton(
                                      child: const Text(AppTexts
                                          .alertDialogSignOutCancelText),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(AppTexts
                                          .alertDialogSignOutConfirmedText),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        signOut(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: AppIcons.signOutIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

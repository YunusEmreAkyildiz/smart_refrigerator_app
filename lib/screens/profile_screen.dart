import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/shared/icons.dart';
import 'package:smart_refrigerator_app/shared/images.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
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
        lastNameText +=
            loggedInUser.lastName == null ? '' : '${loggedInUser.lastName}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: const Icon(AppIcons.homeLeadingIcon),
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
      body: Padding(
        padding: EdgeInsets.all(appScreenPadding(context)),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    SizedBox(
                      child: SvgPicture.asset(
                        AppImages.profileImageDefaultSvg,
                        fit: BoxFit.cover,
                        color: AppColors.primaryAppColor,
                      ),
                    ),
                    profileDividerWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$firstNameText $lastNameText',
                          style: profileScreenNameTextStyle(context),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

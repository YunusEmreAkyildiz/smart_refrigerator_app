import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/constants/colors.dart';
import 'package:smart_refrigerator_app/constants/styles.dart';
import 'package:smart_refrigerator_app/constants/texts.dart';
import 'package:smart_refrigerator_app/widgets/buttons.dart';
import 'package:smart_refrigerator_app/widgets/text_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingControllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = textFormFieldWidget(false, false, firstNameController,
        const Icon(Icons.person), "First name",
        textInputAction: TextInputAction.next, inputType: TextInputType.name);
    final surnameField = textFormFieldWidget(
        false, false, lastNameController, const Icon(Icons.person), "Last name",
        textInputAction: TextInputAction.next, inputType: TextInputType.name);
    final emailField = textFormFieldWidget(
        false, false, emailController, const Icon(Icons.mail), "E-mail",
        textInputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress);
    final passwordField = textFormFieldWidget(
        false, true, passwordController, const Icon(Icons.lock), "Password",
        textInputAction: TextInputAction.next);
    final confirmPasswordField = textFormFieldWidget(
        false,
        true,
        confirmPasswordController,
        const Icon(Icons.lock_reset),
        "Confirm password",
        textInputAction: TextInputAction.done);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.signUpPageAppBarTitle,
          style: signUpPageTitleStyle(),
        ),
        titleTextStyle: const TextStyle(fontSize: 25),
        leadingWidth: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryAppColor,
      ),
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.appBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36, 25, 36, 36),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nameField,
                  const SizedBox(height: 15),
                  surnameField,
                  const SizedBox(height: 15),
                  emailField,
                  const SizedBox(height: 15),
                  passwordField,
                  const SizedBox(height: 15),
                  confirmPasswordField,
                  const SizedBox(height: 45),
                  AppButton(context, 'Sign Up', () {}),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

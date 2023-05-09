import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
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

  //Firebase Authentication
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final nameField = textFormFieldWidget(false, false, firstNameController,
        const Icon(Icons.person), "First name", validator: (value) {
      if (value!.isEmpty) {
        return ('Please enter your first name');
      }
      if (!(AppRegExps.nameRegExp).hasMatch(value)) {
        return ('Please enter a valid name with min. 3 characters');
      }
      return null;
    }, textInputAction: TextInputAction.next, inputType: TextInputType.name);
    final lastNameField = textFormFieldWidget(
        false, false, lastNameController, const Icon(Icons.person), "Last name",
        validator: (value) {
      if (value!.isEmpty) {
        return ('Please enter your last name');
      }
      if (!(AppRegExps.nameRegExp).hasMatch(value)) {
        return ('Please enter a valid name with min. 3 characters');
      }
      return null;
    }, textInputAction: TextInputAction.next, inputType: TextInputType.name);
    final emailField = textFormFieldWidget(
        false, false, emailController, const Icon(Icons.mail), "E-mail",
        validator: (value) {
      if (value!.isEmpty) {
        return ('Please enter your E-mail');
      }
      if (!(AppRegExps.emailRegExp).hasMatch(value)) {
        return ('Please enter a valid E-mail adress');
      }
      return null;
    },
        textInputAction: TextInputAction.next,
        inputType: TextInputType.emailAddress);
    final passwordField = textFormFieldWidget(
        false, true, passwordController, const Icon(Icons.lock), "Password",
        validator: (value) {
      if (value!.isEmpty) {
        return ('Please enter your password');
      }
      if (!(AppRegExps.passwordRegExp).hasMatch(value)) {
        return ('Please enter a valid password with min. 6 characters');
      }
      return null;
    }, textInputAction: TextInputAction.next);
    final confirmPasswordField = textFormFieldWidget(
        false,
        true,
        confirmPasswordController,
        const Icon(Icons.lock_reset),
        "Confirm password", validator: (value) {
      if (value!.isEmpty) {
        return ('Please confirm your password');
      }
      if (confirmPasswordController.text != passwordController.text) {
        return ("Passwords don't match!");
      }
      return null;
    }, textInputAction: TextInputAction.done);
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
                  lastNameField,
                  const SizedBox(height: 15),
                  emailField,
                  const SizedBox(height: 15),
                  passwordField,
                  const SizedBox(height: 15),
                  confirmPasswordField,
                  const SizedBox(height: 45),
                  appButton(context, 'Sign Up', () {
                    signUp(
                        emailController.text,
                        passwordController.text,
                        firstNameController.text,
                        lastNameController.text,
                        _formKey.currentState,
                        _formKey,
                        _auth,
                        context);
                  }),
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

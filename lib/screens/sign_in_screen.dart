import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/shared/images.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:smart_refrigerator_app/screens/sign_up_screen.dart';
import 'package:smart_refrigerator_app/services/functions.dart';
import 'package:smart_refrigerator_app/widgets/buttons.dart';
import 'package:smart_refrigerator_app/widgets/text_widgets.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  //TextEditingControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Firebase Authentication
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
    }, textInputAction: TextInputAction.done);
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.appBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(AppImages.logoWithNoBackground),
                    ),
                    const SizedBox(height: 45),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 45),
                    appButton(context, 'Sign In', () {
                      signIn(emailController.text, passwordController.text,
                          _formKey.currentState, _formKey, _auth, context);
                    }),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppTexts.dontHaveAnAccountText),
                        TextButton(
                          //To cancel the color that appears when the 'Sign Up' is clicked.
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.transparent;
                              }
                              return null;
                            }),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: AppColors.primaryAppColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

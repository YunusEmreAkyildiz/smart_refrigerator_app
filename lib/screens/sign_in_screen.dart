import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/constants/images.dart';
import 'package:smart_refrigerator_app/widgets/buttons.dart';
import 'package:smart_refrigerator_app/widgets/text_widgets.dart';
import 'package:smart_refrigerator_app/constants/colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = textFormFieldWidget(
        false, false, emailController, const Icon(Icons.person), "E-mail",
        textInputAction: TextInputAction.done,
        inputType: TextInputType.emailAddress);
    final passwordField = textFormFieldWidget(
        false, true, passwordController, const Icon(Icons.lock), "Password",
        textInputAction: TextInputAction.done);
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
                    AppButton(context, 'Sign In', () {}),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppTexts.dontHaveAnAccountText),
                        TextButton(
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: AppColors.primaryAppColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          onPressed: () {},
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

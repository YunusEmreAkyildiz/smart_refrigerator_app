import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_refrigerator_app/constants/colors.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/screens/home_screen.dart';
import 'package:smart_refrigerator_app/screens/sign_in_screen.dart';

Future signIn(String email, String password, FormState? currentState, formKey,
    FirebaseAuth auth, BuildContext context) async {
  String? errorMessage;
  if (formKey.currentState!.validate()) {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userId) => {
                Fluttertoast.showToast(
                    msg: 'Login successful',
                    backgroundColor: AppColors.toastSuccessfulColor),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your E-mail address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Wrong E-mail and/or password";
          break;
        case "user-not-found":
          errorMessage = "User with this E-mail doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this E-mail has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with E-mail and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(
          msg: errorMessage,
          backgroundColor: AppColors.toastErrorColor,
          toastLength: Toast.LENGTH_LONG);
      debugPrint(error.code);
    }
  }
}

Future signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    FormState? currentState,
    formKey,
    FirebaseAuth auth,
    BuildContext context) async {
  String? errorMessage;
  if (formKey.currentState!.validate()) {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(auth, firstName, lastName, context)})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Wrong password";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint(error.code);
    }
  }
}

postDetailsToFirestore(FirebaseAuth auth, String firstName, String lastName,
    BuildContext context) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = auth.currentUser;

  UserModel userModel = UserModel();

  userModel.email = user!.email;
  userModel.userId = user.uid;
  userModel.firstName = firstName;
  userModel.lastName = lastName;

  await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
  Fluttertoast.showToast(
      msg: "Account created successfully",
      backgroundColor: AppColors.toastSuccessfulColor);

  Navigator.pushAndRemoveUntil((context),
      MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
}

Future signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) => {
        Fluttertoast.showToast(
            msg: 'Successfully signed out',
            backgroundColor: AppColors.toastSuccessfulColor)
      });
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => SignInScreen()));
}
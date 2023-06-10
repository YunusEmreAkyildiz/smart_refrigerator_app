import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_refrigerator_app/model/food_list_model.dart';
import 'package:smart_refrigerator_app/model/fridge_data_model.dart';
import 'package:smart_refrigerator_app/shared/colors.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/screens/home_screen.dart';
import 'package:smart_refrigerator_app/screens/sign_in_screen.dart';
import 'package:smart_refrigerator_app/shared/icons.dart';
import 'package:smart_refrigerator_app/shared/images.dart';
import 'package:smart_refrigerator_app/shared/styles.dart';
import 'package:smart_refrigerator_app/shared/texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_refrigerator_app/shared/widgets/other_widgets.dart';

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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen())),
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
  userModel.food = [];

  await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());
  Fluttertoast.showToast(
      msg: "Account created successfully",
      backgroundColor: AppColors.toastSuccessfulColor);

  Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false);
}

Future signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) => {
        Fluttertoast.showToast(
            msg: 'Successfully signed out',
            backgroundColor: AppColors.toastSuccessfulColor),
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false)
      });
}

Future<String> getImageUrl() async {
  final storageRef = FirebaseStorage.instance.ref();
  // For unrecognized, pure image
  final pathReference = storageRef.child("${AppTexts.userAyseOzgurId}-p.jpg");
  // For recognized image
  //final pathReference = storageRef.child("${AppTexts.userAyseOzgurId}-r.jpg");
  String imageUrl;

  try {
    imageUrl = await pathReference.getDownloadURL();
    return imageUrl;
  } catch (e) {
    debugPrint(e.toString());
    return '';
  }
}

FutureBuilder? getImage() {
  return FutureBuilder(
    future: getImageUrl(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(
          color: AppColors.primaryAppColor,
        );
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        String imageUrl = snapshot.data.toString();
        return AppImages.fridgeImage(imageUrl);
      }
      return const Text(AppTexts.noImageFoundText);
    },
  );
}

Future<UserModel> getUser(String userId) async {
  // Get the current user's document from Cloud Firestore
  final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
  final userSnapshot = await userDoc.get();
  final userMap = userSnapshot.data();
  UserModel user;

  if (userMap != null) {
    user = UserModel.fromMap(userMap);
  } else {
    throw Exception(AppTexts.userDocumentNotFound);
  }
  return user;
}

Future<FridgeDataModel> getFridgeDataModelFromJson(String userId) async {
  FridgeDataModel fridgeDataModel;

  // Retrieve the JSON document from Firebase Storage
  final storageRef = FirebaseStorage.instance.ref();
  final pathReference1 = storageRef.child('${AppTexts.userAyseOzgurId}-j.json');

  try {
    // Parse the JSON document
    final url = await pathReference1.getDownloadURL();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData1 = json.decode(response.body) as Map<dynamic, dynamic>;
      fridgeDataModel = FridgeDataModel.fromJson(jsonData1);
    } else {
      throw Exception(AppTexts.failedToDownloadJson1);
    }
    return fridgeDataModel;

  } catch (e) {
    debugPrint(e.toString());
    throw Exception(e);
  }
}

void updateUserDocument(UserModel updatedUser) async {
  final userDoc =
      FirebaseFirestore.instance.collection('users').doc(updatedUser.userId);
  await userDoc.update(updatedUser.toMap());
}

Future<FoodListModel> compareFoodLists(String userId) async {
  final fridgeDataModel = await getFridgeDataModelFromJson(userId);
  debugPrint('Fridge Data Model Date: ${fridgeDataModel.date.toString()}');
  try {
    final user = await getUser(userId);
    final currentFoodList = user.food ?? [];

    // Compare the food list from the JSON document with the current food list
    final newFoodList = fridgeDataModel.food!;
    List<String> changedFoodList = [];
    List<String> foodToAddList = [];
    List<String> foodToRemoveList = [];

    // Finding items to add
    for (var food in newFoodList) {
      if (currentFoodList.contains(food)) {
        currentFoodList.remove(food);
      } else {
        foodToAddList.add(food);
        changedFoodList.add(food);
      }
    }

    // Finding items to remove
    for (var food in currentFoodList) {
      foodToRemoveList.add(food);
      changedFoodList.add(food);
    }

    debugPrint('foodToAddList: $foodToAddList');
    debugPrint('foodToRemoveList: $foodToRemoveList');

    // Update the user's document if there are changes in the food list
    if (changedFoodList.isNotEmpty) {
      user.food = newFoodList;
      final updatedUserModel = user;
      updateUserDocument(updatedUserModel);
    }

    // Show the food lists and duration in the fridge on debug console
    debugPrint('Current Food List After Ops: $currentFoodList');
    debugPrint('JSON Food List: $newFoodList');
    debugPrint('Changed Food List: $changedFoodList');
    debugPrint(
        'Food Duration (in minutes): ${fridgeDataModel.foodChangeTimeMinute}');

    final foodListModel = FoodListModel(
        newFoodList: newFoodList,
        foodToAddList: foodToAddList,
        foodToRemoveList: foodToRemoveList,
        foodChangeTimeMinute: fridgeDataModel.foodChangeTimeMinute!,
        changedFoodList: changedFoodList,
        date: fridgeDataModel.date);

    return foodListModel;
  } catch (e) {
    debugPrint(e.toString());
    throw Exception(e);
  }
}

String capitalizeFirstLetter(String text) {
  return text.substring(0, 1).toUpperCase() + text.substring(1);
}

Map<String, int> calculateItemQuantities(List<String> items) {
  Map<String, int> quantities = {};
  for (var item in items) {
    if (quantities.containsKey(item)) {
      quantities[item] = quantities[item]! + 1;
    } else {
      quantities[item] = 1;
    }
  }
  return quantities;
}

Widget buildFoodListTileItem(String item, int quantity, Icon leading,
    EdgeInsets contentPadding, double horizontalTitleGap, bool isRunOut) {
  if (quantity > 1) {
    return ListTile(
      leading: leading,
      title: isRunOut
          ? Text("Hey, ${capitalizeFirstLetter(item)} has run out!")
          : Text(capitalizeFirstLetter(item)),
      subtitle: Text(' x$quantity'),
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
    );
  } else {
    return ListTile(
      leading: leading,
      title: isRunOut
          ? Text("Hey, ${capitalizeFirstLetter(item)} has run out!")
          : Text(capitalizeFirstLetter(item)),
      contentPadding: contentPadding,
      horizontalTitleGap: horizontalTitleGap,
    );
  }
}

Column showLists(FoodListModel foodListModel) {
  debugPrint('Food List Model Date: ${foodListModel.date.toString()}');
  DateTime currentDate = DateTime.now();
  Duration dateDifference = currentDate.difference(foodListModel.date!);

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (foodListModel.newFoodList.isEmpty)
        Text(
          AppTexts.emptyFridgeMessage,
          style: emptyFridgeTextStyle(),
        )
      else
        Column(
          children: [
            foodDataDividerWidget(),
            Row(
              children: [
                Text('Date:  ', style: fridgeDataDateTitleTextStyle()),
                Text(
                  AppTexts.getFridgeDataDate(foodListModel),
                  style: fridgeDataDateTextStyle(),
                ),
                // More than 1 day difference
                if (dateDifference.inDays > 0)
                  Text('    (${dateDifference.inDays} day(s) ago)',
                      style: fridgeDataDateDifferenceTextStyle())
                // Less than 1 day, more than 1 hour difference
                else if (dateDifference.inHours > 0)
                  Text('    (${dateDifference.inHours} hour(s) ago)',
                      style: fridgeDataDateDifferenceTextStyle())
                // Less than 1 hour, more than 1 minute difference
                else
                  Text('    (${dateDifference.inMinutes} minute(s) ago)',
                      style: fridgeDataDateDifferenceTextStyle())
              ],
            ),
            foodDataDividerWidget(),
            Text(
              AppTexts.currentFoodListTitle,
              style: listTitleTextStyle(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  calculateItemQuantities(foodListModel.newFoodList).length,
              itemBuilder: (context, index) {
                final item = calculateItemQuantities(foodListModel.newFoodList)
                    .keys
                    .elementAt(index);
                final quantity =
                    calculateItemQuantities(foodListModel.newFoodList)[item];
                return buildFoodListTileItem(
                    item,
                    quantity!,
                    AppIcons.fridgeContentItemIcon,
                    itemLeadingAndTitlePadding(),
                    appListTileHorizontalTitleGap(),
                    false);
              },
            ),
            foodDataDividerWidget(),
          ],
        ),
      if (foodListModel.foodToAddList.isNotEmpty)
        Column(
          children: [
            Text(
              AppTexts.foodToAddListTitle,
              style: listTitleTextStyle(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  calculateItemQuantities(foodListModel.foodToAddList).length,
              itemBuilder: (context, index) {
                final item =
                    calculateItemQuantities(foodListModel.foodToAddList)
                        .keys
                        .elementAt(index);
                final quantity =
                    calculateItemQuantities(foodListModel.foodToAddList)[item];
                return buildFoodListTileItem(
                    item,
                    quantity!,
                    AppIcons.addedFoodIcon,
                    itemLeadingAndTitlePadding(),
                    appListTileHorizontalTitleGap(),
                    false);
              },
            ),
            foodDataDividerWidget(),
          ],
        ),
      if (foodListModel.foodToRemoveList.isNotEmpty)
        Column(
          children: [
            Text(
              AppTexts.foodToRemoveListTitle,
              style: listTitleTextStyle(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: calculateItemQuantities(foodListModel.foodToRemoveList)
                  .length,
              itemBuilder: (context, index) {
                final item =
                    calculateItemQuantities(foodListModel.foodToRemoveList)
                        .keys
                        .elementAt(index);
                final quantity = calculateItemQuantities(
                    foodListModel.foodToRemoveList)[item];
                if (!foodListModel.newFoodList.contains(item)) {
                  return buildFoodListTileItem(
                      item,
                      quantity!,
                      AppIcons.runOutFoodIcon,
                      itemLeadingAndTitlePadding(),
                      appListTileHorizontalTitleGap(),
                      true);
                }
                return buildFoodListTileItem(
                    item,
                    quantity!,
                    AppIcons.removedFoodIcon,
                    itemLeadingAndTitlePadding(),
                    appListTileHorizontalTitleGap(),
                    false);
              },
            ),
            foodDataDividerWidget(),
          ],
        ),
      Text(
        AppTexts.foodDurationMessage(foodListModel.foodChangeTimeMinute),
        style: foodDurationTextStyle(),
      ),
      foodDataDividerWidget(),
    ],
  );
}

FutureBuilder showFridge(String userId) {
  return FutureBuilder<FoodListModel>(
    future: compareFoodLists(userId),
    builder: (futureContext, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {
        final fridgeData = snapshot.data!;
        return showLists(fridgeData);
      }
      return const Text(AppTexts.noDataAvailable);
    },
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/constants/texts.dart';
import 'package:smart_refrigerator_app/model/user_model.dart';
import 'package:smart_refrigerator_app/services/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
        title: const Text(AppTexts.homeScreenAppBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text('${loggedInUser.firstName} ${loggedInUser.lastName}',
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text('${loggedInUser.email}',
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            ActionChip(
              avatar: Icon(Icons.exit_to_app),
              label: const Text('Sign Out'),
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

import 'package:flutter/material.dart';
import 'package:smart_refrigerator_app/constants/texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            const Text('Name',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            const Text('E-mail',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            ActionChip(
              label: const Text('Logout'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

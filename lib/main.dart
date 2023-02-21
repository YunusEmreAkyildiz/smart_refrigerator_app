import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final FirebaseFirestore _dbInstance = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () => dataAdd(),
              child: const Text('Data Add (no doc ID)'),
            ),
            ElevatedButton(
              onPressed: () => dataSet(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Data Set (uses doc ID)'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // dataAdd function that increments the counter
  // void dataAdd() async {
  //   Map<String, dynamic> userMap = {
  //     'name': 'Yunus Emre',
  //     'age': 24,
  //     'isStudent': true,
  //     'adress': {'city': 'Istanbul', 'province': 'Maltepe'},
  //     'colors': FieldValue.arrayUnion(['Blue', 'Green']),
  //     'createdAt': FieldValue.serverTimestamp()
  //   };
  //   await _dbInstance.collection('users').add(userMap);
  //   _incrementCounter();
  // }
}

void dataAdd() async {
  debugPrint('dataAdd CALLED!');
  Map<String, dynamic> userMap = {
    'name': 'Yunus',
    'age': 24,
    'isStudent': true,
    'adress': {'city': 'Istanbul', 'province': 'Maltepe'},
    'colors': FieldValue.arrayUnion(['Blue', 'Green']),
    'createdAt': FieldValue.serverTimestamp()
  };
  await _dbInstance.collection('users').add(userMap);
  debugPrint('dataAdd FINISHED!');
}

void dataSet() async {
  debugPrint('dataSet CALLED!');
  var newDocID = _dbInstance.collection('users').doc().id;

  await _dbInstance
      .doc('users/$newDocID')
      .set({'name': 'Emre', 'userID': newDocID});

  await _dbInstance.doc('users/G4Fei2kpDH3WP5M3CfZc').set({
    'university': 'Istanbul University - Cerrahpasa',
    'readCounter': FieldValue.increment(1)
  }, SetOptions(merge: true));
  debugPrint('dataSet FINISHED!');
}

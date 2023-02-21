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
            ElevatedButton(
              onPressed: () => dataUpdate(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700),
              child: const Text('Data Update (doc update)'),
            ),
            ElevatedButton(
              onPressed: () => dataDelete(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Data Delete (doc delete)'),
            ),
            ElevatedButton(
              onPressed: () => dataReadOneTime(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade600),
              child: const Text('Data Read (one time)'),
            ),
            ElevatedButton(
              onPressed: () => dataReadRealTime(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade900),
              child: const Text('Data Read (real time)'),
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

//Update'in set+merge'ten farkı: set için doc id'nin olması gerekmez, olmazsa oluşturur, update için id gerekir, öyle id yoksa hata fırlatır.
//Eğer Update'te verdiğimiz field document'ta yoksa o field'ı oluşturur ve verisini ekler
void dataUpdate() async {
  debugPrint('dataUpdate CALLED!');

  await _dbInstance
      .doc('users/G4Fei2kpDH3WP5M3CfZc')
      .update({'age': 26, 'adress.province': 'Avcilar'});

  debugPrint('dataUpdate FINISHED!');
}

void dataDelete() async {
  debugPrint('dataDelete CALLED!');

  //document'tı tamamen silmek için
  await _dbInstance.doc('users/32b758htQCvmkAzNgvxx').delete();
  //bir document'taki belli bir field'ı silmek için
  await _dbInstance
      .doc('users/xbnnaHn8MbFfGiDU8yoq')
      .update({'adress': FieldValue.delete()});

  debugPrint('dataDelete FINISHED!');
}

void dataReadOneTime() async {
  debugPrint('dataReadOneTime CALLED!');



  debugPrint('dataReadOneTime FINISHED!');
}

void dataReadRealTime() async {
  debugPrint('dataReadRealTime CALLED!');

  

  debugPrint('dataReadRealTime FINISHED!');
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final FirebaseFirestore _dbInstance = FirebaseFirestore.instance;
StreamSubscription? usersStreamSubscribe;

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
            ElevatedButton(
              onPressed: () => dataStreamStop(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600),
              child: const Text('Data Stream Stop (real time)'),
            ),
            ElevatedButton(
              onPressed: () => batchOp(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: const Text('Batch Operation'),
            ),
            ElevatedButton(
              onPressed: () => transactionOp(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              child: const Text('Transaction Operation'),
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

//Update'in set+merge'ten farkı: set için doc id'nin olması gerekmez, olmazsa oluşturur; update için id gerekir, öyle id yoksa hata fırlatır.
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

  var readCollection = await _dbInstance.collection('users').get();
  debugPrint(readCollection.docs.length.toString());
  for (var item in readCollection.docs) {
    debugPrint('Document ID: ${item.id}');
    Map docData = item.data();
    debugPrint(docData['university']);
  }

  var readDocument = await _dbInstance.doc('users/Ene6R954Gb6bnM80pnkX').get();
  debugPrint(readDocument.data()!['adress']['province'].toString());

  debugPrint('dataReadOneTime FINISHED!');
}

void dataReadRealTime() {
  debugPrint('dataReadRealTime CALLED!');

  //Document'ta 1 field bile değişse doc komple gelir.
  var usersStreamCollection = _dbInstance.collection('users').snapshots();
  usersStreamSubscribe = usersStreamCollection.listen((event) {
    //docChanges yerine .docs çağrılırsa, 1 doc'ta 1 field değişse bile collection'daki tüm doc'lar gelir.
    event.docChanges.forEach((element) {
      debugPrint(element.doc.data().toString());
    });
  });

  //Sadece tek belirli bir doc dinlemek için
  // var usersStreamDoc =
  //     _dbInstance.doc('users/G4Fei2kpDH3WP5M3CfZc').snapshots();
  // usersStreamSubscribe = usersStreamDoc.listen((event) {
  //   debugPrint(event.data().toString());
  // });

  debugPrint('dataReadRealTime FINISHED!');
}

void dataStreamStop() async {
  debugPrint('dataStreamStop CALLED!');

  await usersStreamSubscribe!.cancel();

  debugPrint('dataStreamStop FINISHED!');
}

void batchOp() async {
  debugPrint('batchOp CALLED!');

  WriteBatch batch = _dbInstance.batch();
  CollectionReference counterCollectionRef = _dbInstance.collection('counter');

  //Adding new docs to 'counter' collection.
  for (int i = 0; i < 100; i++) {
    var newDoc = counterCollectionRef.doc();
    batch.set(newDoc, {'Counter': ++i, 'ID': newDoc.id});
  }

  //To add a field in every doc in a collection
  // var allDocs = await counterCollectionRef.get();
  // allDocs.docs.forEach((element) {
  //   batch.update(
  //       element.reference, {'Created at': FieldValue.serverTimestamp()});
  // });

  //To delete every doc in a collection (also the collection gets deleted in the end)
  // var allDocs = await counterCollectionRef.get();
  // allDocs.docs.forEach((element) {
  //   batch.delete(element.reference);
  // });

  await batch.commit();

  debugPrint('batchOp FINISHED!');
}

void transactionOp() {
  debugPrint('transactionOp CALLED!');

  _dbInstance.runTransaction((transaction) async {
    DocumentReference<Map<String, dynamic>> docEmreRef =
        _dbInstance.doc('users/G4Fei2kpDH3WP5M3CfZc');
    DocumentReference<Map<String, dynamic>> docYunusRef =
        _dbInstance.doc('users/Ene6R954Gb6bnM80pnkX');

    var docEmreSnapshot = await transaction.get(docEmreRef);
    var emreMoneyBalance = docEmreSnapshot.data()!['moneyBalance'];
    if (emreMoneyBalance >= 100) {
      var newEmreMoneyBalance = emreMoneyBalance - 100;
      transaction.update(docEmreRef, {'moneyBalance': newEmreMoneyBalance});
      transaction
          .update(docYunusRef, {'moneyBalance': FieldValue.increment(100)});
    }
  });

  debugPrint('transactionOp FINISHED!');
}

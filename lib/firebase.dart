import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rse/all.dart';

class FB {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static DatabaseReference db(val) {
    return database.ref(val);
  }

  static dbGet(val) {
    return database.ref(val).get();
  }
}

class FS {
  static FirebaseFirestore database = FirebaseFirestore.instance;
  static db() {
    return database;
  }

  static read() async {
    await database.collection('users').get().then(
      (event) {
        for (var doc in event.docs) {
          p('${doc.id} => ${doc.data()}', icon: '🔥');
        }
      },
    );
  }

  static write(val) {
    database.collection('users').add(val).then(
          (DocumentReference doc) =>
              p('DocumentSnapshot added with ID: ${doc.id}', icon: '🔥'),
        );
  }
}

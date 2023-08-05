import 'package:firebase_database/firebase_database.dart';

class FB {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static DatabaseReference db(val) {
    return FirebaseDatabase.instance.ref(val);
  }
  static dbGet(val) {
    return FirebaseDatabase.instance.ref(val).get();
  }
}

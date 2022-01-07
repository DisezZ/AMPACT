import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  // collection reference
  final  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // update user data
  Future updateUserData(String email) async {
    return await usersCollection.doc(uid).set({
      'email': email,
    });
  }

  // get user info stream
  Stream<QuerySnapshot?> get userStream {
    return usersCollection.snapshots();
  }

}
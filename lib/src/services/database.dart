import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  // collection reference
  final  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // update user data
  Future updateUserData(String email, String role) async {
    List<String> emptyList = [];
    return await usersCollection.doc(uid).set({
      'email': email,
      'role': role,
      'firstName': '',
      'lastName':'',
      'list': [],
      'profileImage': 'https://ui-avatars.com/api/?background=387be7&color=F9F8FD&name=$email',
    });
  }

  // get user info stream
  Stream<QuerySnapshot?> get userStream {
    return usersCollection.snapshots();
  }

}
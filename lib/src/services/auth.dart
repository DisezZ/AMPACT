import 'package:firebase_auth/firebase_auth.dart';
import 'package:ampact/src/authentication/models/user_info.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create custom user from firebase user uid
  CustomUser? _customUserFromFirebaseUser(User? user) {
    if (user != null) {
      CustomUser customUser = CustomUser(uid: user.uid);
      return customUser;
    } else {
      return null;
    }
  }

  // custom user stream from firebase auth stream
  Stream<CustomUser?> get userStream {
    return _auth.authStateChanges().map((User? user) => _customUserFromFirebaseUser(user));
  }

  // sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      return  _customUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return  _customUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign up with email & password
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return  _customUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

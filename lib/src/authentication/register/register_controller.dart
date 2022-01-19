import 'package:ampact/src/app.dart';
import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:ampact/src/services/database.dart';
import 'package:ampact/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:ampact/src/services/auth.dart';

class RegisterController {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;
  final List<String>? roleList = ['caretaker', 'elderly/blinded'];
  final List<String>? roles = ['giver', 'receiver'];
  int selectedRole = 0;

  void onEmailSaved(String? email) => email = email;
  String? validateEmail(String? email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email!)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  void onPasswordChanged(String? password) => password = password;
  String? validatePassword(String? password) {
    if (password!.length < 6) {
      return 'Password must contains at least 6 characters';
    } else {
      return null;
    }
  }

  void onConfirmPasswordSaved(String? confirmPassword) =>
      confirmPassword = confirmPassword;
  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.trim() != password.text.trim()) {
      return 'Confirm password must match with given password';
    } else {
      return null;
    }
  }

  Future onRegisterPressed(BuildContext context) async {
    final bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      formKey.currentState!.save();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        await DatabaseService(uid: credential.user?.uid)
            .updateUserData(email.text.trim(), roles![selectedRole]);
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message, Colors.red);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}

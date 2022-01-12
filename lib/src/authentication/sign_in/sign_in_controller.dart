import 'package:ampact/src/app.dart';
import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:ampact/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ampact/src/authentication/register/register_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignInController {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool passwordVisibility = false;

  void onEmailSaved(String email) => email = email;
  String? validateEmail(String? email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email!)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password!.length < 6) {
      return 'Password must contains at least 6 characters';
    } else {
      return null;
    }
  }

  void onForgotPasswordPressed(BuildContext context) =>
      Navigator.pushNamed(context, '/');

  void onRegisterNowPressed(BuildContext context) =>
      Provider.of<AuthenticationProvider>(context, listen: false)
          .changeToRegister();

  Future onSignInPressed(BuildContext context) async {
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
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message, Colors.red);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}

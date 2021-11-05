import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:flutter/material.dart';

import 'package:ampact/src/services/auth.dart';

class RegisterController {

  final AuthService _auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _email = "";
  String? _password = "";
  String? _confirmPassword = "";
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;

  void onEmailSaved(String? email) => _email = email;
  String? validateEmail(String? email) {
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email!)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  void onPasswordChanged(String? password) => _password = password;
  String? validatePassword(String? password) {
    if (password!.length < 6) {
      return 'Password must contains at least 6 characters';
    } else {
      return null;
    }
  }

  void onConfirmPasswordSaved(String? confirmPassword) => _confirmPassword = confirmPassword;
  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword != _password) {
      return 'Confirm password must match with given password';
    } else {
      return null;
    }
  }

  void onBackToSignInPressed(BuildContext context) => Navigator.pushNamed(context, SignInView.routeName);

  void onRegisterPressed(BuildContext context) async {
    final bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      formKey.currentState!.save();
      dynamic result = await _auth.createUserWithEmailAndPassword(_email!, _password!);
      if (result != null) {
        print('register successfully');
        print(result);
        Navigator.pushNamed(context, HomeView.routeName);
      } else {
        print('register failed');
      }
    }
  }
}
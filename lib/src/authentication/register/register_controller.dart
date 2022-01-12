import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:provider/provider.dart';
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
  final List<String>? roleList = ['caretaker', 'elderly/blinded'];
  final List<String>? roles = ['giver', 'receiver'];
  int selectedRole = 0;

  void onEmailSaved(String? email) => _email = email;
  String? validateEmail(String? email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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

  void onConfirmPasswordSaved(String? confirmPassword) =>
      _confirmPassword = confirmPassword;
  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword != _password) {
      return 'Confirm password must match with given password';
    } else {
      return null;
    }
  }

  void onBackToSignInPressed(BuildContext context) =>
      Provider.of<AuthenticationProvider>(context, listen: false)
          .changeToSignIn();

  void onRegisterPressed(BuildContext context) async {
    final bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      formKey.currentState!.save();
      dynamic result = await _auth.createUserWithEmailAndPassword(
          _email!, _password!, roles![selectedRole]);
      if (result != null) {
        Provider.of<AuthenticationProvider>(context, listen: false)
            .changeToSignIn();
        print('register successfully');
        print(result);
      } else {
        print('register failed');
      }
    }
  }
}

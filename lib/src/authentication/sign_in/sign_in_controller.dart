import 'package:ampact/src/authentication/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:ampact/src/authentication/register/register_view.dart';
import 'package:ampact/src/navigation/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignInController {

  final AuthService _auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _email = "";
  String? _password = "";
  bool passwordVisibility = false;

  void onEmailSaved(String? email) => _email = email;
  String? validateEmail(String? email) {
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email!)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  void onPasswordSaved(String? password) => _password = password;
  String? validatePassword(String? password) {
    if (password!.length < 6) {
      return 'Password must contains at least 6 characters';
    } else {
      return null;
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  void onForgotPasswordPressed(BuildContext context) => Navigator.pushNamed(context, '/');

  void onRegisterNowPressed(BuildContext context) => Provider.of<AuthenticationProvider>(context, listen: false).changeToRegister();

  void onSignInPressed(BuildContext context) async {
    final bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      formKey.currentState!.save();
      dynamic result = await _auth.signInWithEmailAndPassword(_email!, _password!);
      if (result != null) {
        print('sign in successfully');
        print(result);
      } else {
        print('sign in failed');
      }
    }
  }
}

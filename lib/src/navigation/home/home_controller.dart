import 'package:ampact/src/authentication/sign_in/sign_in_view.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';



class HomeController {

  final AuthService _auth = AuthService();

  void onSignOutPressed(BuildContext context) async {
    dynamic result = await _auth.signOut();
    if (result != null) {
      print('sign out successfully');
      print(result);
      Navigator.pushNamed(context, SignInView.routeName);
    } else {
      print('sign out failed');
    }
  }
}
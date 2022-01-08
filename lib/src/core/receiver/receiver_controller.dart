import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';

class ReceiverController {
  final AuthService _auth = AuthService();

  void onSignOutPressed(BuildContext context) async {
    dynamic result = await _auth.signOut();
    if (result == null) {
      print('sign out successfully');
      print(result);
    } else {
      print('sign out failed');
    }
  }
}
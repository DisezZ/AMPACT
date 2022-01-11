import 'package:ampact/src/core/giver/home/giver_home_view.dart';
import 'package:ampact/src/core/giver/list/giver_list_view.dart';
import 'package:ampact/src/core/giver/notification/giver_notification_view.dart';
import 'package:ampact/src/core/profile/profile_view.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiverController {
  final AuthService _auth = AuthService();

  final iconsContent = [
    const Icon(Icons.home),
    const Icon(Icons.assignment_ind),
    const Icon(Icons.notifications),
    const Icon(Icons.account_circle),
  ];

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
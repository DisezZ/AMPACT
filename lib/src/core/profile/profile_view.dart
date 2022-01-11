import 'package:ampact/constants.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => AuthService().signOut(),
            child: const Text('Sign Out'),
            style: TextButton.styleFrom(
                primary: kTextColor
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/custom_app_bar.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final snapshot = Provider.of<DocumentSnapshot>(context);

    return Scaffold(
      appBar: CustomAppBar(
        action: GestureDetector(
          onTap: () => print('profile'),
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot['profileImage']),
            ),
          ),
        ),
        title: 'Profile Page',
      ),
    );
  }
}

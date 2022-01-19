import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/components/outlined_circle_avatar.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AmpactAppBar(
        action: GestureDetector(
          onTap: () => FirebaseAuth.instance.signOut(),
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: 'Profile',
      ),
      body: Container(
        color: theme.backgroundColor,
        padding: EdgeInsets.fromLTRB(kDefaultPadding, kDefaultPadding,
            kDefaultPadding, kDefaultPadding * 2),
        child: RoundedBorderedBox(
          child: Column(
            children: [
              SizedBox(
                width: size.width / 4,
                height: size.width / 4,
                child: OutlinedCircleAvatar(
                  imgUrl: snapshot['profileImage'],
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: kDefaultPadding / 2,
                ),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => print('Hello'),
                      child: Text(
                        'edit',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createInformationSection(
                      'Email', snapshot['email'], Icons.email),
                  createInformationSection(
                      'Phone', snapshot['phoneNumber'], Icons.phone),
                  createInformationSection(
                      'First Name', snapshot['firstName'], null),
                  createInformationSection(
                      'Last Name', snapshot['lastName'], null),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createInformationSection(
      String key, String value, IconData? iconData) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createKeySection('$key:', iconData),
          createValueText(value),
        ],
      ),
    );
  }

  Widget createKeySection(String key, IconData? iconData) {
    if (iconData == null) {
      return createKeyText(key);
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: kDefaultPadding / 2),
            child: Icon(
              iconData,
              color: Colors.grey,
            ),
          ),
          createKeyText(key),
        ],
      );
    }
  }

  Widget createKeyText(String key) {
    return Text(
      key,
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget createValueText(String value) {
    return Text(
      value == '' ? '-' : value,
      style: TextStyle(color: Colors.black),
    );
  }
}

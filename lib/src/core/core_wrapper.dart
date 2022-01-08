import 'package:ampact/src/authentication/models/user_info.dart';
import 'package:ampact/src/core/giver/giver_wrapper.dart';
import 'package:ampact/src/core/receiver/receiver_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoreWrapper extends StatefulWidget {
  const CoreWrapper({Key? key}) : super(key: key);

  @override
  _CoreWrapperState createState() => _CoreWrapperState();
}

class _CoreWrapperState extends State<CoreWrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return const Text('Loading...');
          default:
            return checkRole(snapshot);
        }
      },
    );
  }
  Widget checkRole(AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.data!['role'] == 'giver') {
      return const GiverWrapper();
    } else {
      return const ReceiverWrapper();
    }
  }
}
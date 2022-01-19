import 'package:ampact/src/core/core_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return checkRole(snapshot);
        }
      },
    );
  }

  Widget checkRole(AsyncSnapshot<DocumentSnapshot> snapshot) {
    return MultiProvider(
      providers: [
        Provider<DocumentSnapshot?>(
          create: (_) => snapshot.data,
        ),
      ],
      child: const CoreView(),
    );
  }
}

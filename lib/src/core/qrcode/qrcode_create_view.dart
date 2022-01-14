import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeCreateView extends StatefulWidget {
  const QRCodeCreateView({Key? key}) : super(key: key);

  @override
  _QRCodeCreateViewState createState() => _QRCodeCreateViewState();
}

class _QRCodeCreateViewState extends State<QRCodeCreateView> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AmpactAppBar(
        isMain: false,
        title: 'Your QRCode',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            children: [
              QrImage(
                data: uid,
              ),
              Text('Others can add you by scanning this QR Code'),
            ],
          ),
        ),
      ),
    );
  }
}

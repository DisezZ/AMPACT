import 'dart:io';

import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:ampact/src/core/party/party_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanView extends StatefulWidget {
  const QRCodeScanView({Key? key}) : super(key: key);

  @override
  _QRCodeScanViewState createState() => _QRCodeScanViewState();
}

class _QRCodeScanViewState extends State<QRCodeScanView> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final listController = PartyController();
  final uid = FirebaseAuth.instance.currentUser!.uid.trim();
  final ref = FirebaseFirestore.instance.collection('users');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          buildQRView(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(kDefaultPadding * 3),
                  child: RoundedBorderedBox(
                    child: buildInformer(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.6,
        ),
      );

  Widget buildInformer() => Text(
        barcode != null ? 'Result: ${barcode!.code}' : 'Scan QR Code',
        maxLines: 3,
        style: TextStyle(color: Colors.grey),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcode = scanData;
      });
      controller.pauseCamera();
      checkCondition();
    });
  }

  Widget buildAlertDialog(String title, String content) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
            controller!.resumeCamera();
          },
        )
      ],
    );
  }

  Widget buildConfirmationDialog(String email, DocumentReference scannerRef,
      DocumentReference targetRef, Map<String, dynamic> target) {
    return CupertinoAlertDialog(
      title: Text('Do you want to Add this user?'),
      content: Text('This will add user ${email} to your list'),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
            controller!.resumeCamera();
          },
        ),
        CupertinoDialogAction(
          child: Text('Confirm'),
          onPressed: () async {
            listController.addUserToList(uid, targetRef);
            listController.addUserToList(target['uid'], scannerRef);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }

  void checkCondition() async {
    if (!await isEqualToCurrentUser()) {
      if (await isUserExistInDatabase(ref)) {
        final targetRef = ref.doc(barcode?.code!.trim());
        final scannerRef = ref.doc(uid);
        final target = await targetRef.get().then((value) => value.data());
        final scanner = await scannerRef.get().then((value) => value.data());

        if (await isTwoUserRoleOpposite(scanner, target)) {
          if (!await isTwoUserAlreadyAdded(scanner, target)) {
            showDialog(
                context: context,
                builder: (_) => buildConfirmationDialog(
                    target!['email'], scannerRef, targetRef, target));
          }
        }
      }
    }
  }

  Future<bool> isEqualToCurrentUser() async {
    if (barcode?.code!.trim() == uid) {
      showDialog(
          context: context,
          builder: (_) => buildAlertDialog(
              'Error', 'Invalid QR Code\nPlease use another QR Code'));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isUserExistInDatabase(CollectionReference ref) async {
    return ref.get().then((value) {
      for (var i = 0; i < value.size; i++) {
        if (value.docs[i]['uid'] == barcode?.code!.trim()) {
          return true;
        }
      }
      showDialog(
          context: context,
          builder: (_) => buildAlertDialog(
              'Error', 'Invalid QR Code\nPlease use another QR Code'));
      return false;
    });
  }

  Future<bool> isTwoUserRoleOpposite(
      Map<String, dynamic>? scanner, Map<String, dynamic>? target) async {
    if (scanner!['role'] != target!['role']) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (_) => buildAlertDialog('Sorry',
              'This user\'s roles is overlap with you\nPlease use another QR Code'));
      return false;
    }
  }

  Future<bool> isTwoUserAlreadyAdded(
      Map<String, dynamic>? scanner, Map<String, dynamic>? target) async {
    final List<dynamic> list = target!['list'];
    bool found = false;
    for (var i = 0; i < list.length; i++) {
      print(list[i]);
      if (list[i] == uid) {
        found = true;
        break;
      }
    }
    if (found) {
      showDialog(
          context: context,
          builder: (_) => buildAlertDialog('Sorry',
              'This user is already in your list\nPlease use another QR Code'));
      return true;
    } else {
      return false;
    }
  }
}

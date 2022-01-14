import 'package:ampact/src/app.dart';
import 'package:ampact/src/core/live/live_view.dart';
import 'package:ampact/src/core/qrcode/qrcode_create_view.dart';
import 'package:ampact/src/core/qrcode/qrcode_scan_view.dart';
import 'package:ampact/src/core/tracking/tracking.dart';
import 'package:ampact/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GiverListController {
  void onTapPhoneCall(String number) async {
    launch('tel://$number');
  }

  void onTapTrackLocation(BuildContext context, String uid) {
    print('entering location tracking services');
    pushNewScreen(
      context,
      screen: TrackingView(uid: uid),
      withNavBar: false,
    );
  }

  void onTapLiveView(BuildContext context, String uid) {
    print('entering live view services');
    pushNewScreen(
      context,
      screen: LiveView(uid: uid),
      withNavBar: false,
    );
  }

  void onTapScanQRCode(BuildContext context, String uid) {
    print('entering scan qrcode page');
    pushNewScreen(
      context,
      screen: QRCodeScanView(),
      withNavBar: false,
    );
  }

  void onTapCreateQRCode(BuildContext context, String uid) {
    print('entering create qrcode page');
    pushNewScreen(
      context,
      screen: QRCodeCreateView(),
      withNavBar: false,
    );
  }

  Future<void> addUserToList(String uid, DocumentReference targetRef) async {
    List<dynamic> list;
    await targetRef.get().then((value) {
      list = value['list'];
      list.add(uid);
      targetRef.update({'list': list});
    });
  }

  Future<void> deleteUserFromList(
      String uid, DocumentReference targetRef) async {
    List<dynamic> list;
    await targetRef.get().then((value) {
      list = value['list'];
      list.remove(uid);
      targetRef.update({'list': list});
    });
  }
}

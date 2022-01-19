import 'package:ampact/src/core/tracking/tracking.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ReceiverPartyController {
  void onTapNotification(BuildContext context, String uid) {
    print('entering location tracking services');
    pushNewScreen(
      context,
      screen: TrackingView(uid: uid),
      withNavBar: false,
    );
  }
}

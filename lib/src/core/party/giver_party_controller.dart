import 'package:ampact/src/core/live/live_view.dart';
import 'package:ampact/src/core/tracking/tracking.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class GiverPartyController {

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
}
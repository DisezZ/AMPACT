import 'package:ampact/src/core/device/device_view.dart';
import 'package:ampact/src/core/home/home_view.dart';
import 'package:ampact/src/core/notification/notification_view.dart';
import 'package:ampact/src/core/party/party_view.dart';
import 'package:ampact/src/core/profile/profile_view.dart';
import 'package:ampact/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CoreController {
  final List<Widget> giverTabsContent = [
    const HomeView(),
    const PartyView(),
    const NotificationView(),
    const ProfileView(),
  ];

  final List<Widget> receiverTabsContent = [
    const HomeView(),
    const PartyView(),
    const DeviceView(),
    const ProfileView(),
  ];

  final List<PersistentBottomNavBarItem> giverNavBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ('Home'),
      activeColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.assignment_ind),
      title: ('Cared'),
      activeColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.notifications),
      title: ('Notify'),
      activeColorPrimary: Colors.white,
      //inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.account_circle),
      title: ('Profile'),
      activeColorPrimary: Colors.white,
    ),
  ];

  final List<PersistentBottomNavBarItem> receiverNavBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ('Home'),
      activeColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.assignment_ind),
      title: ('Watched'),
      activeColorPrimary: Colors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_max),
      title: ('Device'),
      activeColorPrimary: Colors.white,
      //inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.account_circle),
      title: ('Profile'),
      activeColorPrimary: Colors.white,
    ),
  ];

  final AuthService _auth = AuthService();

  void onSignOutPressed(BuildContext context) async {
    dynamic result = await _auth.signOut();
    if (result == null) {
      print('sign out successfully');
      print(result);
    } else {
      print('sign out failed');
    }
  }
}

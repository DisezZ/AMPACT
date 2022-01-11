import 'package:ampact/src/core/giver/home/giver_home_view.dart';
import 'package:ampact/src/core/giver/list/giver_list_view.dart';
import 'package:ampact/src/core/giver/notification/giver_notification_view.dart';
import 'package:ampact/src/core/profile/profile_view.dart';
import 'package:flutter/material.dart';

class GiverProvider with ChangeNotifier {
  int _currentIndex = 1;
  final List<Widget> _tabsContent = [
    const GiverHomeView(),
    const GiverListView(),
    const GiverNotificationView(),
    const ProfileView(),
  ];

  int get currentIndex => _currentIndex;
  List<Widget> get tabsContent => _tabsContent;

  void changeCurrentTab(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
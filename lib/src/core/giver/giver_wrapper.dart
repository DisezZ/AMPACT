import 'package:ampact/src/core/giver/giver_controller.dart';
import 'package:ampact/src/core/giver/home/giver_home_view.dart';
import 'package:ampact/src/core/giver/list/giver_list_view.dart';
import 'package:ampact/src/core/giver/notification/giver_notification_view.dart';
import 'package:ampact/src/core/navigator/navigator_view.dart';
import 'package:ampact/src/core/profile/profile_view.dart';
import 'package:flutter/material.dart';

class GiverWrapper extends StatefulWidget {
  const GiverWrapper({Key? key}) : super(key: key);

  @override
  _GiverWrapperState createState() => _GiverWrapperState();
}

class _GiverWrapperState extends State<GiverWrapper> {
  final GiverController controller = GiverController();
  int currentIndex = 0;
  final screenContent = [
    const GiverHomeView(),
    const GiverListView(),
    const GiverNotificationView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caretaker'),
        actions: [
          ElevatedButton(
            onPressed: () => controller.onSignOutPressed(context),
            child: const Text('Sign Out'),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor
            ),
          ),
        ],
      ),
      body: screenContent[currentIndex],
      bottomNavigationBar: APCustomBNB(
        items: const [
          APCustomBNBItem(iconData: Icons.home, text: 'Home'),
          APCustomBNBItem(iconData: Icons.assignment_ind, text: 'Care'),
          APCustomBNBItem(iconData: Icons.notifications, text: 'Notice'),
          APCustomBNBItem(iconData: Icons.account_circle, text: 'Profile'),
          APCustomBNBItem(iconData: Icons.add, text: 'Add'),
        ],
        backgroundColor: Colors.white,
        onTabSelected: (index) => setState(() => currentIndex = index),
        onButtonPressed: () => print(currentIndex),
      ),
    );
  }
}

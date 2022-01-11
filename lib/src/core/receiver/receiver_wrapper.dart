import 'package:ampact/src/core/navigator/navigator_view.dart';
import 'package:ampact/src/core/profile/profile_view.dart';
import 'package:ampact/src/core/receiver/device/receiver_device_view.dart';
import 'package:ampact/src/core/receiver/home/receiver_home_view.dart';
import 'package:ampact/src/core/receiver/list/receiver_list_view.dart';
import 'package:ampact/src/core/receiver/receiver_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReceiverWrapper extends StatefulWidget {
  const ReceiverWrapper({
    Key? key,
    this.snapshot,

  }) : super(key: key);

  final AsyncSnapshot<DocumentSnapshot>? snapshot;

  @override
  _ReceiverWrapperState createState() => _ReceiverWrapperState();
}

class _ReceiverWrapperState extends State<ReceiverWrapper> {
  final ReceiverController controller = ReceiverController();
  int currentIndex = 0;
  final screenContent = [
    const ReceiverHomeView(),
    const ReceiverListView(),
    const ReceiverDeviceView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elderly/Blinded'),
        actions: [
          ElevatedButton(
            onPressed: () => controller.onSignOutPressed(context),
            child: const Text('Sign Out'),
            style: ElevatedButton.styleFrom(
                primary: Theme
                    .of(context)
                    .primaryColor
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screenContent,
      ),
      bottomNavigationBar: APCustomBNB(
        items: const [
          APCustomBNBItem(iconData: Icons.home, text: 'Home'),
          APCustomBNBItem(iconData: Icons.assignment_ind, text: 'Care'),
          APCustomBNBItem(iconData: Icons.bluetooth, text: 'Device'),
          APCustomBNBItem(iconData: Icons.account_circle, text: 'Profile'),
          APCustomBNBItem(iconData: Icons.call, text: 'Call'),
        ],
        backgroundColor: Colors.white,
        onTabSelected: (index) => setState(() => currentIndex = index),
        onButtonPressed: () => print('receiver ${currentIndex}'),
      ),
    );
  }
}

import 'package:ampact/src/authentication/models/user_info.dart';
import 'package:ampact/src/core/navigator/navigator_view.dart';
import 'package:ampact/src/navigation/home/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    final userInfo = Provider.of<QuerySnapshot?>(context);
    int currentIndex = 0;
    print(user!.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: const Center(
        child: Text('Hello'),
      ),
      bottomNavigationBar: APCustomBNB(
        items: const [
          APCustomBNBItem(iconData: Icons.home, text: 'Home'),
          APCustomBNBItem(iconData: Icons.assignment_ind, text: 'Care'),
          APCustomBNBItem(iconData: Icons.notifications, text: 'Notice'),
          APCustomBNBItem(iconData: Icons.account_circle, text: 'Profile'),
          APCustomBNBItem(iconData: Icons.add, text: 'Add'),
        ],
        backgroundColor: Colors.white,
        onTabSelected: (index) => currentIndex = index,
      ),
    );
  }
}

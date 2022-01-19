import 'package:ampact/src/core/core_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CoreView extends StatefulWidget {
  const CoreView({Key? key}) : super(key: key);

  @override
  _CoreViewState createState() => _CoreViewState();
}

class _CoreViewState extends State<CoreView> {
  final controller = CoreController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final user = Provider.of<DocumentSnapshot?>(context);

    return PersistentTabView(
      context,
      //controller: _controller,
      screens: user!['role'] == 'giver'
          ? controller.giverTabsContent
          : controller.receiverTabsContent,
      items: user['role'] == 'giver'
          ? controller.giverNavBarItems
          : controller.receiverNavBarItems,
      confineInSafeArea: true,
      backgroundColor:
          Theme.of(context).primaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        colorBehindNavBar: Theme.of(context).backgroundColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

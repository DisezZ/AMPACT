import 'package:ampact/constants.dart';
import 'package:ampact/src/core/giver/giver_controller.dart';
import 'package:ampact/src/core/giver/giver_provider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class GiverWrapper extends StatefulWidget {
  const GiverWrapper({Key? key,}) : super(key: key);

  @override
  _GiverWrapperState createState() => _GiverWrapperState();
}

class _GiverWrapperState extends State<GiverWrapper> {
  final GiverController controller = GiverController();

  @override
  Widget build(BuildContext context) {
    final giverProvider = Provider.of<GiverProvider>(context);

    return PersistentTabView(
      context,
      //controller: _controller,
      screens: giverProvider.tabsContent,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).primaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        colorBehindNavBar: Theme.of(context).backgroundColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );


    /*Scaffold(
      body:
      body: IndexedStack(
        index: giverProvider.currentIndex,
        children: giverProvider.tabsContent,
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
        onTabSelected: (index) {
          Provider.of<GiverProvider>(context, listen: false).changeCurrentTab(index);
        },
        onButtonPressed: () => print(giverProvider.currentIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: controller.iconsContent,
        index: giverProvider.currentIndex,
        onTap: (index) => Provider.of<GiverProvider>(context, listen: false).changeCurrentTab(index),
        color: kPrimaryColor,
        backgroundColor: kBackgroundColor,
      ),
    );*/
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
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
        title: ('Notification'),
        activeColorPrimary: Colors.white,
        //inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle),
        title: ('Profile'),
        activeColorPrimary: Colors.white,
      ),
    ];
  }
}

import 'package:ampact/src/navigation/home/home_controller.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ElevatedButton(
            onPressed: () => controller.onSignOutPressed(context), 
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

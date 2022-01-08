import 'package:flutter/material.dart';

class GiverHomeView extends StatefulWidget {
  const GiverHomeView({Key? key}) : super(key: key);

  @override
  _GiverHomeViewState createState() => _GiverHomeViewState();
}

class _GiverHomeViewState extends State<GiverHomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Home - Giver'),
    );
  }
}

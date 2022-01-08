import 'package:flutter/material.dart';

class GiverNotificationView extends StatefulWidget {
  const GiverNotificationView({Key? key}) : super(key: key);

  @override
  _GiverNotificationViewState createState() => _GiverNotificationViewState();
}

class _GiverNotificationViewState extends State<GiverNotificationView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Notification - Giver'),
    );
  }
}

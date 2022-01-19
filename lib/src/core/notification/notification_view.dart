import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Notifications',
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        color: _theme.backgroundColor,
        child: Text('Notification'),
      ),
    );
  }
}

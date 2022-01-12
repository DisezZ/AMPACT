import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/components/custom_app_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GiverNotificationView extends StatefulWidget {
  const GiverNotificationView({Key? key}) : super(key: key);

  @override
  _GiverNotificationViewState createState() => _GiverNotificationViewState();
}

class _GiverNotificationViewState extends State<GiverNotificationView> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
        ),
        title: 'Notifications',
        action: more(),
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        color: _theme.backgroundColor,
        child: Text('Notification'),
      ),
    );
  }

  Widget more() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.more_vert),
    );
  }

  void _camera() async {
    await availableCameras().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CameraView(
              cameras: value,
            ),
          ),
        ));
  }
}

import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:flutter/material.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Device',
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        color: _theme.backgroundColor,
        child: Text('Device'),
      ),
    );
  }
}

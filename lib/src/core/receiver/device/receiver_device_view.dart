import 'package:flutter/material.dart';

class ReceiverDeviceView extends StatefulWidget {
  const ReceiverDeviceView({Key? key}) : super(key: key);

  @override
  _ReceiverDeviceViewState createState() => _ReceiverDeviceViewState();
}

class _ReceiverDeviceViewState extends State<ReceiverDeviceView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Device - Receiver'),);
  }
}

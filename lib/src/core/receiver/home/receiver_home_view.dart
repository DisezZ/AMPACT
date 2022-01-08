import 'package:flutter/material.dart';

class ReceiverHomeView extends StatefulWidget {
  const ReceiverHomeView({Key? key}) : super(key: key);

  @override
  _ReceiverHomeViewState createState() => _ReceiverHomeViewState();
}

class _ReceiverHomeViewState extends State<ReceiverHomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Home - Receiver'),);
  }
}

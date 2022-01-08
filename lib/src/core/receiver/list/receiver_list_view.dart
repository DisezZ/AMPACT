import 'package:flutter/material.dart';

class ReceiverListView extends StatefulWidget {
  const ReceiverListView({Key? key}) : super(key: key);

  @override
  _ReceiverListViewState createState() => _ReceiverListViewState();
}

class _ReceiverListViewState extends State<ReceiverListView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('List - Receiver'),);
  }
}

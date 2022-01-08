import 'package:flutter/material.dart';

class GiverListView extends StatefulWidget {
  const GiverListView({Key? key}) : super(key: key);

  @override
  _GiverListViewState createState() => _GiverListViewState();
}

class _GiverListViewState extends State<GiverListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('List - Giver'),
    );
  }
}

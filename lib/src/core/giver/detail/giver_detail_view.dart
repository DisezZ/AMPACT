import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GiverDetailView extends StatefulWidget {
  const GiverDetailView({
    Key? key,
    this.snapshot,
}) : super(key: key);
  final AsyncSnapshot<DocumentSnapshot>? snapshot;

  @override
  _GiverDetailViewState createState() => _GiverDetailViewState();
}

class _GiverDetailViewState extends State<GiverDetailView> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = widget.snapshot!.data!['list'];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(':: Detail View ::\n'),
          Text('Name: ${checkString(widget.snapshot!.data!['lastName'])} ${checkString(widget.snapshot!.data!['lastName'])}'),
          Text('Role: ${widget.snapshot!.data!['role']}\n'),
          Text('Person cared for: ${list.length}'),
        ],
      ),
    );
  }
  
  String checkString(String string) {
    return string == ''? '-' : string;
  }
}

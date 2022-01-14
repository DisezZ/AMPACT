import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:flutter/material.dart';

class LiveView extends StatefulWidget {
  final String uid;

  const LiveView({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AmpactAppBar(
        isMain: false,
        title: 'Live View',
      ),
      body: Container(),
    );
  }
}

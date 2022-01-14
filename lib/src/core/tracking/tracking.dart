import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:flutter/material.dart';

class TrackingView extends StatefulWidget {
  final String uid;

  const TrackingView({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _TrackingViewState createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AmpactAppBar(
        isMain: false,
        title: 'Tracking',
      ),
      body: Container(),
    );
  }
}

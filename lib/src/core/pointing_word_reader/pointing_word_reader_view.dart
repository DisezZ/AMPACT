import 'dart:typed_data';

import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/camera/camera_view_singleton.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/pointing_word_reader/landmark_view.dart';
import 'package:ampact/src/core/tflite/landmark.dart';
import 'package:ampact/src/core/tflite/stats.dart';
import 'package:flutter/material.dart';

class PointingWordReaderView extends StatefulWidget {
  const PointingWordReaderView({Key? key}) : super(key: key);

  @override
  _PointingWordReaderViewState createState() => _PointingWordReaderViewState();
}

class _PointingWordReaderViewState extends State<PointingWordReaderView> {
  Landmark? results;
  Stats? stats;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Pointing Word Reader',
      ),
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: 300,
            child: CameraView(
              resultsCallback: resultsCallback,
              statsCallback: statsCallback,
            ),
          ),
          results != null
              ? SizedBox(
                  width: size.width,
                  height: 300,
                  child: LandmarkView(results: results),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildStatus(Landmark? results) {
    if (results == null) {
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      );
    } else {
      return Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      );
    }
  }

  Widget keypointDots(Landmark? results) {
    if (results == null) {
      return Container();
    } else {
      return Stack(
        children: [
          for (var result in results.landmarkPoints)
            point(result.dx.toDouble(), result.dy.toDouble()),
          point(50, 50)
        ],
      );
    }
  }

  Widget point(double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
      ),
    );
  }

  void resultsCallback(Landmark? results) => setState(() {
        this.results = results;
      });

  void statsCallback(Stats stats) => setState(() {
        this.stats = stats;
      });

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

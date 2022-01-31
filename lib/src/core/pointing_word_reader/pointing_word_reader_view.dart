import 'dart:typed_data';

import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/camera/camera_view_singleton.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/pointing_word_reader/landmark_view.dart';
import 'package:ampact/src/core/pointing_word_reader/text_bounding_box_view.dart';
import 'package:ampact/src/core/tflite/landmark.dart';
import 'package:ampact/src/core/tflite/stats.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class PointingWordReaderView extends StatefulWidget {
  const PointingWordReaderView({Key? key}) : super(key: key);

  @override
  _PointingWordReaderViewState createState() => _PointingWordReaderViewState();
}

class _PointingWordReaderViewState extends State<PointingWordReaderView> {
  Landmark? results;
  Map<String, dynamic>? resultsText;
  Stats? stats;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeWidth = size.width;
    final sizeHeight = 300.0;
    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Pointing Word Reader',
        isMain: false,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: sizeWidth,
            height: sizeHeight,
            child: CameraView(
              handLandmarkResultsCallback: handLandmarkResultsCallback,
              handleRecognisedTextResultsCallback:
                  handleRecognisedTextResultsCallback,
              statsCallback: statsCallback,
            ),
          ),
          results == null
              ? Container()
              : SizedBox(
                  width: sizeWidth,
                  height: sizeHeight,
                  child: LandmarkView(results: results),
                ),
          SizedBox(
            width: sizeWidth,
            height: sizeHeight,
            child: TextBoundingBoxView(
              results: resultsText,
            ),
          ),
        ],
      ),
    );
  }

  void handLandmarkResultsCallback(Landmark? results) {
    setState(() {
      this.results = results;
    });
    if (results != null) {
      final recognisedText = resultsText!['recognisedText'];
      for (var block in recognisedText.blocks) {
        for (var line in block.lines) {
          for (var element in line.elements) {
            final points = element.cornerPoints;
            
          }
        }
      }
    }
  }

  void handleRecognisedTextResultsCallback(Map<String, dynamic> resultsText) =>
      setState(() {
        this.resultsText = resultsText;
      });

  void statsCallback(Stats stats) => setState(() {
        this.stats = stats;
      });

  void echoTTSFromText() {}

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

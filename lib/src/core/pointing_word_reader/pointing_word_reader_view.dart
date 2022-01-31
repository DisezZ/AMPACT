import 'dart:typed_data';

import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/camera/camera_view_singleton.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/pointing_word_reader/landmark_view.dart';
import 'package:ampact/src/core/pointing_word_reader/text_bounding_box_view.dart';
import 'package:ampact/src/core/tflite/landmark.dart';
import 'package:ampact/src/core/tflite/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class PointingWordReaderView extends StatefulWidget {
  const PointingWordReaderView({Key? key}) : super(key: key);

  @override
  _PointingWordReaderViewState createState() => _PointingWordReaderViewState();
}

class _PointingWordReaderViewState extends State<PointingWordReaderView> {
  final flutterTTS = FlutterTts();
  Landmark? results;
  Map<String, dynamic>? resultsText;
  Stats? stats;
  String? text;
  String? showtext;
  final sizeHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeWidth = size.width;

    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Pointing Word Reader',
        isMain: false,
      ),
      body: Column(
        children: [
          Stack(
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
          Center(
            child: Column(
              children: [
                Text(text ?? 'not found text'),
                Text(showtext ?? 'null')
              ],
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
      final size = MediaQuery.of(context).size;
      final RecognisedText recognisedText = resultsText!['recognisedText'];
      final originalSize = resultsText!['originalSize'];
      for (var block in recognisedText.blocks) {
        for (var line in block.lines) {
          for (var element in line.elements) {
            final points = element.cornerPoints;
            final pointedPointRatio = results.landmarkPoints[8];
            final pointedPoint = Offset(pointedPointRatio.dx * size.width,
                pointedPointRatio.dy * sizeHeight);
            final left = element.rect.left / originalSize.height * size.width;
            final bottom =
                element.rect.top / originalSize.width * sizeHeight + 5;
            final right = element.rect.right / originalSize.height * size.width;
            final top =
                element.rect.bottom / originalSize.width * sizeHeight + 5;
            setState(() {
              showtext = 'horizontal:: ${left} ${pointedPoint.dx} ${right}\n' +
                  'vertical:: ${bottom} ${pointedPoint.dy} ${top}';
            });
            if (pointedPoint.dx > left &&
                pointedPoint.dy < top &&
                pointedPoint.dx < right &&
                pointedPoint.dy > bottom) {
              if (text != element.text) {
                setState(() {
                  text = element.text;
                });
                _echoTTSFromText();
                print('Text:: ${text}');
              }
            }
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

  Future<void> _echoTTSFromText() async {
    print(await flutterTTS.getLanguages);
    //await flutterTTS.setLanguage('ja-JP');
    await flutterTTS.setPitch(1);
    await Future.delayed(
        Duration(milliseconds: 300), () => flutterTTS.speak(text ?? ''));
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

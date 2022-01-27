import 'dart:isolate';

import 'package:ampact/src/core/tflite/hand_landmark_services.dart';
import 'package:ampact/src/core/tflite/service_locator.dart';
import 'package:ampact/src/core/tflite/tflite_model.dart';
import 'package:ampact/src/utils/isolate_utils.dart';
import 'package:camera/camera.dart';

enum Models { handLanmark }

class ModelInferenceService {
  late TFLiteModel model;
  late Function handler;
  Map<String, dynamic>? inferenceResults;

  Future<Map<String, dynamic>?> inference({
    required IsolateUtils isolateUtils,
    required CameraImage cameraImage,
  }) async {
    final responsePort = ReceivePort();

    isolateUtils.sendMessage(
      handler: handler,
      params: {'cameraImage': cameraImage, 'modelAddress': model.getAddress},
      sendPort: isolateUtils.sendPort,
      responsePort: responsePort,
    );

    inferenceResults = await responsePort.first;
    responsePort.close();
  }

  void setModelConfig(int index) {
    switch (Models.values[index]) {
      case Models.handLanmark:
        model = locator<HandLandmark>();
        handler = runHandDetector;
    }
  }
}

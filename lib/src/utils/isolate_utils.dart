import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:ampact/src/core/tflite/classifier.dart';
import 'package:ampact/src/utils/image_utils.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateUtils {
  static const DEBUG_NAME = 'InferenceIsolate';

  late Isolate _isolate;
  SendPort? _sendPort;
  final _isolateReady = Completer<void>();

  IsolateUtils() {
    init();
  }

  Future<void> init() async {
    final receivePort = ReceivePort();
    receivePort.listen(_handleMessage);
    _isolate = await Isolate.spawn(
      _isolateEntry,
      receivePort.sendPort,
      debugName: DEBUG_NAME,
    );
  }

  static void _isolateEntry(dynamic message) async {
    SendPort sendPort;
    final receivePort = ReceivePort();

    receivePort.listen((dynamic message) async {
      if (message is IsolateData) {
        final isolateData = message;
        if (isolateData != null) {
          Classifier classifier = Classifier(
            interpreter:
                Interpreter.fromAddress(isolateData.interpreterAddress),
          );
          Image image = ImageUtils.convertCameraImage(isolateData.cameraImage);
          if (Platform.isAndroid) {
            image = copyRotate(image, 90);
          }
          Map<String, dynamic>? results = classifier.detect(image);
          isolateData.responsePort!.send(results);
        }
      }
    });

    if (message is SendPort) {
      sendPort = message;
      sendPort.send(receivePort.sendPort);
      return;
    }
  }

  void _handleMessage(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
      return;
    }
  }

  SendPort? get sendPort => _sendPort;
  Future<void> get isolateReady => _isolateReady.future;

  void dispose() {
    _isolate.kill();
  }
}

class IsolateData {
  CameraImage cameraImage;
  int interpreterAddress;
  SendPort? responsePort;

  IsolateData({
    required this.cameraImage,
    required this.interpreterAddress,
  });
}

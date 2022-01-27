import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:ampact/src/core/tflite/hand_landmark_services.dart';
import 'package:ampact/src/utils/image_utils.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:image/image.dart' as imglib;

class IsolateUtils {
  Isolate? _isolate;
  late SendPort _sendPort;
  late ReceivePort _receivePort;

  SendPort get sendPort => _sendPort;

  Future<void> initIsolate() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn<SendPort>(
      _entryPoint,
      _receivePort.sendPort,
    );

    _sendPort = await _receivePort.first;
  }

  static void _entryPoint(SendPort mainSendPort) async {
    final childReceivePort = ReceivePort();
    mainSendPort.send(childReceivePort.sendPort);

    await for (final _IsolateData? isolateData in childReceivePort) {
      if (isolateData != null) {
        final results = isolateData.handler(isolateData.params);
        isolateData.responsePort.send(results);
      }
    }
  }

  void sendMessage({
    required Function handler,
    required Map<String, dynamic> params,
    required SendPort sendPort,
    required ReceivePort responsePort,
  }) {
    final isolateData = _IsolateData(
      handler: handler,
      params: params,
      responsePort: responsePort.sendPort,
    );
    sendPort.send(isolateData);
  }

  void dispose() {
    _receivePort.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}

class _IsolateData {
  Function handler;
  Map<String, dynamic> params;
  SendPort responsePort;

  _IsolateData({
    required this.handler,
    required this.params,
    required this.responsePort,
  });
}
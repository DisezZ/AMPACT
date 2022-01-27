import 'dart:math';
import 'dart:io';
import 'dart:typed_data';

import 'package:ampact/constants.dart';
import 'package:ampact/src/core/tflite/tflite_model.dart';
import 'package:ampact/src/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as imglib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'stats.dart';
import 'landmark.dart';

// ignore: must_be_immutable
class HandLandmark extends TFLiteModel {
  HandLandmark({this.interpreter}) {
    loadModel();
  }

  final int inputSize = 224;
  final existThreshold = 0.1;
  final scoreThreshold = 0.3;

  @override
  // ignore: overridden_fields
  Interpreter? interpreter;

  @override
  List<Object> get props => [];

  @override
  int get getAddress => interpreter!.address;

  @override
  TensorImage getProcessedImage(TensorImage inputImage) {
    final imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(inputSize, inputSize, ResizeMethod.BILINEAR))
        .add(NormalizeOp(0, 255))
        .build();

    inputImage = imageProcessor.process(inputImage);
    return inputImage;
  }

  @override
  Future<void> loadModel() async {
    try {
      final interpreterOptions = InterpreterOptions();

      interpreter ??= await Interpreter.fromAsset(
        ModelFile.handLandmark,
        options: interpreterOptions..threads = 2,
      );

      final outputTensors = interpreter!.getOutputTensors();

      for (var tensor in outputTensors) {
        outputShapes.add(tensor.shape);
        outputTypes.add(tensor.type);
      }
    } catch (e) {
      print('Error while loading model interpreter');
    }
  }

  @override
  Map<String, dynamic>? runModel(imglib.Image image) {
    if (interpreter == null) {
      print('Interpreter not initialized');
      return null;
    }

    if (Platform.isAndroid) {
      image = imglib.copyRotate(image, 90);
    }
    final tensorImage = TensorImage(TfLiteType.float32);
    tensorImage.loadImage(image);
    final inputImage = getProcessedImage(tensorImage);

    TensorBuffer outputLandmarks = TensorBufferFloat(outputShapes[0]);
    TensorBuffer outputExist = TensorBufferFloat(outputShapes[1]);
    TensorBuffer outputScores = TensorBufferFloat(outputShapes[2]);
    TensorBuffer outputDimension = TensorBufferFloat(outputShapes[3]);

    final inputs = <Object>[inputImage.buffer];

    final outputs = <int, Object>{
      0: outputLandmarks.buffer,
      1: outputExist.buffer,
      2: outputScores.buffer,
      3: outputDimension,
    };

    interpreter?.runForMultipleInputs(inputs, outputs);

    if (outputExist.getDoubleValue(0) < existThreshold ||
        outputScores.getDoubleValue(0) < scoreThreshold) {
      return null;
    }

    final landmarkPoints = outputLandmarks.getDoubleList().reshape([21, 3]);
    final landmarkOffsets = <Offset>[];
    for (var point in landmarkPoints) {
      landmarkOffsets.add(Offset(
        point[0] / inputSize,
        point[1] / inputSize,
      ));
    }
    final landmark = Landmark(offsets: landmarkOffsets);

    return {'landmark': landmark};
  }
}

Map<String, dynamic>? runHandDetector(Map<String, dynamic> params) {
  final hands = HandLandmark(
      interpreter: Interpreter.fromAddress(params['modelAddress']));
  final image = ImageUtils.convertCameraImage(params['cameraImage']);
  final result = hands.runModel(image);

  return result;
}

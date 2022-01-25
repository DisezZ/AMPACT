import 'dart:math';

import 'package:image/image.dart' as imglib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'stats.dart';

class Classifier {
  late Interpreter _interpreter;

  static const String MODEL_PATH_NAME = 'model/';
  static const String MODEL_FILE_NAME = 'hand_landmark_full.tflite';
  static const int INPUT_SIZE = 224;
  static const double THRESHOLD = 0.1;
  ImageProcessor? imageProcessor;
  late int cropSize;
  late List<List<int>> _outputShapes;
  late List<TfLiteType> _outputTypes;
  static const int NUM_RESULTS = 21;

  Classifier({
    Interpreter? interpreter,
  }) {
    loadModel(interpreter: interpreter);
  }

  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            MODEL_PATH_NAME + MODEL_FILE_NAME,
            options: InterpreterOptions()..threads = 4,
          );
      var inputTensor = _interpreter.getInputTensors();
      var outputTensor = _interpreter.getOutputTensors();
      print(inputTensor.toString());
      print(outputTensor.toString());
      _outputShapes = [];
      _outputTypes = [];
      outputTensor.forEach((tensor) {
        _outputShapes.add(tensor.shape);
        _outputTypes.add(tensor.type);
      });
    } catch (e) {
      print('Error while creating tensor: $e');
    }
  }

  // Pre-process image
  TensorImage getProcessedImage(TensorImage inputImage) {
    cropSize = min(inputImage.height, inputImage.width);
    imageProcessor ??= ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.BILINEAR))
        //.add(Rot90Op(rotationDegrees ~/ 90))
        .add(NormalizeOp(127.5, 127.5))
        .add(QuantizeOp(128.0, 1 / 128.0))
        .build();
    inputImage = imageProcessor!.process(inputImage);
    return inputImage;
  }

  Map<String, dynamic>? detect(imglib.Image image) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;

    if (_interpreter == null) {
      print('Interpreter not initialized');
      return null;
    }

    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    TensorImage inputImage = TensorImage(TfLiteType.float32);
    inputImage.loadImage(image);

    inputImage = getProcessedImage(inputImage);

    var preProcessElapsedTime =
        DateTime.now().millisecondsSinceEpoch - preProcessStart;

    final inputs = [inputImage.buffer];
    print('size::${inputs[0].toString()}');

    var outputsBuffer = <TensorBuffer>[];
    for (var i = 0; i < _interpreter.getOutputTensors().length; i++) {
      outputsBuffer.add(
        TensorBuffer.createFixedSize(_outputShapes[i], _outputTypes[i]),
      );
    }

    Map<int, TensorBuffer> outputs = {};
    for (var i = 0; i < outputsBuffer.length; i++) {
      outputs[i] = outputsBuffer[i];
    }

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    try {
      _interpreter.runForMultipleInputs(inputs, outputs);
    } catch (e) {
      print('>>>> Error:: running model: $e');
    }

    var inferenceTimeElapsed =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    final list = outputs[2] as TensorBuffer;
    print('output:: ${list.toString()}');
    for (var i = 0; i < list.shape[1]; i++) {
      print('shape:: ${i} ${list.getDoubleValue(i)}');
    }
    return {'detecter': outputs};

    //int resultsCount = min(NUM_RESULTS, numLocations.getIntValue(0));
  }

  Interpreter get interpreter => _interpreter;

  void dispose() {
    _interpreter.close();
  }
}

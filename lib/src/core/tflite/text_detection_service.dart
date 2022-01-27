import 'package:ampact/src/core/tflite/tflite_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/src/image/tensor_image.dart';
import 'package:image/src/image.dart';

class TextDetection extends TFLiteModel {
  TextDetection({this.interpreter}) {
    loadModel();
  }

  final int inputSize = 224;
  final existThreshold = 0.1;

  @override
  // ignore: overridden_fields
  Interpreter? interpreter;

  @override
  List<Object> get props => [];


  @override
  int get getAddress => interpreter!.address;

  @override
  TensorImage getProcessedImage(TensorImage inputImage) {
    // TODO: implement getProcessedImage
    throw UnimplementedError();
  }

  @override
  Future<void> loadModel() {
    // TODO: implement loadModel
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? runModel(Image image) {
    // TODO: implement runModel
    throw UnimplementedError();
  }
  
}
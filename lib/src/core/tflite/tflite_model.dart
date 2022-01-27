import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

abstract class TFLiteModel extends Equatable {
  Interpreter? interpreter;

  final outputShapes = <List<int>>[];
  final outputTypes = <TfLiteType>[];

  TFLiteModel({this.interpreter});

  @override
  List<Object> get props => [];

  int get getAddress;

  Future<void> loadModel();
  TensorImage getProcessedImage(TensorImage inputImage);
  Map<String, dynamic>? runModel(image_lib.Image image);
}

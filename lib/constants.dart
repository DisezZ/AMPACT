import 'package:flutter/material.dart';

// Colors that use in our app
const kPrimaryColor = Color(0xFF387be7);
const kSecondaryColor = Color(0xFFFF9484);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 16.0;

mixin ModelFile {
  static const String directory = 'model/';
  static const handLandmark = directory + 'hand_landmark_full.tflite';
  static const textDetector = directory + 'text_detector_fp16.tflite';
}

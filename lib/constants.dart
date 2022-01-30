import 'package:flutter/material.dart';

// Colors that use in our app
const kPrimaryColor = Color(0xFF387be7);
const kSecondaryColor = Color(0xFFFF9484);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 16.0;

mixin ModelFile {
  static const String directory = 'model/';
  static const String handLandmark = directory + 'hand_landmark_full.tflite';
  static const String textDetector = directory + 'text_detector_fp16.tflite';
}

mixin ImageFile {
  static const String directory = 'images/';
  static const String flutterLogo = directory + 'flutter_logo.png';
  static const String mediapipeLogo = directory + 'mediapipe_logo.png';
  static const String firebaseLogo = directory + 'firebase_logo.png';
}

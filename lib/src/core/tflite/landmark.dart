import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class Landmark {
  late List<Offset> _landmarkPoints;
  List landmarkPairs = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [0, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [0, 9],
    [9, 10],
    [10, 11],
    [11, 12],
    [0, 13],
    [13, 14],
    [14, 15],
    [15, 16],
    [0, 17],
    [17, 18],
    [18, 19],
    [19, 20],
    [2, 5],
    [5, 9],
    [9, 13],
    [13, 17],
  ];

  Landmark({required List<Offset> offsets}) {
    _landmarkPoints = offsets;
  }

  List<Offset> get landmarkPoints => _landmarkPoints;

  set landmarkPoints(List<Offset> landmarkPoints) =>
      landmarkPoints = landmarkPoints;

  List<Offset> getLandmarkLinesOffset() {
    List<Offset> result = [];
    for (var line in landmarkPairs) {
      result.add(
          Offset(_landmarkPoints[line[0]].dx, _landmarkPoints[line[0]].dy));
      result.add(
          Offset(_landmarkPoints[line[1]].dx, _landmarkPoints[line[1]].dy));
    }
    return result;
  }
}

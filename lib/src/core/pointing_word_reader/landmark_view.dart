import 'package:ampact/src/core/tflite/landmark.dart';
import 'package:flutter/material.dart';

class LandmarkView extends StatefulWidget {
  final Landmark? results;

  const LandmarkView({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  _LandmarkViewState createState() => _LandmarkViewState();
}

class _LandmarkViewState extends State<LandmarkView> {
  @override
  Widget build(BuildContext context) {
    if (widget.results == null) {
      return Container();
    } else {
      return CustomPaint(
        foregroundPainter: LandmarkPainter(results: widget.results),
      );
    }
  }

  Widget point(double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
      ),
    );
  }
}

class LandmarkPainter extends CustomPainter {
  final Landmark? results;

  LandmarkPainter({required this.results});

  @override
  void paint(Canvas canvas, Size size) {
    final points = results!.landmarkPoints;
    final pairs = results!.landmarkPairs;
    final pointPaint = Paint()..color = Colors.red;
    final linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4;

    for (var pair in pairs) {
      canvas.drawLine(
        Offset(points[pair[0]].dx.toDouble() * size.width,
            points[pair[0]].dy.toDouble() * size.height),
        Offset(points[pair[1]].dx.toDouble() * size.width,
            points[pair[1]].dy.toDouble() * size.height),
        linePaint,
      );
    }
    for (var point in points) {
      canvas.drawCircle(
          Offset(point.dx.toDouble() * size.width,
              point.dy.toDouble() * size.height),
          3,
          pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LandmarkPainter oldDelegate) =>
      results != oldDelegate.results;
}

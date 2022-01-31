import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextBoundingBoxView extends StatefulWidget {
  final Map<String, dynamic>? results;

  const TextBoundingBoxView({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  _TextBoundingBoxViewState createState() => _TextBoundingBoxViewState();
}

class _TextBoundingBoxViewState extends State<TextBoundingBoxView> {
  @override
  Widget build(BuildContext context) {
    if (widget.results != null) {
      return CustomPaint(
        foregroundPainter: BoundingBoxPainter(results: widget.results),
      );
    } else {
      return Container();
    }
  }
}

class BoundingBoxPainter extends CustomPainter {
  final Map<String, dynamic>? results;

  BoundingBoxPainter({required this.results});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1;
    final RecognisedText recognisedText = results!['recognisedText'];
    final Size originalSize = results!['originalSize'];

    for (var block in recognisedText.blocks) {
      for (var line in block.lines) {
        for (var element in line.elements) {
          final points = element.cornerPoints;
          canvas.drawLine(
              Offset(
                  size.width - points[0].dy / originalSize.height * size.width,
                  points[0].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[1].dy / originalSize.height * size.width,
                  points[1].dx / originalSize.width * size.height),
              linePaint);
          canvas.drawLine(
              Offset(
                  size.width - points[1].dy / originalSize.height * size.width,
                  points[1].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[2].dy / originalSize.height * size.width,
                  points[2].dx / originalSize.width * size.height),
              linePaint);
          canvas.drawLine(
              Offset(
                  size.width - points[2].dy / originalSize.height * size.width,
                  points[2].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[3].dy / originalSize.height * size.width,
                  points[3].dx / originalSize.width * size.height),
              linePaint);
          canvas.drawLine(
              Offset(
                  size.width - points[3].dy / originalSize.height * size.width,
                  points[3].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[0].dy / originalSize.height * size.width,
                  points[0].dx / originalSize.width * size.height),
              linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoundingBoxPainter oldDelegate) =>
      results != oldDelegate.results;
}

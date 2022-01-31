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
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1;
    final RecognisedText recognisedText = results!['recognisedText'];
    final Size originalSize = results!['originalSize'];

    for (var block in recognisedText.blocks) {
      for (var line in block.lines) {
        for (var element in line.elements) {
          //final points = element.cornerPoints;
          final left = element.rect.left / originalSize.height * size.width;
          final bottom =
              element.rect.top / originalSize.width * size.height + 5;
          final right = element.rect.right / originalSize.height * size.width;
          final top =
              element.rect.bottom / originalSize.width * size.height + 5;

          canvas.drawLine(Offset(left, top), Offset(right, top), paint);
          canvas.drawLine(Offset(right, top), Offset(right, bottom), paint);
          canvas.drawLine(Offset(right, bottom), Offset(left, bottom), paint);
          canvas.drawLine(Offset(left, bottom), Offset(left, top), paint);

          /*canvas.drawCircle(
              Offset(
              size.width - points[0].dy / originalSize.height * size.width,
              points[0].dx / originalSize.width * size.height),
              2,
              paint);
          canvas.drawCircle(
              Offset(
                  size.width - points[2].dy / originalSize.height * size.width,
                  points[2].dx / originalSize.width * size.height),
              2,
              paint);*/
          /*canvas.drawLine(
              Offset(
                  size.width - points[0].dy / originalSize.height * size.width,
                  points[0].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[1].dy / originalSize.height * size.width,
                  points[1].dx / originalSize.width * size.height),
              paint);
          canvas.drawLine(
              Offset(
                  size.width - points[1].dy / originalSize.height * size.width,
                  points[1].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[2].dy / originalSize.height * size.width,
                  points[2].dx / originalSize.width * size.height),
              paint);
          canvas.drawLine(
              Offset(
                  size.width - points[2].dy / originalSize.height * size.width,
                  points[2].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[3].dy / originalSize.height * size.width,
                  points[3].dx / originalSize.width * size.height),
              paint);
          canvas.drawLine(
              Offset(
                  size.width - points[3].dy / originalSize.height * size.width,
                  points[3].dx / originalSize.width * size.height),
              Offset(
                  size.width - points[0].dy / originalSize.height * size.width,
                  points[0].dx / originalSize.width * size.height),
              paint);*/
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoundingBoxPainter oldDelegate) =>
      results != oldDelegate.results;
}

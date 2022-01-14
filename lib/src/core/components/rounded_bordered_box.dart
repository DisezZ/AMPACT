import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class RoundedBorderedBox extends StatelessWidget {
  final Widget? child;
  bool isPadding;

  RoundedBorderedBox({
    Key? key,
    this.child,
    this.isPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isPadding ? kDefaultPadding : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: child,
    );
  }
}

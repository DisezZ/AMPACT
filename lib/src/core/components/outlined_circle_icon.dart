import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class OutlinedCircleIcon extends StatelessWidget {
  final IconData iconData;
  bool swapColor;
  void Function()? onTap;
  OutlinedCircleIcon({
    Key? key,
    required this.iconData,
    this.swapColor = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color mainColor = theme.primaryColor;
    Color minorColor = Colors.white;
    if (swapColor) {
      mainColor = Colors.white;
      minorColor = theme.primaryColor;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: mainColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundColor: minorColor,
          child: Icon(
            iconData,
            color: mainColor,
          ),
        ),
      ),
    );
  }
}

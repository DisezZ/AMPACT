import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class OutlinedCircleAvatar extends StatelessWidget {
  final String imgUrl;
  double radius;
  Color? color;
  OutlinedCircleAvatar({
    Key? key,
    required this.imgUrl,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    color == null ? color = theme.primaryColor : null;
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imgUrl),
      ),
    );
  }
}

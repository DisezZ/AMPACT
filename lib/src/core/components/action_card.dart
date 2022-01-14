import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  String title;
  Widget? content;
  Widget? actionIcon;
  Function()? action;

  ActionCard({
    Key? key,
    this.title = '',
    this.content,
    this.actionIcon,
    this.action,
  }) : super(key: key);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return RoundedBorderedBox(
      isPadding: false,
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black,
          ),
          widget.content ?? Container(),
          
        ],
      ),
    );
  }
}

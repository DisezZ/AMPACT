import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatefulWidget {
  String title;
  Widget? content;
  IconData? actionIcon;
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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 2 - kDefaultPadding * 1.75,
      height: size.height * 0.2,
      child: RoundedBorderedBox(
        isPadding: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            widget.content == null
                ? Container()
                : Expanded(
                    child: Center(
                      child: widget.content,
                    ),
                  ),
            /*widget.actionIcon == null
                ? Container()
                : GestureDetector(
                    child: Icon(
                      widget.actionIcon,
                      size: 80,
                    ),
                    onTap: widget.action,
                  ),*/
          ],
        ),
      ),
    );
  }
}

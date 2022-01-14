import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/outlined_circle_avatar.dart';
import 'package:ampact/src/core/components/outlined_circle_icon.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:ampact/src/core/giver/list/giver_list_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpansionCard extends StatefulWidget {
  final String uid;
  final DocumentSnapshot? snapshot;
  List<Widget> actionIcons;

  ExpansionCard({Key? key, required this.uid, this.snapshot, actionIcons})
      : actionIcons = actionIcons ?? <Widget>[],
        super(key: key);

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  final controller = GiverListController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return RoundedBorderedBox(
      isPadding: false,
      child: ExpansionTile(
        collapsedIconColor: kTextColor,
        title: ListTile(
          leading: OutlinedCircleAvatar(
            imgUrl: widget.snapshot!['profileImage'],
            radius: 20,
            color: Colors.grey.withOpacity(0.5),
          ),
          title: Text(
            '${widget.snapshot!['firstName']} ${widget.snapshot!['lastName']}',
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            '${widget.snapshot!['role']} ${widget.snapshot!['uid']}',
          ),
          isThreeLine: true,
          onLongPress: () => print('delete'),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < widget.actionIcons.length; i++)
                  widget.actionIcons[i]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

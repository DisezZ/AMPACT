import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/outlined_circle_avatar.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  final DocumentSnapshot? snapshot;

  SummaryCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  _SummaryCardState createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = widget.snapshot!['list'];

    return RoundedBorderedBox(
      isPadding: false,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: OutlinedCircleAvatar(
                  imgUrl: widget.snapshot!['profileImage'],
                  radius: 30,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Text(
                  '${widget.snapshot!['firstName']} ${widget.snapshot!['lastName']}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          /*ListTile(
            leading: OutlinedCircleAvatar(
              imgUrl: widget.snapshot!['profileImage'],
            ),
            title: Text(
              '${widget.snapshot!['firstName']} ${widget.snapshot!['lastName']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),*/
          const Divider(
            color: Colors.black,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                _buildProfileSummary('Role', 'Caretaker'),
                _buildProfileSummary('Under Cared', '${list.length} People'),
                _buildProfileSummary('Notification', '0'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileSummary(String topic, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$topic:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

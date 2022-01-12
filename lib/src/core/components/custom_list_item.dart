import 'package:flutter/material.dart';

class CustomListItem extends StatefulWidget {
  const CustomListItem({Key? key}) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  bool isExpandedl = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        
      ),
    );
  }
}

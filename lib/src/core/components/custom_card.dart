import 'package:ampact/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ExpansionTile(
        collapsedIconColor: kTextColor,
        title: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              //backgroundImage: NetworkImage(snapshot['profileImage']),
              backgroundColor: theme.backgroundColor,
            ),
          ),
          title: Text(
            'Lutfee Deemae',
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            'Caretaker',
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCircleIcon(Icons.call),
                buildCircleIcon(Icons.notifications_active),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircleIcon(IconData iconData) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: theme.backgroundColor,
        child: Icon(
          iconData,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}

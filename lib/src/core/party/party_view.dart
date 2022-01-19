import 'package:ampact/constants.dart';
import 'package:ampact/src/authentication/models/user_model.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/components/expansion_card.dart';
import 'package:ampact/src/core/components/outlined_circle_icon.dart';
import 'package:ampact/src/core/components/rounded_bordered_box.dart';
import 'package:ampact/src/core/party/party_controller.dart';
import 'package:ampact/src/utils/utils.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

class PartyView extends StatefulWidget {
  const PartyView({Key? key}) : super(key: key);

  @override
  _PartyViewState createState() => _PartyViewState();
}

class _PartyViewState extends State<PartyView> {
  final controller = PartyController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final user = Provider.of<DocumentSnapshot?>(context);
    final List<dynamic> list = user!['list'];

    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Elderly/Blinded',
      ),
      body: Scrollbar(
        child: Container(
          color: theme.backgroundColor,
          padding: const EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            right: kDefaultPadding,
            bottom: kDefaultPadding * 2,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              runSpacing: kDefaultPadding,
              children: [
                for (int index = 0; index < list.length; index++)
                  _loadCardInfo(index, list[index]),
                Container(margin: EdgeInsets.only(bottom: kDefaultPadding * 4)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          animationSpeed: 300,
          overlayColor: Colors.black,
          backgroundColor: theme.primaryColor,
          children: [
            SpeedDialChild(
              child: Icon(Icons.qr_code_scanner),
              label: 'Scan QRCode',
              onTap: () => controller.onTapScanQRCode(context, user['uid']),
            ),
            SpeedDialChild(
              child: Icon(Icons.qr_code_2),
              label: 'Create QRCode',
              onTap: () => controller.onTapCreateQRCode(context, user['uid']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadCardInfo(int index, String uid) {
    final user = Provider.of<DocumentSnapshot?>(context);

    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Utils.showSnackBar('Error: ${snapshot.error}', Colors.red);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loadingIndicator();
          default:
            if (user!['role'] == 'giver') {
              return buildGiverPartyList(uid, snapshot);
            } else {
              return buildReceiverPartyList(uid, snapshot);
            }
        }
      },
    );
  }

  Widget buildGiverPartyList(
      String uid, AsyncSnapshot<DocumentSnapshot> snapshot) {
    final user = Provider.of<DocumentSnapshot?>(context);
    final List<dynamic> list = user!['list'];

    return ExpansionCard(
      uid: uid,
      snapshot: snapshot.data,
      actionIcons: [
        OutlinedCircleIcon(
          iconData: Icons.call,
          onTap: () {
            controller.onTapPhoneCall(snapshot.data!['phoneNumber']);
          },
        ),
        OutlinedCircleIcon(
          iconData: Icons.map,
          onTap: () {
            controller.onTapTrackLocation(context, uid);
          },
        ),
        OutlinedCircleIcon(
          iconData: Icons.visibility,
          onTap: () {
            controller.onTapLiveView(context, uid);
          },
        ),
      ],
    );
  }

  Widget buildReceiverPartyList(
      String uid, AsyncSnapshot<DocumentSnapshot> snapshot) {
    return ExpansionCard(
      uid: uid,
      snapshot: snapshot.data,
      actionIcons: [
        OutlinedCircleIcon(
          iconData: Icons.call,
          onTap: () {
            controller.onTapPhoneCall(snapshot.data!['phoneNumber']);
          },
        ),
        OutlinedCircleIcon(
          iconData: Icons.notification_add,
          onTap: () {
            controller.onTapNotification(context, uid);
          },
        ),
      ],
    );
  }

  Widget loadingIndicator() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 80,
      child: RoundedBorderedBox(
        child: FittedBox(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

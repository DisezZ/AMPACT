import 'package:ampact/constants.dart';
import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/components/action_card.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/components/summary_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class GiverHomeView extends StatefulWidget {
  const GiverHomeView({Key? key}) : super(key: key);

  @override
  _GiverHomeViewState createState() => _GiverHomeViewState();
}

class _GiverHomeViewState extends State<GiverHomeView> {
  final flutterTTS = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final snapshot = Provider.of<DocumentSnapshot?>(context);

    return Scaffold(
      appBar: AmpactAppBar(
        title: 'Home',
      ),
      body: Container(
          color: theme.backgroundColor,
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              SummaryCard(
                snapshot: snapshot,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width / 2 - kDefaultPadding * 1.5,
                      child: ActionCard(title: 'Google Map'),
                    ),
                    Spacer(),
                    SizedBox(
                      width: size.width / 2 - kDefaultPadding * 1.5,
                      child: ActionCard(),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _speak(),
                child: Text('TTS Pressed'),
              ),
              ElevatedButton(
                onPressed: () => _camera(),
                child: Text('Camera Pressed'),
              ),
            ],
          )),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<DocumentSnapshot?>(context);
    final size = MediaQuery.of(context).size;
    final List<dynamic> list = userInfo!['list'];

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          _buildTitle(userInfo, size),
          _buildBody(userInfo, size),
          ElevatedButton(
            onPressed: () => _speak(),
            child: Text('TTS Pressed'),
          ),
          ElevatedButton(
            onPressed: () => _camera(),
            child: Text('Camera Pressed'),
          ),
        ],
      ),
    );
  }*/

  Future _speak() async {
    print(await flutterTTS.getLanguages);
    //await flutterTTS.setLanguage('ja-JP');
    await flutterTTS.setPitch(1);
    await flutterTTS.speak('Genius');
  }

  void _camera() async {
    await availableCameras().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CameraView(
              cameras: value,
            ),
          ),
        ));
  }
/*
  Widget _buildTitle(DocumentSnapshot? userInfo, Size size) {
    return Container(
      //color: Colors.black,
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      height: size.height * 0.4,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          SafeArea(
              child: Container(
            padding: const EdgeInsets.only(
                left: kDefaultPadding,
                top: kDefaultPadding * 1.5,
                right: kDefaultPadding),
            width: size.width,
            child: Column(
              children: [
                Container(
                  width: size.width * 0.4,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.25),
                          ),
                          height: size.height * 0.01,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Image.asset('assets/images/logo_name_white.png'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: size.height * 0.22,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 5,
                    color: Theme.of(context).primaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: _buildTitleCard(userInfo, size),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleCard(DocumentSnapshot? userInfo, Size size) {
    final List<dynamic> list = userInfo!['list'];
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userInfo['profileImage']),
                  radius: 30,
                ),
              ),
              Flexible(
                flex: 8,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: kDefaultPadding),
                        child: AutoSizeText(
                          '${userInfo['firstName']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            //backgroundColor: Colors.green
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 2),
                        child: AutoSizeText(
                          '${userInfo['lastName']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            //backgroundColor: Colors.green
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 15,
            thickness: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    return Row(
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
    );
  }

  Widget _buildBody(DocumentSnapshot userInfo, Size size) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBodyCard(
                size,
                'Elderly/Blinded',
                '${userInfo['list'].length}',
                'Total',
              ),
              _buildBodyCard(
                size,
                'Notification',
                '0',
                'Total',
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBodyCard(Size size, String title, String value1, String value2) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          width: size.width * 0.4,
          height: size.height * 0.08,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.80),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 5,
                color: Theme.of(context).primaryColor.withOpacity(0.23),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          width: size.width * 0.4,
          height: size.height * 0.17,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 5,
                color: Theme.of(context).primaryColor.withOpacity(0.23),
              ),
            ],
          ),
          child: Column(
            children: [
              Spacer(),
              Text(
                value1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ),
              Spacer(),
              Text(
                value2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }*/
}

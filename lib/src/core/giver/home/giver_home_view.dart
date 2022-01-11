import 'package:ampact/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
    final userInfo = Provider.of<AsyncSnapshot<DocumentSnapshot>>(context);
    final size = MediaQuery.of(context).size;
    final List<dynamic> list = userInfo.data!['list'];
    for (var element in list) {print('care for $element');}
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          _buildTitle(userInfo, size),
          _buildBody(userInfo, size),
          ElevatedButton(
            onPressed: () => _speak(),
            child: Text('Pressed'),
          )
        ],
      ),
    );
  }

  Future _speak() async {
    print(await flutterTTS.getLanguages);
    //await flutterTTS.setLanguage('ja-JP');
    await flutterTTS.setPitch(1);
    await flutterTTS.speak('Genius');
  }

  Widget _buildTitle(AsyncSnapshot<DocumentSnapshot> userInfo, Size size) {
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
                  right: kDefaultPadding
              ),
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
                              color: Theme.of(context).backgroundColor.withOpacity(0.25),
                            ),
                            height: size.height * 0.01,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                          child: Image.asset('assets/images/logo_name_white.png'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
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
  
  Widget _buildTitleCard(AsyncSnapshot<DocumentSnapshot> userInfo, Size size) {
    final List<dynamic> list = userInfo.data!['list'];
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
                  backgroundImage: NetworkImage(userInfo.data!['profileImage']),
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
                          '${userInfo.data!['firstName']}',
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
                        padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                        child: AutoSizeText(
                          '${userInfo.data!['lastName']}',
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
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
  
  Widget _buildBody(AsyncSnapshot<DocumentSnapshot> userInfo, Size size) {
    final List<dynamic> list = Provider.of<AsyncSnapshot<DocumentSnapshot>>(context).data!['list'];
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBodyCard(userInfo, size, 'Elderly/Blinded', '${list.length}', 'Total',),
              _buildBodyCard(userInfo, size, 'Notification', '0', 'Total',),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBodyCard(AsyncSnapshot<DocumentSnapshot> userInfo, Size size, String title, String value1, String value2) {
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
                color:Theme.of(context).primaryColor.withOpacity(0.23),
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
  }
}
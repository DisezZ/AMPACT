import 'package:ampact/constants.dart';
import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/components/action_card.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/components/summary_card.dart';
import 'package:ampact/src/core/pointing_word_reader/pointing_word_reader_view.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final flutterTTS = FlutterTts();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final snapshot = Provider.of<DocumentSnapshot?>(context);

    return Scaffold(
      appBar: const AmpactAppBar(
        title: 'Home',
      ),
      body: SingleChildScrollView(
        child: Container(
            color: theme.backgroundColor,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                SummaryCard(
                  snapshot: snapshot,
                ),
                Container(
                  padding: EdgeInsets.only(top: kDefaultPadding),
                  child: Text(
                    'Powered By',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: kDefaultPadding,
                    spacing: kDefaultPadding,
                    children: [
                      ActionCard(
                        title: 'Flutter',
                        content: Image.asset('assets/' + ImageFile.flutterLogo),
                      ),
                      ActionCard(
                        title: 'Firebase',
                        content:
                            Image.asset('assets/' + ImageFile.firebaseLogo),
                      ),
                      ActionCard(
                        title: 'Mediapipe',
                        content:
                            Image.asset('assets/' + ImageFile.mediapipeLogo),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future _speak() async {
    print(await flutterTTS.getLanguages);
    //await flutterTTS.setLanguage('ja-JP');
    await flutterTTS.setPitch(1);
    await Future.delayed(
        Duration(milliseconds: 300), () => flutterTTS.speak('Genius'));
  }

  void _camera() async {
    await availableCameras().then((value) => pushNewScreen(context,
        screen: PointingWordReaderView(), withNavBar: false));
  }
}

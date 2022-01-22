import 'package:ampact/constants.dart';
import 'package:ampact/src/core/camera/camera_view.dart';
import 'package:ampact/src/core/components/action_card.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:ampact/src/core/components/summary_card.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
                    ActionCard(
                      title: '',
                      actionIcon: Icons.login,
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
            builder: (_) => Scaffold(
              appBar: AmpactAppBar(
                title: 'Camera',
              ),
              body: CameraView(),
            ),
          ),
        ));
  }
}

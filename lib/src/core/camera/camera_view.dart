import 'dart:isolate';

import 'package:ampact/src/core/tflite/classifier.dart';
import 'package:ampact/src/core/tflite/stats.dart';
import 'package:ampact/src/utils/image_utils.dart';
import 'package:ampact/src/utils/isolate_utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

class CameraView extends StatefulWidget {
  final Function(List<dynamic> detection)? resultsCallback;
  final Function(Stats stats)? statsCallback;

  const CameraView({
    Key? key,
    this.resultsCallback,
    this.statsCallback,
  }) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraController? cameraController;
  imglib.Image? image;
  CameraImage? cameraImg;
  late bool detecting;
  late Classifier classifier;
  late IsolateUtils isolateUtils;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    isolateUtils = IsolateUtils();
    classifier = Classifier();
    detecting = false;
    initializeCamera();
  }

  void initializeCamera() async {
    try {
      final cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.low,
          enableAudio: false);
      await cameraController?.initialize().then((_) async {
        if (!mounted) {
          return;
        }
        setState(() {
          cameraController!.startImageStream(onLatestImageAvailable);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: cameraController!.value.aspectRatio,
            child: CameraPreview(cameraController!),
          ),
        ],
      );
    }
    /*return FutureBuilder(
      future: initializeCamera(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
              child: Text('Camera Error'),
            );
          } else {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                ),
              ],
            );
          }
        }
      },
    );*/
  }

  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier.interpreter != null) {
      if (detecting) {
        return;
      }

      //ImageUtils.saveImage(ImageUtils.convertCameraImage(cameraImage));

      setState(() {
        detecting = true;
      });

      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;

      var isolateData = IsolateData(
        cameraImage: cameraImage,
        interpreterAddress: classifier.interpreter.address,
      );

      Map<String, dynamic> inferenceResults = await inference(isolateData);

      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;

      /*setState(() {
        detecting = false;
      });*/
    }
  }

  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils.sendPort
        ?.send(isolateData..responsePort = responsePort.sendPort);
    var result = await responsePort.first;
    return result;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController!.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    cameraController!.dispose();
    super.dispose();
  }
}

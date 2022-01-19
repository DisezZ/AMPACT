import 'dart:developer';
import 'package:ampact/constants.dart';
import 'package:ampact/src/core/components/ampact_app_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    this.cameras,
    Key? key,
  }) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController controller;
  late CameraImage image;

  @override
  void initState() {
    super.initState();
    loadModel();
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.startImageStream((image) {
          image = image;
          runModel();
        });
      });
    });
  }

  @override
  void dispose() async {
    Tflite.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AmpactAppBar(
        isMain: false,
        title: 'Camera',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Center(
              child: SizedBox(
                height: 300,
                width: 400,
                child: CameraPreview(controller),
              ),
            ),
          )
        ],
      ),
    );
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/hand_landmark_full.tflite',
      //labels: 'assets/model/mobilenet_v1_1.0_224.txt',
    );
  }

  runModel() async {
    if (image != null) {
      var estimations = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      estimations!.forEach((element) {
        setState(() {});
      });
      inspect(estimations);
      print(estimations);
    }
  }
}

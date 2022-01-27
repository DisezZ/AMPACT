import 'package:ampact/src/core/tflite/landmark.dart';
import 'package:ampact/src/core/tflite/model_inference_service.dart';
import 'package:ampact/src/core/tflite/service_locator.dart';
import 'package:ampact/src/core/tflite/stats.dart';
import 'package:ampact/src/utils/isolate_utils.dart';
import 'package:ampact/src/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final Function(Landmark? results)? resultsCallback;
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
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  late CameraDescription _cameraDescription;

  late bool _detecting;

  late ModelInferenceService _modelInferenceService;
  late IsolateUtils _isolateUtils;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _modelInferenceService = locator<ModelInferenceService>();
    _initStateAsync();
  }

  void _initStateAsync() async {
    _isolateUtils = IsolateUtils();
    await _isolateUtils.initIsolate();
    await _initCamera();
    _detecting = false;
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _cameraDescription = _cameras[0];
    _cameraController = CameraController(
        _cameraDescription, ResolutionPreset.low,
        enableAudio: false);
    _cameraController!.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController!.value.hasError) {
        Utils.showSnackBar(
          'Camera error ${_cameraController!.value.errorDescription}',
          Colors.red,
        );
      }
    });
    try {
      await _cameraController?.initialize().then((_) async {
        _cameraController!.startImageStream(onLatestImageAvailable);
      });
    } catch (e) {
      Utils.showSnackBar(
        'Camera error ${_cameraController!.value.errorDescription}',
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return CameraPreview(_cameraController!);
    }
  }

  onLatestImageAvailable(CameraImage cameraImage) async {
    _modelInferenceService.setModelConfig(0);
    await _inference(cameraImage: cameraImage);
  }

  Future<void> _inference({required CameraImage cameraImage}) async {
    _modelInferenceService.setModelConfig(0);
    if (_modelInferenceService.model.interpreter != null && !_detecting) {
      setState(() {
        _detecting = true;
      });

      await _modelInferenceService.inference(
        isolateUtils: _isolateUtils,
        cameraImage: cameraImage,
      );
      final inferenceResults = _modelInferenceService.inferenceResults;
      if (inferenceResults != null) {
        widget.resultsCallback!(inferenceResults['landmark']);
      } else {
        widget.resultsCallback!(null);
      }
      setState(() {
        _detecting = false;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        _cameraController!.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!_cameraController!.value.isStreamingImages) {
          await _cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _cameraController?.dispose();
    _cameraController = null;
    _isolateUtils.dispose();
    _modelInferenceService.inferenceResults = null;
    super.dispose();
  }
}

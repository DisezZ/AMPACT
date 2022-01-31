import 'package:ampact/src/core/tflite/hand_landmark_services.dart';
import 'package:ampact/src/core/tflite/model_inference_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<HandLandmark>(HandLandmark());
  //locator.registerSingleton<FaceMesh>(FaceMesh());
  //locator.registerSingleton<TextRecognition>(TextRecognition());
  //locator.registerSingleton<Pose>(Pose());

  locator.registerLazySingleton<ModelInferenceService>(
      () => ModelInferenceService());
}

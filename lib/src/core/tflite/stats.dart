/// Bundles different elapsed times
class Stats {
  static late int startTime;

  /// Total time taken in the isolate where the inference runs
  int totalPredictTime;

  /// [totalPredictTime] + communication overhead time
  /// between main isolate and another isolate
  int? totalElapsedTime;

  /// Time for which inference runs
  int inferenceTime;

  /// Time taken to pre-process the image
  int preProcessingTime;

  Stats(
      {required this.totalPredictTime,
      this.totalElapsedTime,
      required this.inferenceTime,
      required this.preProcessingTime});

  void startNewTimer() => startTime = DateTime.now().millisecondsSinceEpoch;

  int getElapsedTime() => DateTime.now().millisecondsSinceEpoch - startTime;

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, totalElapsedTime: $totalElapsedTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}

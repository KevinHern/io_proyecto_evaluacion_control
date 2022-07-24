import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

abstract class LearningCurveManagementContract {
  LearningCurve createInitialConditions({
    required double learningRate,
    required double firstSequenceTime,
    required int maxSequenceNumber,
  });
  LearningCurve createNIteration({
    required int sequenceNumber,
    required double sequenceTime,
    required double firstSequenceTime,
    required int maxSequenceNumber,
  });
  LearningCurve create2Samples({
    required int aSequenceNumber,
    required double aSequenceTime,
    required int bSequenceNumber,
    required double bSequenceTime,
    required int maxSequenceNumber,
  });
  String toJson({required LearningCurve learningCurve});
  OperationResult createSeries({required String encodedJson});
}

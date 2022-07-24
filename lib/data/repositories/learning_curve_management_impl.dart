import 'dart:convert';

import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

import '../../domain/repositories/learning_curve_management_contract.dart';

class LearningCurveManagementImpl implements LearningCurveManagementContract {
  @override
  LearningCurve createInitialConditions({
    required double learningRate,
    required double firstSequenceTime,
    required int maxSequenceNumber,
  }) =>
      LearningCurve(
        type: SubScreenType.LC_INITIAL_CONDITIONS,
        maxSequenceNumber: maxSequenceNumber,
        learningRate: learningRate,
        firstSequenceTime: firstSequenceTime,
      );

  @override
  LearningCurve createNIteration({
    required int sequenceNumber,
    required double sequenceTime,
    required double firstSequenceTime,
    required int maxSequenceNumber,
  }) =>
      LearningCurve(
        type: SubScreenType.LC_N_ITERATION,
        maxSequenceNumber: maxSequenceNumber,
        sequenceNumber: sequenceNumber,
        sequenceTime: sequenceTime,
        firstSequenceTime: firstSequenceTime,
      );

  @override
  LearningCurve create2Samples({
    required int aSequenceNumber,
    required double aSequenceTime,
    required int bSequenceNumber,
    required double bSequenceTime,
    required int maxSequenceNumber,
  }) =>
      LearningCurve(
        type: SubScreenType.LC_TWO_SAMPLES,
        maxSequenceNumber: maxSequenceNumber,
        aSequenceNumber: aSequenceNumber,
        aSequenceTime: aSequenceTime,
        bSequenceNumber: bSequenceNumber,
        bSequenceTime: bSequenceTime,
      );

  @override
  String toJson({required LearningCurve learningCurve}) =>
      jsonEncode(learningCurve.toMap());

  @override
  OperationResult createSeries({required String encodedJson}) {
    // Deserialize Json
    final decodedSeries = jsonDecode(encodedJson);

    // Create Series
    List<LearningCurveData> series = [];
    for (final Map<dynamic, dynamic> seriesPoint in decodedSeries["series"]) {
      // Map each JSON object to the model
      final OperationResult result =
          LearningCurveData.mapToModel(map: seriesPoint);

      if (result.success) {
        series.add(result.returnedObject as LearningCurveData);
      } else {
        return result;
      }
    }

    return OperationResult(success: true, returnedObject: series);
  }
}

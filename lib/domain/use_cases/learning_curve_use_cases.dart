// Models
import 'package:flutter/services.dart';
import 'package:flutter_web_app/data/datasources/python_server.dart';
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

import '../../ui/models/subscreen_managerUI.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/domain/repositories/learning_curve_management_contract.dart';

class LearningCurveUseCases {
  final PythonServerDatasource _datasource;
  final LearningCurveManagementContract _learningCurveManagementContract;
  LearningCurveUseCases({
    required LearningCurveManagementContract repository,
    required PythonServerDatasource datasource,
  })  : _learningCurveManagementContract = repository,
        _datasource = datasource;

  Future<OperationResult> getLearningCurve({
    required SubScreenType type,
    required int maxSequenceNumber,
    double? learningRate,
    int? sequenceNumber,
    double? sequenceTime,
    int? aSequenceNumber,
    int? bSequenceNumber,
    double? aSequenceTime,
    double? bSequenceTime,
    double? firstSequenceTime,
    bool example = false,
  }) async {
    // Creating Model
    late final LearningCurve learningCurve;

    switch (type) {
      case SubScreenType.LC_INITIAL_CONDITIONS:
        learningCurve =
            _learningCurveManagementContract.createInitialConditions(
                learningRate: learningRate!,
                firstSequenceTime: firstSequenceTime!,
                maxSequenceNumber: maxSequenceNumber);
        break;
      case SubScreenType.LC_N_ITERATION:
        learningCurve = _learningCurveManagementContract.createNIteration(
          sequenceNumber: sequenceNumber!,
          sequenceTime: sequenceTime!,
          firstSequenceTime: firstSequenceTime!,
          maxSequenceNumber: maxSequenceNumber,
        );
        break;
      case SubScreenType.LC_TWO_SAMPLES:
        learningCurve = _learningCurveManagementContract.create2Samples(
          aSequenceNumber: aSequenceNumber!,
          aSequenceTime: aSequenceTime!,
          bSequenceNumber: bSequenceNumber!,
          bSequenceTime: bSequenceTime!,
          maxSequenceNumber: maxSequenceNumber,
        );
        break;
      default:
        throw Exception(
            "Error in Learning Curve Use Cases: Unknown subscreen type detected");
    }

    late final OperationResult backendResult;

    if (!example) {
      // Sending Request
      backendResult = await _datasource.sendJsonToServer(
        encodedObject: _learningCurveManagementContract.toJson(
            learningCurve: learningCurve),
      );
    } else {
      final String encodedJson =
          await rootBundle.loadString("assets/test_json.json");
      backendResult =
          OperationResult(success: true, returnedObject: encodedJson);
    }

    // Checking result
    if (backendResult.success) {
      // Everything went smooth, proceed to decode JSON and make Graph Model
      final OperationResult mapResult =
          _learningCurveManagementContract.createSeries(
        encodedJson: backendResult.returnedObject as String,
      );

      if (mapResult.success) {
        return OperationResult(
            success: true,
            message: "Curva de Aprendizaje calculada correctamente.",
            returnedObject:
                mapResult.returnedObject as List<LearningCurveData>);
      } else {
        return mapResult;
      }
    } else {
      // An error happened in the backend, propagate it
      return backendResult;
    }
  }
}

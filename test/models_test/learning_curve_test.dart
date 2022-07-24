// Basic Imports
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

void main() {
  group(
    'Learning Curve Model Tests',
    () {
      group(
        "'toMap()' function tests",
        () {
          test(
            "Should return a Map<String, dynamic> when 'toMap' is called on a LC_INITIAL_CONDITIONS Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve learningCurve = LearningCurve(
                type: SubScreenType.LC_INITIAL_CONDITIONS,
                learningRate: 0.8,
                firstSequenceTime: 1000,
                maxSequenceNumber: 50,
              );
              final Map<String, dynamic> expectedResult = {
                "type": 0,
                "learningRate": 0.8,
                "time": 1000,
                "maxSequence": 50,
              };

              // Test
              final result = learningCurve.toMap();

              // Evaluate
              expect(result, expectedResult);
            },
          );

          test(
            "Should return a Map<String, dynamic> when 'toMap' is called on a LC_N_ITERATION Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve learningCurve = LearningCurve(
                type: SubScreenType.LC_N_ITERATION,
                maxSequenceNumber: 50,
                sequenceNumber: 12,
                sequenceTime: 572,
                firstSequenceTime: 1100,
              );
              final Map<String, dynamic> expectedResult = {
                "type": 1,
                "sequenceNumber": 12,
                "sequenceTime": 572,
                "firstSequenceTime": 1100,
                "maxSequence": 50,
              };

              // Test
              final result = learningCurve.toMap();

              // Evaluate
              expect(result, expectedResult);
            },
          );

          test(
            "Should return a Map<String, dynamic> when 'toMap' is called on a lc_TWO_SAMPLES Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve learningCurve = LearningCurve(
                type: SubScreenType.LC_TWO_SAMPLES,
                maxSequenceNumber: 50,
                aSequenceNumber: 14,
                aSequenceTime: 25,
                bSequenceNumber: 35,
                bSequenceTime: 20,
              );
              final Map<String, dynamic> expectedResult = {
                "type": 2,
                "aSequenceNumber": 14,
                "bSequenceNumber": 35,
                "aSequenceTime": 25,
                "bSequenceTime": 20,
                "maxSequence": 50,
              };

              // Test
              final result = learningCurve.toMap();

              // Evaluate
              expect(result, expectedResult);
            },
          );
        },
      );
    },
  );

  group(
    'Learning Curve Data Model Tests',
    () {
      group(
        "'mapToModel()' constructor tests",
        () {
          test(
            "Should return a successful OperationResult Model when 'mapToModel'"
            "is called on a compatible Map<dynamic, dynamic> Map with correct datatypes",
            () {
              // Prepare Data
              final Map<dynamic, dynamic> dummyMap = {
                "y1Time": 405,
                "y2AccumulatedTime": 789,
                "xSequence": 27,
              };

              const LearningCurveData expectedResult = LearningCurveData(
                y1Time: 405,
                y2AccumulatedTime: 789,
                xSequence: 27,
              );

              // Test
              final result = LearningCurveData.mapToModel(map: dummyMap);

              // Evaluate
              expect(result.success, true);
              expect(result.returnedObject, expectedResult);
            },
          );

          test(
            "Should return a failed OperationResult Model when 'mapToModel' "
            "is called on a compatible Map<dynamic, dynamic> Map with wrong datatypes",
            () {
              // Prepare Data
              final Map<dynamic, dynamic> dummyMap = {
                "y1Time": 'hola',
                "y2AccumulatedTime": 789,
                "xSequence": 27,
              };

              final String expectedMessage =
                  "Un error ocurrió durante la deserialización del JSON. Un JSON Object llegó de la siguiente forma:\n${dummyMap.toString()}";

              // Test
              final result = LearningCurveData.mapToModel(map: dummyMap);

              // Evaluate
              expect(result.success, false);
              expect(result.message, expectedMessage);
            },
          );
        },
      );
    },
  );
}

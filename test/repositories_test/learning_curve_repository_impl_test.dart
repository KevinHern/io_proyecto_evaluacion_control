// Basic Imports
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Models
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/domain/repositories/learning_curve_management_contract.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Learning Curve Repository IMPL Tests',
    () {
      group(
        "LearningCurve Model Creation Function Tests",
        () {
          test(
            "'createInitialConditions' should return a LC_INITIAL_CONDITIONS Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve expectedResult = LearningCurve(
                type: SubScreenType.LC_INITIAL_CONDITIONS,
                learningRate: 0.8,
                firstSequenceTime: 1000,
                maxSequenceNumber: 50,
              );
              final LearningCurveManagementContract repository =
                  LearningCurveManagementImpl();

              // Test
              final result = repository.createInitialConditions(
                learningRate: 0.8,
                firstSequenceTime: 1000,
                maxSequenceNumber: 50,
              );

              // Evaluate
              expect(result, expectedResult);
            },
          );

          test(
            "'createNIteration' should return a LC_N_ITERATION Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve expectedResult = LearningCurve(
                type: SubScreenType.LC_N_ITERATION,
                maxSequenceNumber: 50,
                sequenceNumber: 12,
                sequenceTime: 572,
                firstSequenceTime: 1100,
              );
              final LearningCurveManagementContract repository =
                  LearningCurveManagementImpl();

              // Test
              final result = repository.createNIteration(
                maxSequenceNumber: 50,
                sequenceNumber: 12,
                sequenceTime: 572,
                firstSequenceTime: 1100,
              );

              // Evaluate
              expect(result, expectedResult);
            },
          );

          test(
            "'create2Samples' should return a LC_TWO_SAMPLES Learning Curve model",
            () {
              // Prepare Data
              final LearningCurve expectedResult = LearningCurve(
                type: SubScreenType.LC_TWO_SAMPLES,
                maxSequenceNumber: 50,
                aSequenceNumber: 14,
                aSequenceTime: 25,
                bSequenceNumber: 35,
                bSequenceTime: 20,
              );
              final LearningCurveManagementContract repository =
                  LearningCurveManagementImpl();

              // Test
              final result = repository.create2Samples(
                maxSequenceNumber: 50,
                aSequenceNumber: 14,
                aSequenceTime: 25,
                bSequenceNumber: 35,
                bSequenceTime: 20,
              );

              // Evaluate
              expect(result, expectedResult);
            },
          );
        },
      );
    },
  );

  group(
    "LearningCurve Series Tests",
    () {
      test(
        "'createSeries' should return a List<LearningCurveData> object if received a well encoded JSON with the matching format",
        () async {
          // Preparing Data
          final LearningCurveManagementContract repository =
              LearningCurveManagementImpl();
          const List<LearningCurveData> expectedResult = [
            LearningCurveData(
              y1Time: 0,
              y2AccumulatedTime: 0,
              xSequence: 0,
            ),
            LearningCurveData(
              y1Time: 1,
              y2AccumulatedTime: 1,
              xSequence: 1,
            ),
            LearningCurveData(
              y1Time: 2,
              y2AccumulatedTime: 3,
              xSequence: 2,
            ),
          ];

          final String encodedJson =
              await rootBundle.loadString("assets/test_good_json.json");

          // Testing
          final OperationResult result =
              repository.createSeries(encodedJson: encodedJson);

          // Evaluate
          expect(result.success, true);
          expect(
              result.returnedObject as List<LearningCurveData>, expectedResult);
        },
      );

      test(
        "'createSeries' should return a failed OperationResult object if received a well encoded JSON without matching the format",
        () async {
          // Preparing Data
          final LearningCurveManagementContract repository =
              LearningCurveManagementImpl();
          const List<LearningCurveData> expectedResult = [
            LearningCurveData(
              y1Time: 0,
              y2AccumulatedTime: 0,
              xSequence: 0,
            ),
            LearningCurveData(
              y1Time: 1,
              y2AccumulatedTime: 1,
              xSequence: 1,
            ),
            LearningCurveData(
              y1Time: 2,
              y2AccumulatedTime: 3,
              xSequence: 2,
            ),
          ];

          final String encodedJson =
              await rootBundle.loadString("assets/test_bad_json.json");

          // Testing
          final OperationResult result =
              repository.createSeries(encodedJson: encodedJson);

          // Evaluate
          expect(result.success, false);
          print(result.message);
        },
      );
    },
  );
}

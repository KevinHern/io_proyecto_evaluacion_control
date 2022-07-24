// Basic Imports
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/data/datasources/python_server.dart';

// Models
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/domain/repositories/learning_curve_management_contract.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';

class MPythonServerDataSource extends Mock implements PythonServerDatasource {}

@GenerateMocks([MPythonServerDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

          // Mocking Function
          when();

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
    },
  );
}

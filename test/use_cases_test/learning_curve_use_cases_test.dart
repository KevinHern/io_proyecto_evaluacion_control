// Basic Imports
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Datasources
import 'package:flutter_web_app/data/datasources/python_server.dart';

// Models
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/domain/repositories/learning_curve_management_contract.dart';

// Use Cases
import 'package:flutter_web_app/domain/use_cases/learning_curve_use_cases.dart';

// Mock
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'learning_curve_use_cases_test.mocks.dart';

// Backend
import 'package:http/http.dart' as http;

@GenerateMocks([PythonServerDatasource, http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    "LearningCurve Series Tests",
    () {
      test(
        "'createSeries' should return a List<LearningCurveData> object if received a well encoded JSON with the matching format",
        () async {
          // Preparing Data
          final String encodedJson =
              await rootBundle.loadString("assets/test_good_json.json");
          const List<LearningCurveData> expectedGoodSeries = [
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

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.getLearningCurveValues(
              url: anyNamed("url"),
              encodedLearningCurve: anyNamed("encodedLearningCurve"),
            ),
          ).thenAnswer((_) async =>
              OperationResult(success: true, returnedObject: encodedJson));

          // Testing
          final LearningCurveUseCases useCases = LearningCurveUseCases(
            repository: LearningCurveManagementImpl(),
            datasource: mockDatasource,
          );

          final OperationResult result = await useCases.getLearningCurve(
            url: "Some URL",
            type: SubScreenType.LC_INITIAL_CONDITIONS,
            maxSequenceNumber: 50,
            learningRate: 0.8,
            firstSequenceTime: 1000,
          );

          expect(result.success, true);
          expect(result.returnedObject as List<LearningCurveData>,
              expectedGoodSeries);
        },
      );

      test(
        "'createSeries' should return a failure OperationResult object if received a well encoded JSON without the matching format",
        () async {
          // Preparing Data
          final String encodedJson =
              await rootBundle.loadString("assets/test_bad_json.json");

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.getLearningCurveValues(
              url: anyNamed("url"),
              encodedLearningCurve: anyNamed("encodedLearningCurve"),
            ),
          ).thenAnswer((_) async =>
              OperationResult(success: true, returnedObject: encodedJson));

          // Testing
          final LearningCurveUseCases useCases = LearningCurveUseCases(
            repository: LearningCurveManagementImpl(),
            datasource: mockDatasource,
          );

          final OperationResult result = await useCases.getLearningCurve(
            url: "Some URL",
            type: SubScreenType.LC_INITIAL_CONDITIONS,
            maxSequenceNumber: 50,
            learningRate: 0.8,
            firstSequenceTime: 1000,
          );

          expect(result.success, false);
          print(result.message);
        },
      );

      test(
        "'createSeries' should return a failure OperationResult object if received a failure OperationResult after executing POST request",
        () async {
          // Preparing Data
          final String encodedJson =
              await rootBundle.loadString("assets/test_bad_json.json");

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.getLearningCurveValues(
              url: anyNamed("url"),
              encodedLearningCurve: anyNamed("encodedLearningCurve"),
            ),
          ).thenAnswer((_) async => OperationResult(
              success: false,
              message: "Ocurrió un error. Código de error 404"));

          // Testing
          final LearningCurveUseCases useCases = LearningCurveUseCases(
            repository: LearningCurveManagementImpl(),
            datasource: mockDatasource,
          );

          final OperationResult result = await useCases.getLearningCurve(
            url: "Some URL",
            type: SubScreenType.LC_INITIAL_CONDITIONS,
            maxSequenceNumber: 50,
            learningRate: 0.8,
            firstSequenceTime: 1000,
          );

          expect(result.success, false);
          print(result.message);
        },
      );
    },
  );
}

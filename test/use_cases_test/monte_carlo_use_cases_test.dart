// Basic Imports
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Datasources
import 'package:flutter_web_app/data/datasources/python_server.dart';

// Models
import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/monte_carlo_management_impl.dart';
import 'package:flutter_web_app/domain/repositories/monte_carlo_management_contract.dart';

// Use Cases
import 'package:flutter_web_app/domain/use_cases/monte_carlo_use_cases.dart';

// Mock
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'monte_carlo_use_cases_test.mocks.dart';

// Backend
import 'package:http/http.dart' as http;

@GenerateMocks([PythonServerDatasource, http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    "Monte Carse Use Cases Test",
    () {
      // Prepare Constants
      const double average = 50,
          stdev = 6.7,
          median = 47.6,
          kurtosis = 0.267,
          skewerness = 0.80;
      const int samples = 120;
      final List<dynamic> dummyValues = [50.54, 55.6, 49.82, 48.93, 51.24];

      test(
        "'doSimulation' should return a MonteCarloSimulation object if received a well encoded JSON with the matching format",
        () async {
          // Preparing Data
          final String encodedJson = await rootBundle
              .loadString("assets/test_mc_receive_good_json.json");
          final MonteCarloSimulation expectedResult = MonteCarloSimulation(
            samples: samples,
            average: average,
            stdev: stdev,
            median: median,
            kurtosis: kurtosis,
            skewerness: skewerness,
          );
          expectedResult.values.addAll(dummyValues.cast<double>());

          final List<MonteCarloActivity> activities = [
            MonteCarloActivity(
              name: "A",
              minimum: 0,
              maximum: 10,
            ),
            MonteCarloActivity(
              name: "B",
              minimum: 100,
              maximum: 1000,
            ),
            MonteCarloActivity(
              name: "C",
              minimum: 10000,
              maximum: 100000,
            ),
          ];

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.sendJsonToServer(
              url: anyNamed("url"),
              encodedObject: anyNamed("encodedObject"),
            ),
          ).thenAnswer((_) async =>
              OperationResult(success: true, returnedObject: encodedJson));

          final MonteCarloUseCases useCases = MonteCarloUseCases(
            repository: MonteCarloManagementImpl(),
            datasource: mockDatasource,
          );

          // Testing
          final OperationResult result = await useCases.doSimulation(
            url: "Some URL",
            activities: activities,
          );

          expect(result.success, true);
          expect(result.returnedObject, expectedResult);
        },
      );

      test(
        "'doSimulation' should return a failure OperationResult object if received a well encoded JSON without the matching format",
        () async {
          // Preparing Data
          final String encodedJson = await rootBundle
              .loadString("assets/test_mc_receive_bad_json.json");

          final List<MonteCarloActivity> activities = [
            MonteCarloActivity(
              name: "A",
              minimum: 0,
              maximum: 10,
            ),
            MonteCarloActivity(
              name: "B",
              minimum: 100,
              maximum: 1000,
            ),
            MonteCarloActivity(
              name: "C",
              minimum: 10000,
              maximum: 100000,
            ),
          ];

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.sendJsonToServer(
              url: anyNamed("url"),
              encodedObject: anyNamed("encodedObject"),
            ),
          ).thenAnswer((_) async =>
              OperationResult(success: true, returnedObject: encodedJson));

          final MonteCarloUseCases useCases = MonteCarloUseCases(
            repository: MonteCarloManagementImpl(),
            datasource: mockDatasource,
          );

          // Testing
          final OperationResult result = await useCases.doSimulation(
            url: "Some URL",
            activities: activities,
          );

          expect(result.success, false);
        },
      );

      test(
        "'doSimulation' should return a failure OperationResult object if received a failure OperationResult after executing POST request",
        () async {
          // Preparing Data
          final String encodedJson =
              await rootBundle.loadString("assets/test_bad_json.json");
          final List<MonteCarloActivity> activities = [
            MonteCarloActivity(
              name: "A",
              minimum: 0,
              maximum: 10,
            ),
            MonteCarloActivity(
              name: "B",
              minimum: 100,
              maximum: 1000,
            ),
            MonteCarloActivity(
              name: "C",
              minimum: 10000,
              maximum: 100000,
            ),
          ];

          // Mocking Backend
          final MockPythonServerDatasource mockDatasource =
              MockPythonServerDatasource();
          when(
            mockDatasource.sendJsonToServer(
              url: anyNamed("url"),
              encodedObject: anyNamed("encodedObject"),
            ),
          ).thenAnswer((_) async => OperationResult(
              success: false,
              message: "Ocurrió un error. Código de error 404"));

          // Testing
          final MonteCarloUseCases useCases = MonteCarloUseCases(
            repository: MonteCarloManagementImpl(),
            datasource: mockDatasource,
          );

          final OperationResult result = await useCases.doSimulation(
            url: "Some URL",
            activities: activities,
          );

          expect(result.success, false);
          print(result.message);
        },
      );
    },
  );
}

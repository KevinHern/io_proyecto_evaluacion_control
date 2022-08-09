// Basic Imports
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

void main() {
  group(
    "Monte Carlo Activity Model Tests",
    () {
      test(
        "Should return a Map<String, dynamic> when 'toMap' is called on a LC_INITIAL_CONDITIONS Learning Curve model",
        () {
          // Prepare Data
          final MonteCarloActivity monteCarloActivity = MonteCarloActivity(
            name: "Actividad",
            minimum: 123,
            maximum: 1337,
          );
          final Map<String, dynamic> expectedResult = {
            "name": "Actividad",
            "minimum": 123,
            "maximum": 1337,
          };

          // Test
          final Map<String, dynamic> result = monteCarloActivity.toMap();

          // evaluate
          expect(result, expectedResult);
        },
      );
    },
  );

  group(
    "Monte Carlo Simulation Model Tests",
    () {
      group(
        "'mapToModel()' constructor tests",
        () {
          // Prepare constants
          // Prepare Data
          const double average = 50,
              stdev = 6.7,
              median = 47.6,
              kurtosis = 0.267,
              skewerness = 0.80;
          const int samples = 120;
          final List<dynamic> dummyValues = [50.54, 55.6, 49.82, 48.93, 51.24];

          test(
            "Should return a successful OperationResult Model when 'mapToModel'"
            "is called on a compatible Map<dynamic, dynamic> Map with correct datatypes",
            () {
              // Prepare Data
              final Map<dynamic, dynamic> dummyMap1 = {
                "summary": {
                  "mean": average,
                  "stdev": stdev,
                  "median": median,
                  "kurtosis": kurtosis,
                  "skew": skewerness,
                  "samples": samples,
                },
                "values": dummyValues,
              };

              MonteCarloSimulation expectedResult = MonteCarloSimulation(
                samples: samples,
                average: average,
                stdev: stdev,
                median: median,
                kurtosis: kurtosis,
                skewerness: skewerness,
              );
              expectedResult.values.addAll(dummyValues.cast<double>());

              // Test
              final OperationResult result =
                  MonteCarloSimulation.mapToModel(map: dummyMap1);

              // Evaluate
              expect(result.success, true);
              expect(result.returnedObject as MonteCarloSimulation,
                  expectedResult);
            },
          );

          test(
            "Should return a failed OperationResult Model when 'mapToModel' "
            "is called on a compatible Map<dynamic, dynamic> Map with wrong datatypes",
            () {
              // Prepare Data
              final Map<dynamic, dynamic> dummyMap = {
                "summary": {
                  "average": "hola",
                  "stdev": stdev,
                  "median": median,
                  "kurtosis": kurtosis,
                  "skew": skewerness,
                  "samples": samples
                },
                "values": dummyValues,
              };

              // Test
              final result = MonteCarloSimulation.mapToModel(map: dummyMap);

              // Evaluate
              expect(result.success, false);
              print(result.message);
            },
          );
        },
      );
    },
  );
}

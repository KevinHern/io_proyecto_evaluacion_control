// Basic Imports
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Models
import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

// Repositories
import 'package:flutter_web_app/data/repositories/monte_carlo_management_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Monte Carlo Repository IMPL Tests',
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
        "'createActivity' should return a valid MonteCarloActivity model",
        () {
          // Prepare Constants
          const String name = "Actividad";
          const double minimum = 69, maximum = 420;

          // Prepare Data
          final MonteCarloActivity expectedResult = MonteCarloActivity(
            name: name,
            minimum: minimum,
            maximum: maximum,
          );
          final MonteCarloManagementImpl repository =
              MonteCarloManagementImpl();

          // Test
          final result = repository.createActivity(
              name: name, minimum: minimum, maximum: maximum);

          // Evaluate
          expect(result, expectedResult);
        },
      );

      test(
        "'toJson' should return the expect encoded JSON that the server needs",
        () async {
          // Prepare Data
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

          final MonteCarloManagementImpl repository =
              MonteCarloManagementImpl();

          final String expectedResult =
              await rootBundle.loadString("assets/test_mc_send_json.json");

          // Test
          final result = repository.toJson(activities: activities);

          // Evaluate
          expect(jsonDecode(result), jsonDecode(expectedResult));
        },
      );

      test(
        "'createSimulation' should return a MonteCarloSimulation object when the expected"
        " JSON has the correct datatypes",
        () async {
          // Prepare Data
          final MonteCarloSimulation expectedResult = MonteCarloSimulation(
            samples: samples,
            average: average,
            stdev: stdev,
            median: median,
            kurtosis: kurtosis,
            skewerness: skewerness,
          );
          expectedResult.values.addAll(dummyValues.cast<double>());

          final MonteCarloManagementImpl repository =
              MonteCarloManagementImpl();

          final String encodedJson = await rootBundle
              .loadString("assets/test_mc_receive_good_json.json");

          // Test
          final result = repository.createSimulation(encodedJson: encodedJson);

          // Evaluate
          expect(result.success, true);
          expect(result.returnedObject, expectedResult);
        },
      );

      test(
        "'createSimulation' should fail when the expected JSON doesn't have the"
        " correct datatypes",
        () async {
          // Prepare Data
          final MonteCarloManagementImpl repository =
              MonteCarloManagementImpl();

          final String encodedJson = await rootBundle
              .loadString("assets/test_mc_receive_bad_json.json");

          // Test
          final result = repository.createSimulation(encodedJson: encodedJson);

          // Evaluate
          expect(result.success, false);
        },
      );
    },
  );
}

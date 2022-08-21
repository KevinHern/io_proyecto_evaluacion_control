// Basic Imports
import 'package:flutter/services.dart';
import 'package:flutter_web_app/domain/repositories/monte_carlo_management_contract.dart';

// Datasources
import '../../data/datasources/python_server.dart';

// Models
import '../../data/models/monte_carlo_activity.dart';
import '../../data/models/operation_result.dart';

class MonteCarloUseCases {
  final PythonServerDatasource _datasource;
  final MonteCarloManagementContract _repository;
  MonteCarloUseCases({
    required MonteCarloManagementContract repository,
    required PythonServerDatasource datasource,
  })  : _repository = repository,
        _datasource = datasource;

  void addActivity(
          {required String name,
          required double minimum,
          required double maximum,
          required List<MonteCarloActivity> activities}) =>
      activities.add(
        _repository.createActivity(
            name: name, minimum: minimum, maximum: maximum),
      );

  void updateActivity(
      {required String name,
      required double minimum,
      required double maximum,
      required MonteCarloActivity activity}) {
    activity.name = name;
    activity.minimum = minimum;
    activity.maximum = maximum;
  }

  Future<OperationResult> doSimulation(
      {required List<MonteCarloActivity> activities,
      bool example = false}) async {
    late final OperationResult backendResult;

    // Sending JSON and awaiting response
    if (!example) {
      // Sending request
      backendResult = await _datasource.sendJsonToServer(
        encodedObject: _repository.toJson(activities: activities),
      );
    } else {
      final String encodedJson =
          await rootBundle.loadString("assets/test_mc_json.json");
      backendResult =
          OperationResult(success: true, returnedObject: encodedJson);
    }

    // Check result
    if (backendResult.success) {
      // Everything went smooth, proceed to decode JSON and extract data
      final OperationResult mapResult = _repository.createSimulation(
        encodedJson: backendResult.returnedObject as String,
      );

      if (mapResult.success) {
        return OperationResult(
            success: true,
            message: "Simulación Monte Carlo realizado correctamente.",
            returnedObject: mapResult.returnedObject as MonteCarloSimulation);
      } else {
        return mapResult;
      }
    } else {
      // An error happened in the backend, propagate it
      return backendResult;
    }
  }
}

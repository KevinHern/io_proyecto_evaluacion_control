import 'dart:convert';

import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';

import 'package:flutter_web_app/data/models/operation_result.dart';

import '../../domain/repositories/learning_curve_management_contract.dart';
import '../../domain/repositories/monte_carlo_management_contract.dart';

class MonteCarloManagementImpl implements MonteCarloManagementContract {
  @override
  MonteCarloActivity createActivity(
          {required String name,
          required double minimum,
          required double maximum}) =>
      MonteCarloActivity(name: name, minimum: minimum, maximum: maximum);

  @override
  void deleteActivity(
          {required MonteCarloActivity activity,
          required List<MonteCarloActivity> activities}) =>
      activities.remove(activity);

  @override
  String toJson({required List<MonteCarloActivity> activities}) {
    // Preparing map
    final Map<String, dynamic> activitiesMap = {"activities": []};

    // Mapping each activity
    for (MonteCarloActivity activity in activities) {
      activitiesMap["activities"].add(activity.toMap());
    }

    return jsonEncode(activitiesMap);
  }

  @override
  OperationResult createSimulation({required String encodedJson}) {
    // Deserialize Json
    final decodedResult = jsonDecode(encodedJson);

    // Map the JSON object to a Monte Carlo Simulation model
    return MonteCarloSimulation.mapToModel(map: decodedResult);
  }
}

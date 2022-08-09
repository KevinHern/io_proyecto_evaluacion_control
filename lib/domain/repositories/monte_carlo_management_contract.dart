import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';

abstract class MonteCarloManagementContract {
  MonteCarloActivity createActivity({
    required String name,
    required double minimum,
    required double maximum,
  });
  void deleteActivity({
    required MonteCarloActivity activity,
    required List<MonteCarloActivity> activities,
  });
  String toJson({required List<MonteCarloActivity> activities});
  OperationResult createSimulation({required String encodedJson});
}

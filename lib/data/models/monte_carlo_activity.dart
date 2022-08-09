import 'package:equatable/equatable.dart';

import 'operation_result.dart';

class MonteCarloActivity extends Equatable {
  String name;
  double minimum, maximum;

  MonteCarloActivity(
      {required this.name, required this.minimum, required this.maximum});

  Map<String, dynamic> toMap() => {
        "name": name,
        "minimum": minimum,
        "maximum": maximum,
      };

  @override
  List<Object?> get props => [name, minimum, maximum];
}

class MonteCarloSimulation extends Equatable {
  final int samples;
  final double average, stdev, median, kurtosis, skewerness;
  final List<double> values;

  MonteCarloSimulation({
    required this.samples,
    required this.average,
    required this.stdev,
    required this.median,
    required this.kurtosis,
    required this.skewerness,
  }) : this.values = [];

  static OperationResult mapToModel({required Map<dynamic, dynamic> map}) {
    try {
      // First, extracting the summary of the results
      final Map<String, dynamic> summaryResults = map["summary"];

      final monteCarloSimulation = MonteCarloSimulation(
        samples: summaryResults['samples'].toInt(),
        average: summaryResults['mean'].toDouble(),
        stdev: summaryResults['stdev'].toDouble(),
        median: summaryResults['median'].toDouble(),
        kurtosis: summaryResults['kurtosis'].toDouble(),
        skewerness: summaryResults['skew'].toDouble(),
      );

      // Second, get all simulation values
      monteCarloSimulation.values.addAll(map['values'].cast<double>());

      return OperationResult(
          success: true, returnedObject: monteCarloSimulation);
    } catch (error) {
      // Building JSON Message
      String message = "{";

      for (MapEntry<dynamic, dynamic> entry in map.entries) {
        message +=
            "${entry.key}: ${entry.value} (${entry.value.runtimeType}), ";
      }

      message = message.trimRight();
      message = message.substring(0, message.length - 1);
      message += "}";

      return OperationResult(
        success: false,
        message:
            "Un error ocurrió durante la deserialización del JSON. Un JSON Object llegó de la siguiente forma:\n$message",
      );
    }
  }

  @override
  List<Object?> get props =>
      [average, stdev, median, kurtosis, skewerness, values];
}

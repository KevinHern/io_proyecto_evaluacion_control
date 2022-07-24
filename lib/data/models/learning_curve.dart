import 'package:equatable/equatable.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

import 'operation_result.dart';

class LearningCurve extends Equatable {
  // Initial Conditions
  double? learningRate;

  // N-iteration
  int? sequenceNumber;
  double? sequenceTime;

  // 2 Samples
  int? aSequenceNumber, bSequenceNumber;
  double? aSequenceTime, bSequenceTime;

  // Shared
  double? firstSequenceTime;
  int maxSequenceNumber;
  SubScreenType type;

  LearningCurve({
    required this.type,
    this.maxSequenceNumber = 50,
    this.learningRate,
    this.sequenceNumber,
    this.sequenceTime,
    this.aSequenceNumber,
    this.bSequenceNumber,
    this.aSequenceTime,
    this.bSequenceTime,
    this.firstSequenceTime,
  });

  Map<String, dynamic> toMap() {
    switch (type) {
      case SubScreenType.LC_INITIAL_CONDITIONS:
        return {
          "type": 0,
          "learningRate": learningRate,
          "time": firstSequenceTime,
          "maxSequence": maxSequenceNumber,
        };
      case SubScreenType.LC_N_ITERATION:
        return {
          "type": 1,
          "sequenceNumber": sequenceNumber,
          "sequenceTime": sequenceTime,
          "firstSequenceTime": firstSequenceTime,
          "maxSequence": maxSequenceNumber,
        };
      case SubScreenType.LC_TWO_SAMPLES:
        return {
          "type": 2,
          "aSequenceNumber": aSequenceNumber,
          "bSequenceNumber": bSequenceNumber,
          "aSequenceTime": aSequenceTime,
          "bSequenceTime": bSequenceTime,
          "maxSequence": maxSequenceNumber,
        };
      default:
        throw Exception("Unknown Learning Curve Type found");
    }
  }

  @override
  List<Object?> get props => [
        this.type,
        this.maxSequenceNumber,
        this.learningRate,
        this.sequenceNumber,
        this.sequenceTime,
        this.aSequenceNumber,
        this.bSequenceNumber,
        this.aSequenceTime,
        this.bSequenceTime,
        this.firstSequenceTime,
      ];
}

class LearningCurveData extends Equatable {
  final double y1Time, y2AccumulatedTime;
  final int xSequence;

  const LearningCurveData(
      {required this.y1Time,
      required this.y2AccumulatedTime,
      required this.xSequence});

  static OperationResult mapToModel({required Map<dynamic, dynamic> map}) {
    try {
      final learningCurveData = LearningCurveData(
        y1Time: map['y1Time'].toDouble(),
        y2AccumulatedTime: map['y2AccumulatedTime'].toDouble(),
        xSequence: map['xSequence'] as int,
      );

      return OperationResult(success: true, returnedObject: learningCurveData);
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
  List<Object?> get props => [y1Time, y2AccumulatedTime, xSequence];
}

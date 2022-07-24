import 'package:flutter/material.dart';
import 'package:flutter_web_app/data/models/learning_curve.dart';

class LearningCurveSeriesUI extends ChangeNotifier {
  List<LearningCurveData>? _series;

  LearningCurveSeriesUI({List<LearningCurveData>? series}) : _series = series;

  // Getters
  List<LearningCurveData>? get series => _series;

  // Setters
  set series(List<LearningCurveData>? value) {
    _series = value;
    notifyListeners();
  }

  // Methods
  void update() => notifyListeners();
}

import 'package:flutter/material.dart';

enum ScreenType { LEARNING_CURVE, MONTE_CARLO, INFORMATION }

class ScreenManagerUI extends ChangeNotifier {
  ScreenType _screenType;

  ScreenManagerUI({ScreenType screenType = ScreenType.LEARNING_CURVE})
      : _screenType = screenType;

  // Getters
  ScreenType get screenType => _screenType;

  // Setters
  set screenType(ScreenType value) {
    _screenType = value;
    notifyListeners();
  }

  // Methods
  void update() => notifyListeners();
}

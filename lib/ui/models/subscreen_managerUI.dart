import 'package:flutter/material.dart';

enum SubScreenType {
  LC_INITIAL_CONDITIONS,
  LC_N_ITERATION,
  LC_TWO_SAMPLES,
}

class SubScreenManagerUI extends ChangeNotifier {
  SubScreenType _screenType;

  SubScreenManagerUI(
      {SubScreenType screenType = SubScreenType.LC_INITIAL_CONDITIONS})
      : _screenType = screenType;

  // Getters
  SubScreenType get screenType => _screenType;

  // Setters
  set screenType(SubScreenType value) {
    _screenType = value;
    notifyListeners();
  }

  // Methods
  void update() => notifyListeners();
}

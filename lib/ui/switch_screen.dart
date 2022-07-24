// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/ui/learning_curve/learning_curve_screen.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/initial_conditions.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/n_iteration.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/two_points.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';

class SwitchScreen extends StatelessWidget {
  final LearningCurveManagementImpl lcRepository;
  SwitchScreen({Key? key})
      : lcRepository = LearningCurveManagementImpl(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubScreenManagerUI>(
      builder: (_, subScreenManagerUI, __) {
        switch (subScreenManagerUI.screenType) {
          case SubScreenType.LC_INITIAL_CONDITIONS:
            return LearningCurveScreen(
              child: LCInitialConditions(
                repository: lcRepository,
              ),
            );
          case SubScreenType.LC_N_ITERATION:
            return LearningCurveScreen(
              child: LCNIteration(
                repository: lcRepository,
              ),
            );
          case SubScreenType.LC_TWO_SAMPLES:
            return LearningCurveScreen(
              child: LCTwoSamples(
                repository: lcRepository,
              ),
            );
          default:
            throw ("Uninplemented Screen");
        }
      },
    );
  }
}

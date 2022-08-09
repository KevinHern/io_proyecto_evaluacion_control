// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/data/repositories/learning_curve_management_impl.dart';
import 'package:flutter_web_app/ui/information_screen.dart';
import 'package:flutter_web_app/ui/learning_curve/learning_curve_screen.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/initial_conditions.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/n_iteration.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/two_points.dart';
import 'package:flutter_web_app/ui/models/screen_managerUI.dart';
import 'package:flutter_web_app/ui/monte_carlo/monte_carlo_screen.dart';
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
    return Consumer2<ScreenManagerUI, SubScreenManagerUI>(
      builder: (_, screenManagerUI, subScreenManagerUI, __) {
        if (screenManagerUI.screenType == ScreenType.LEARNING_CURVE) {
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
              throw ("Unimplemented Learning Curve SubScreen");
          }
        } else if (screenManagerUI.screenType == ScreenType.MONTE_CARLO) {
          return MonteCarloScreen();
        } else if (screenManagerUI.screenType == ScreenType.INFORMATION) {
          return const InformationScreen();
        } else {
          throw ("Unimplemented Main SubScreen");
        }
      },
    );
  }
}

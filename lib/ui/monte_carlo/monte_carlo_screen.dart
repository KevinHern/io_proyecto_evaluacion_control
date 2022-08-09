// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/data/datasources/python_server.dart';
import 'package:flutter_web_app/data/repositories/monte_carlo_management_impl.dart';
import 'package:flutter_web_app/domain/use_cases/monte_carlo_use_cases.dart';
import 'package:flutter_web_app/ui/components/text_card.dart';
import 'package:flutter_web_app/ui/monte_carlo/widget/activities_form.dart';
import 'package:flutter_web_app/ui/monte_carlo/widget/activities_list.dart';
import 'package:flutter_web_app/ui/monte_carlo/widget/monte_carlo_simulation_results.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_web_app/ui/models/monte_carloUI.dart';

class MonteCarloScreen extends StatelessWidget {
  static const double spacing = 8.0;
  final MonteCarloUseCases useCases = MonteCarloUseCases(
    repository: MonteCarloManagementImpl(),
    datasource: PythonServerDatasource(),
  );
  MonteCarloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: spacing * 5,
            horizontal: MediaQuery.of(context).size.width * 0.10),
        child: ChangeNotifierProvider<MonteCarloUI>(
          create: (context) => MonteCarloUI(),
          child: Column(
            children: [
              Text(
                'Simulación Monte Carlo',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: spacing,
              ),
              TextCard(
                textSpanList: [
                  TextSpan(
                    text:
                        "Para esta simulación, debes de proporcionar una cantidad N "
                        "de actividades y sus costos mínimo y máximo. Puedes agregar la cantidad de actividades que necesites.",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(
                height: spacing * 1.5,
              ),
              ActivitiesForm(
                useCases: MonteCarloUseCases(
                  repository: MonteCarloManagementImpl(),
                  datasource: PythonServerDatasource(),
                ),
              ),
              const SizedBox(
                height: spacing * 2.5,
              ),
              ActivitiesList(
                useCases: useCases,
              ),
              const SizedBox(
                height: spacing * 2.5,
              ),
              const MonteCarloSimulationScreen()
            ],
          ),
        ),
      ),
    );
  }
}

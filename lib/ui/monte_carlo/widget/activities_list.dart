// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/data/models/monte_carlo_activity.dart';
import 'package:flutter_web_app/data/models/operation_result.dart';
import 'package:flutter_web_app/ui/components/form_inputs.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_web_app/ui/models/monte_carloUI.dart';

// Mixins
import 'package:flutter_web_app/ui/mixins/form_mixin.dart';

// Use Cases
import '../../../domain/use_cases/monte_carlo_use_cases.dart';

class ActivitiesList extends StatelessWidget with FormMixin {
  final MonteCarloUseCases _useCases;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const double spacing = 8.0;
  ActivitiesList({required MonteCarloUseCases useCases, Key? key})
      : this._useCases = useCases,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spacing * 2.5),
        child: Consumer<MonteCarloUI>(
          builder: (_, monteCarloUI, __) {
            if (monteCarloUI.activities.isEmpty) {
              return Text(
                "No hay actividades",
                style: Theme.of(context).textTheme.subtitle2,
              );
            } else {
              return Column(
                children: [
                  const FormTitle(title: "Lista de Actividades"),
                  const SizedBox(
                    height: spacing * 2,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 0,
                      maxHeight: 350,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(spacing * 2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(spacing),
                        child: SingleChildScrollView(
                          child: Column(
                            children: monteCarloUI.toWidgetList(
                                context: context, spacing: spacing),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spacing * 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.info),
                        label: const Text(
                          "Ejemplo",
                        ),
                        onPressed: () {
                          execute<MonteCarloSimulation>(
                            context: context,
                            useCasesFunction: Future<OperationResult>(
                              () => _useCases.doSimulation(
                                activities: monteCarloUI.activities,
                                example: true,
                              ),
                            ),
                            updateUI: (value) =>
                                monteCarloUI.simulation = value,
                          );
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          "Borrar Todo",
                        ),
                        onPressed: () {
                          monteCarloUI.activities.clear();
                          monteCarloUI.update();
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text(
                          "Enviar al Servidor",
                        ),
                        onPressed: () => execute<MonteCarloSimulation>(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () => _useCases.doSimulation(
                              activities: monteCarloUI.activities,
                            ),
                          ),
                          updateUI: (value) => monteCarloUI.simulation = value,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

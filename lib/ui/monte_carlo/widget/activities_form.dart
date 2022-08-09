import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/components/form_inputs.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_web_app/ui/models/monte_carloUI.dart';

// Mixins
import '../../mixins/form_mixin.dart';

// Use cases
import 'package:flutter_web_app/domain/use_cases/monte_carlo_use_cases.dart';

class ActivitiesForm extends StatefulWidget {
  final MonteCarloUseCases _useCases;
  const ActivitiesForm({required MonteCarloUseCases useCases, Key? key})
      : this._useCases = useCases,
        super(key: key);

  @override
  ActivitiesFormState createState() => ActivitiesFormState();
}

class ActivitiesFormState extends State<ActivitiesForm> with FormMixin {
  static const double spacing = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spacing * 2.5),
        child: Form(
          key: _formKey,
          child: Consumer<MonteCarloUI>(
            builder: (_, monteCarloUI, __) {
              return Column(
                children: [
                  const FormTitle(
                    title: "Actividad",
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  SingleLineInputField(
                    icon: Icons.credit_card_outlined,
                    label: "Nombre Actividad",
                    controller: monteCarloUI.nameController,
                    validator: (String? value) {
                      return (value == null)
                          ? null
                          : (value.trim().isEmpty)
                              ? FormMessages.MANDATORY_FIELD
                              : null;
                    },
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  NumberInputField(
                    icon: Icons.numbers,
                    label: "Mínimo",
                    controller: monteCarloUI.minimumController,
                  ),
                  const SizedBox(
                    height: spacing,
                  ),
                  NumberInputField(
                    icon: Icons.numbers,
                    label: "Máximo",
                    controller: monteCarloUI.maximumController,
                  ),
                  const SizedBox(
                    height: spacing * 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          "Reset",
                        ),
                        onPressed: () => monteCarloUI.setControllers(),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: Text(
                          (monteCarloUI.selectedActivity == null)
                              ? "Agregar"
                              : "Guardar",
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Extract values
                            final String name =
                                monteCarloUI.nameController.text;
                            final double minimum = double.parse(
                                monteCarloUI.minimumController.text);
                            final double maximum = double.parse(
                                monteCarloUI.maximumController.text);

                            if (monteCarloUI.selectedActivity == null) {
                              // Create and add model
                              widget._useCases.addActivity(
                                name: name,
                                minimum: minimum,
                                maximum: maximum,
                                activities: monteCarloUI.activities,
                              );
                            } else {
                              widget._useCases.updateActivity(
                                name: name,
                                minimum: minimum,
                                maximum: maximum,
                                activity: monteCarloUI.selectedActivity!,
                              );
                            }

                            // Update UI
                            monteCarloUI.selectedActivity = null;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

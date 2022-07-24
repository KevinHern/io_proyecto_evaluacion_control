// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/form_inputs.dart';

// Mixins
import 'package:flutter_web_app/ui/mixins/form_mixin.dart';

// Models
import '../../../data/models/operation_result.dart';
import '../../models/subscreen_managerUI.dart';
import 'package:flutter_web_app/data/models/learning_curve.dart';
import 'package:flutter_web_app/ui/models/learning_curve_series.dart';

// Repositories
import '../../../domain/repositories/learning_curve_management_contract.dart';

// Use Cases
import '../../../domain/use_cases/learning_curve_use_cases.dart';

class LCInitialConditions extends StatefulWidget {
  final LearningCurveUseCases _learningCurveUseCases;
  LCInitialConditions(
      {required LearningCurveManagementContract repository, Key? key})
      : _learningCurveUseCases = LearningCurveUseCases(repository: repository),
        super(key: key);

  @override
  LCInitialConditionsState createState() => LCInitialConditionsState();
}

class LCInitialConditionsState extends State<LCInitialConditions>
    with FormMixin {
  static const double spacing = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController serverController = TextEditingController(),
      learningRateController = TextEditingController(),
      firstTimeController = TextEditingController(),
      maxSequencesController = TextEditingController(text: "50");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spacing * 2.5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const FormTitle(
                title: "Condiciones Iniciales",
              ),
              const SizedBox(
                height: spacing,
              ),
              SingleLineInputField(
                icon: Icons.link,
                label: "Server URL",
                controller: serverController,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.show_chart,
                label: "Learning Rate",
                controller: learningRateController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.access_time,
                label: "Tiempo Primera Secuencia",
                controller: firstTimeController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.numbers,
                label: "Número Máximo de Secuencias",
                controller: maxSequencesController,
                isEmptyValid: false,
                isLastInput: true,
              ),
              const SizedBox(
                height: spacing * 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calculate),
                    label: const Text("Reset"),
                    onPressed: () {
                      serverController.text = "";
                      learningRateController.text = "";
                      firstTimeController.text = "";
                      maxSequencesController.text = "50";
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calculate),
                    label: const Text("Calcular"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Preparing Data
                        String url = serverController.text;
                        int maxSequenceNumber =
                            int.parse(maxSequencesController.text);
                        double learningRate =
                                double.parse(learningRateController.text),
                            firstSequenceTime = learningRate =
                                double.parse(firstTimeController.text);

                        execute(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () =>
                                widget._learningCurveUseCases.getLearningCurve(
                              url: url,
                              type: SubScreenType.LC_INITIAL_CONDITIONS,
                              maxSequenceNumber: maxSequenceNumber,
                              learningRate: learningRate,
                              firstSequenceTime: firstSequenceTime,
                            ),
                          ),
                          updateUI: (List<LearningCurveData> value) =>
                              Provider.of<LearningCurveSeriesUI>(context,
                                      listen: false)
                                  .series = value,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

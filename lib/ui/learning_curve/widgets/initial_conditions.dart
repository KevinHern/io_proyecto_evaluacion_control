// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/form_inputs.dart';

// Datasources
import 'package:flutter_web_app/data/datasources/python_server.dart';

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
      : _learningCurveUseCases = LearningCurveUseCases(
          repository: repository,
          datasource: PythonServerDatasource(),
        ),
        super(key: key);

  @override
  LCInitialConditionsState createState() => LCInitialConditionsState();
}

class LCInitialConditionsState extends State<LCInitialConditions>
    with FormMixin {
  static const double spacing = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController learningRateController = TextEditingController(),
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
                    icon: const Icon(Icons.info),
                    label: const Text("Ejemplo"),
                    onPressed: () {
                      execute<List<LearningCurveData>>(
                        context: context,
                        useCasesFunction: Future<OperationResult>(
                          () => widget._learningCurveUseCases.getLearningCurve(
                            type: SubScreenType.LC_INITIAL_CONDITIONS,
                            maxSequenceNumber: 50,
                            learningRate: 0,
                            firstSequenceTime: 0,
                            example: true,
                          ),
                        ),
                        updateUI: (value) => Provider.of<LearningCurveSeriesUI>(
                                context,
                                listen: false)
                            .series = value,
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset"),
                    onPressed: () {
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
                        int maxSequenceNumber =
                            int.parse(maxSequencesController.text);
                        double learningRate =
                                double.parse(learningRateController.text),
                            firstSequenceTime = learningRate =
                                double.parse(firstTimeController.text);

                        execute<List<LearningCurveData>>(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () =>
                                widget._learningCurveUseCases.getLearningCurve(
                              type: SubScreenType.LC_INITIAL_CONDITIONS,
                              maxSequenceNumber: maxSequenceNumber,
                              learningRate: learningRate,
                              firstSequenceTime: firstSequenceTime,
                            ),
                          ),
                          updateUI: (value) =>
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

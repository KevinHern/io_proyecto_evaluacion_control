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

class LCNIteration extends StatefulWidget {
  final LearningCurveUseCases _learningCurveUseCases;
  LCNIteration({required LearningCurveManagementContract repository, Key? key})
      : _learningCurveUseCases = LearningCurveUseCases(
          repository: repository,
          datasource: PythonServerDatasource(),
        ),
        super(key: key);

  @override
  LCNIterationState createState() => LCNIterationState();
}

class LCNIterationState extends State<LCNIteration> with FormMixin {
  static const double spacing = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController serverController = TextEditingController(),
      nIterationController = TextEditingController(),
      nIterationTimeController = TextEditingController(),
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
                title: "N Secuencia",
              ),
              const SizedBox(
                height: spacing,
              ),
              SingleLineInputField(
                icon: Icons.link,
                label: "Server URL",
                controller: serverController,
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
                label: "Número de Secuencia",
                controller: nIterationController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.access_time,
                label: "Tiempo de la Secuencia",
                controller: nIterationTimeController,
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
                            url: 'some url',
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
                      serverController.text = "";
                      nIterationController.text = "";
                      nIterationTimeController.text = "";
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
                        int sequenceNumber =
                            int.parse(nIterationController.text);
                        double sequenceTime =
                                double.parse(nIterationTimeController.text),
                            firstSequenceTime =
                                double.parse(firstTimeController.text);

                        execute<List<LearningCurveData>>(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () =>
                                widget._learningCurveUseCases.getLearningCurve(
                              url: url,
                              type: SubScreenType.LC_N_ITERATION,
                              maxSequenceNumber: maxSequenceNumber,
                              sequenceNumber: sequenceNumber,
                              sequenceTime: sequenceTime,
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

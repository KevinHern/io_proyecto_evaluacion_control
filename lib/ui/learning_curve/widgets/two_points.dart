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

class LCTwoSamples extends StatefulWidget {
  final LearningCurveUseCases _learningCurveUseCases;
  LCTwoSamples({required LearningCurveManagementContract repository, Key? key})
      : _learningCurveUseCases = LearningCurveUseCases(
          repository: repository,
          datasource: PythonServerDatasource(),
        ),
        super(key: key);

  @override
  LCTwoSamplesState createState() => LCTwoSamplesState();
}

class LCTwoSamplesState extends State<LCTwoSamples> with FormMixin {
  static const double spacing = 8.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController aIterationController = TextEditingController(),
      aIterationTimeController = TextEditingController(),
      bIterationController = TextEditingController(),
      bIterationTimeController = TextEditingController(),
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
                title: "Dos Muestras",
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.numbers,
                label: "Número de Secuencia A",
                controller: aIterationController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.access_time,
                label: "Tiempo de Secuencia A",
                controller: aIterationTimeController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.numbers,
                label: "Número de Secuencia B",
                controller: bIterationController,
                isEmptyValid: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              NumberInputField(
                icon: Icons.access_time,
                label: "Tiempo de Secuencia B",
                controller: bIterationTimeController,
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
                      aIterationController.text = "";
                      aIterationTimeController.text = "";
                      bIterationController.text = "";
                      bIterationTimeController.text = "";
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
                        int aSequenceNumber =
                                int.parse(aIterationController.text),
                            bSequenceNumber =
                                int.parse(bIterationController.text);
                        double aSequenceTime =
                                double.parse(aIterationTimeController.text),
                            bSequenceTime =
                                double.parse(bIterationTimeController.text);

                        execute<List<LearningCurveData>>(
                          context: context,
                          useCasesFunction: Future<OperationResult>(
                            () =>
                                widget._learningCurveUseCases.getLearningCurve(
                              type: SubScreenType.LC_TWO_SAMPLES,
                              maxSequenceNumber: maxSequenceNumber,
                              aSequenceNumber: aSequenceNumber,
                              aSequenceTime: aSequenceTime,
                              bSequenceNumber: bSequenceNumber,
                              bSequenceTime: bSequenceTime,
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

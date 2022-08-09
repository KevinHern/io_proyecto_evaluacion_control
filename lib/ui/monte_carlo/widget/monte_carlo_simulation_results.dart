// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/components/text_card.dart';
import 'package:flutter_web_app/ui/monte_carlo/widget/monte_carlo_histogram.dart';
import 'package:provider/provider.dart';

// Models
import 'package:flutter_web_app/ui/models/monte_carloUI.dart';

class MonteCarloSimulationScreen extends StatelessWidget {
  static const double spacing = 8.0;
  const MonteCarloSimulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MonteCarloUI>(
      builder: (_, monteCarloUI, __) {
        if (monteCarloUI.simulation == null) {
          return const SizedBox();
        } else {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(spacing * 1.5),
              child: Column(
                children: [
                  MonteCarloHistogramGraph(
                      values: monteCarloUI.simulation!.values),
                  const SizedBox(
                    height: spacing * 1.5,
                  ),
                  TextCard(
                    textSpanList: [
                      TextSpan(
                        text: "Promedio: ",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyText2!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${monteCarloUI.simulation!.average}\n",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: "Desviación Estándar: ",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyText2!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${monteCarloUI.simulation!.stdev}\n",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: "Mediana: ",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyText2!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${monteCarloUI.simulation!.median}\n",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: "Kurtosis: ",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyText2!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${monteCarloUI.simulation!.kurtosis}\n",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextSpan(
                        text: "Sesgo: ",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2!.fontFamily,
                          fontSize:
                              Theme.of(context).textTheme.bodyText2!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${monteCarloUI.simulation!.skewerness}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

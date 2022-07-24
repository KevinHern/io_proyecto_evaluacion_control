// Basic Imports
import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/components/text_card.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/learning_curve_graph.dart';
import 'package:flutter_web_app/ui/learning_curve/widgets/switch_form.dart';

class LearningCurveScreen extends StatelessWidget {
  static const double spacing = 8.0;
  final Widget child;
  const LearningCurveScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: spacing * 5,
            horizontal: MediaQuery.of(context).size.width * 0.10),
        child: Column(
          children: [
            Text(
              'Learning Curve',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: spacing,
            ),
            TextCard(
              textSpanList: [
                TextSpan(
                  text:
                      "Hay 3 tipos de formularios para resolver diferentes situaciones:\n",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextSpan(
                  text: "- Condiciones Iniciales: ",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "Si se conoce el tiempo invertido en realizar la primera secuencia y se conoce el learning rate, es posible calcular y obtener "
                      "la gráfica de la curva de aprendizaje asociada.\n\n",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextSpan(
                  text: "- N-Iteración: ",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "Si se tiene una noción de la N-eava secuencia, se conoce el tiempo invertido en dicha iteración y se tiene también una "
                      "idea del tiempo invertido en la primera secuencia, entonces es posible calcular la curva de aprendizaje asociada.\n\n",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                TextSpan(
                  text: "- 2 Muestras: ",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText2!.fontFamily,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "Si no se conoce el tiempo invertido en la primera secuencia pero se tiene 2 muestras y se conoce (o se tiene una idea) a "
                      "qué iteración pertenecen y su tiempo invertido, es posible calcular la curva de aprendizaje asociada.\n\n",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(
              height: spacing * 1.5,
            ),
            const LCSwitchForm(),
            const SizedBox(
              height: spacing * 1.5,
            ),
            child,
            const SizedBox(
              height: spacing * 2.5,
            ),
            const LearningCurveGraph(),
          ],
        ),
      ),
    );
  }
}

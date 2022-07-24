// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Models
import 'package:flutter_web_app/ui/models/learning_curve_series.dart';
import '../../../data/models/learning_curve.dart';

class LearningCurveGraph extends StatefulWidget {
  const LearningCurveGraph({Key? key}) : super(key: key);

  @override
  LearningCurveGraphState createState() => LearningCurveGraphState();
}

class LearningCurveGraphState extends State<LearningCurveGraph> {
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
      enable: true,
      lineColor: const Color.fromRGBO(0, 0, 0, 0.03),
      lineWidth: 15,
      activationMode: ActivationMode.singleTap,
      markerSettings: const TrackballMarkerSettings(
          borderWidth: 4,
          height: 10,
          width: 10,
          markerVisibility: TrackballVisibilityMode.visible),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningCurveSeriesUI>(
      builder: (_, learningCurveSeriesUI, __) {
        if (learningCurveSeriesUI.series == null) {
          return const SizedBox();
        } else {
          return Card(
            child: SfCartesianChart(
              key: GlobalKey(),
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Curvas de Aprendizaje'),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              primaryXAxis: NumericAxis(
                rangePadding: ChartRangePadding.none,
                name: 'Secuencia',
                title: AxisTitle(
                  text: 'Secuencia',
                ),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(color: Colors.black),
              ),
              primaryYAxis: NumericAxis(
                rangePadding: ChartRangePadding.none,
                name: 'Tiempo Invertido',
                title: AxisTitle(
                  text: 'Tiempo Invertido',
                ),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(color: Colors.transparent),
              ),
              series: <LineSeries<LearningCurveData, int>>[
                LineSeries<LearningCurveData, int>(
                  dataSource: learningCurveSeriesUI.series!,
                  xValueMapper: (LearningCurveData lcData, _) =>
                      lcData.xSequence,
                  yValueMapper: (LearningCurveData lcData, _) => lcData.y1Time,
                  name: 'Individual',
                ),
                LineSeries<LearningCurveData, int>(
                  dataSource: learningCurveSeriesUI.series!,
                  xValueMapper: (LearningCurveData lcData, _) =>
                      lcData.xSequence,
                  yValueMapper: (LearningCurveData lcData, _) =>
                      lcData.y2AccumulatedTime,
                  name: 'Acumulada',
                ),
              ],
              trackballBehavior: _trackballBehavior,
            ),
          );
        }
      },
    );
  }
}

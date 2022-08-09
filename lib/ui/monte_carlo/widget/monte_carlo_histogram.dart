// Basic Imports
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonteCarloHistogramGraph extends StatefulWidget {
  final List<double> values;
  const MonteCarloHistogramGraph({required this.values, Key? key})
      : super(key: key);

  @override
  MonteCarloHistogramGraphState createState() =>
      MonteCarloHistogramGraphState();
}

class MonteCarloHistogramGraphState extends State<MonteCarloHistogramGraph> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      key: GlobalKey(),
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Histograma de la Simulación'),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      primaryXAxis: NumericAxis(
        rangePadding: ChartRangePadding.none,
        name: 'Promedio',
        title: AxisTitle(
          text: 'Promedio Muestra',
        ),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.black),
      ),
      primaryYAxis: NumericAxis(
        rangePadding: ChartRangePadding.none,
        name: 'Frecuencia',
        title: AxisTitle(
          text: 'Frecuencia',
        ),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: <HistogramSeries<double, double>>[
        HistogramSeries<double, double>(
          dataSource: widget.values,
          yValueMapper: (double lcData, _) => lcData,
          name: 'Promedio Muestras',

          // Normal Distribution Curve
          showNormalDistributionCurve: true,
          curveColor: const Color.fromRGBO(192, 108, 132, 1),
          binInterval: 20,

          curveDashArray: <double>[12, 3, 3, 3],
          width: 0.99,
          curveWidth: 2.5,

          // Labels
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
  }
}

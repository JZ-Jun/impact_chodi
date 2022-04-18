import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Donated: \$${15}"),
        Padding(padding: EdgeInsets.only(top: 10), child: Text("Event: 6")),
        Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF4A164),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Text("\$")
              ],
            )),
        Expanded(
            child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
              majorTickLines: const MajorTickLines(size: 0),
              axisLine: const AxisLine(width: 0)),
          primaryYAxis: NumericAxis(
              maximum: 24,
              minimum: 0,
              interval: 8,
              isVisible: false,
              labelFormat: '{value}',
              majorGridLines: const MajorGridLines(width: 0)),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <StackedLineSeries<ChartData, String>>[
            StackedLineSeries<ChartData, String>(
                animationDuration: 3000,
                markerSettings: const MarkerSettings(isVisible: true),
                name: '\$',
                // Bind data source
                dataSource: <ChartData>[
                  ChartData('2-27', 5),
                  ChartData('2-28', 10),
                  ChartData('3-01', 12),
                  ChartData('3-02', 18),
                  ChartData('3-03', 8),
                  ChartData('3-04', 5),
                  ChartData('3-05', 4)
                ],
                width: 2.5,
                color: const Color(0xFFF4A164),
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ],
        )),
        const Padding(
            padding: EdgeInsets.only(top: 10), child: Text("Donated: 7 hours")),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF4A164),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                const Text("hours")
              ],
            )),
        Expanded(
            child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
              majorTickLines: const MajorTickLines(size: 0),
              axisLine: const AxisLine(width: 0)),
          primaryYAxis: NumericAxis(
              maximum: 24,
              minimum: 0,
              interval: 8,
              labelFormat: '{value}',
              isVisible: false,
              axisLine: const AxisLine(width: 0),
              majorGridLines: const MajorGridLines(width: 0)),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <StackedLineSeries<ChartData, String>>[
            StackedLineSeries<ChartData, String>(
                markerSettings: const MarkerSettings(isVisible: true),
                animationDuration: 3000,
                name: 'hours',
                // Bind data source
                dataSource: <ChartData>[
                  ChartData('2-27', 5),
                  ChartData('2-28', 10),
                  ChartData('3-01', 12),
                  ChartData('3-02', 18),
                  ChartData('3-03', 8),
                  ChartData('3-04', 5),
                  ChartData('3-05', 4)
                ],
                width: 2.5,
                color: const Color(0xFFF4A164),
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ],
        )),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<Statistics> {

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              showAvg = !showAvg;
            });
          },
          child: const Text('avg'),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
        ),
      ],
    );
  }
}
import 'package:expense_tracker/views/home/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Statistics'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Week'),
                Tab(text: 'Month'),
                Tab(text: 'Year'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: LineChart(
                          LineChartData(
                            minX: 0,
                            minY: 0,
                            maxX: 6,
                            maxY: 5,
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    String text;

                                    switch (value.toInt()) {
                                      case 0:
                                        text = 'Mon';
                                        break;
                                      case 1:
                                        text = 'Tue';
                                        break;
                                      case 2:
                                        text = 'Wed';
                                        break;
                                      case 3:
                                        text = 'Thu';
                                        break;
                                      case 4:
                                        text = 'Fri';
                                        break;
                                      case 5:
                                        text = 'Sat';
                                        break;
                                      case 6:
                                        text = 'Sun';
                                        break;
                                      default:
                                        return Container();
                                    }

                                    return Text(text);
                                  },
                                ),
                              ),
                            ),
                            gridData: const FlGridData(
                              show: false,
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                  isCurved: true,
                                  spots: const [
                                    FlSpot(0, 0),
                                    FlSpot(1, 3),
                                    FlSpot(2, 2),
                                    FlSpot(3, 4),
                                    FlSpot(4, 1),
                                    FlSpot(5, 5),
                                    FlSpot(6, 3),
                                  ],
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.9, 1],
                                      colors: [
                                        Colors.blue.shade100,
                                        Colors.white,
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ),
                    const Text('Top Spending'),
                    const Column(
                      children: <Widget>[
                        Expense(
                          categoryIcon: Icons.attach_money_rounded,
                          name: 'Cinema',
                          date: '21-09-2023',
                          amount: 100,
                        ),
                        Expense(
                          categoryIcon: Icons.attach_money_rounded,
                          name: 'Dinner',
                          date: '20-09-2023',
                          amount: 100,
                        ),
                        Expense(
                          categoryIcon: Icons.attach_money_rounded,
                          name: 'Skiing',
                          date: '19-09-2023',
                          amount: 100,
                        ),
                        Expense(
                          categoryIcon: Icons.attach_money_rounded,
                          name: 'Hiking',
                          date: '18-09-2023',
                          amount: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text('2'),
              const Text('3'),
            ],
          ),
        ),
    );
  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';
import '../../controllers/expense.controller.dart';

class Year extends StatefulWidget {
  const Year({super.key});

  @override
  State<Year> createState() => _YearState();

}

class _YearState extends State<Year> {
  late Future<List> expenses;

  final ExpenseController _expenseController = Get.put(ExpenseController());
  final User? user = Get.put(AuthController()).currentUser;
  
  double maxSpentMonth(List<FlSpot> list) {
    List<double> nums = List<double>.generate(12, (index) => 0);
    int i = 0;

    for (FlSpot item in list) {
      nums[i] = item.y;
      i++;
    }

    double max = nums[0];
    for (double num in nums) {
      if (num > max) {
        max = num;
      }
    }

    return max;
  }

  @override
  void initState() {
    super.initState();
    expenses = _expenseController.getUserExpenses(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.7,
            child: FutureBuilder(
              future: _expenseController.yearlyStats(expenses),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return LineChart(
                    LineChartData(
                      minX: 1,
                      minY: 0,
                      maxX: 12,
                      maxY: maxSpentMonth(snapshot.data!),
                      titlesData: const FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
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
                          isCurved: false,
                          spots: snapshot.data!,
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
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Text('Top Spending Categories'),
        ],
      ),
    );
  }

}
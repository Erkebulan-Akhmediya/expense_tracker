import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';
import '../../controllers/expense.controller.dart';

class Month extends StatefulWidget {
  const Month({super.key});

  @override
  State<Month> createState() => _MonthState();

}

class _MonthState extends State<Month> with AutomaticKeepAliveClientMixin<Month> {
  late Future<List> expenses;

  final ExpenseController _expenseController = Get.put(ExpenseController());
  final User? user = Get.put(AuthController()).currentUser;

  double daysInMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0).day.toDouble();
  }

  double maxSpentDay(List<FlSpot> list) {
    List<double> nums = List<double>.generate(daysInMonth().toInt(), (index) => 0);
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    expenses = _expenseController.getUserExpenses(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AutomaticKeepAlive(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.7,
              child: FutureBuilder(
                future: _expenseController.monthlyStats(expenses),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return LineChart(
                      LineChartData(
                        minX: 1,
                        minY: 0,
                        maxX: daysInMonth(),
                        maxY: maxSpentDay(snapshot.data!),
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
            FutureBuilder(
              future: expenses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FutureBuilder(
                    future: _expenseController.getExpenses(snapshot.data!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: _expenseController.top4MonthlyCategories(snapshot.data!),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
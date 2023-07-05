import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';

class Week extends StatefulWidget {
  const Week({super.key});

  @override
  State<Week> createState() => _WeekState();

}

class _WeekState extends State<Week> {
  late Future<List> expenses;

  final ExpenseController _expenseController = Get.put(ExpenseController());
  final User? user = Get.put(AuthController()).currentUser;

  double maxSpentDay(List<FlSpot> list) {
    List<double> nums = [0, 0, 0, 0, 0, 0, 0];
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
    return ListView(
      padding: const EdgeInsets.only(top: 60, right: 30, bottom: 10, left: 30),
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: FutureBuilder(
            future: _expenseController.weeklyStats(expenses),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return LineChart(
                  LineChartData(
                    minX: 0,
                    minY: 0,
                    maxX: 6,
                    maxY: maxSpentDay(snapshot.data!),
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
                          reservedSize: 50,
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            String text;

                            switch (value.toInt()) {
                              case 0:
                                text = 'monday'.tr;
                                break;
                              case 1:
                                text = 'tuesday'.tr;
                                break;
                              case 2:
                                text = 'wednesday'.tr;
                                break;
                              case 3:
                                text = 'thursday'.tr;
                                break;
                              case 4:
                                text = 'friday'.tr;
                                break;
                              case 5:
                                text = 'saturday'.tr;
                                break;
                              case 6:
                                text = 'sunday'.tr;
                                break;
                              default:
                                return Container();
                            }

                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                text,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
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
                        dotData: const FlDotData(
                          show: false,
                        ),
                        isCurved: false,
                        spots: snapshot.data!,
                        color: Theme.of(context).primaryColor,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.9, 1],
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.5),
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
        Container(
          margin: const EdgeInsets.only(bottom: 15, top: 20),
          child: Text(
            'top_spending_categories'.tr,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder(
          future: expenses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FutureBuilder(
                future: _expenseController.getExpenses(snapshot.data!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: _expenseController.top4WeeklyCategories(snapshot.data!),
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
    );
  }
}
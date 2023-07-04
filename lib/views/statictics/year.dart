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
      padding: const EdgeInsets.only(top: 60, right: 30, bottom: 20, left: 30),
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
                            reservedSize: 50,

                            getTitlesWidget: (double value, TitleMeta meta) {
                              String text;

                              switch (value.toInt()) {
                                case 1:
                                  text = '1';
                                  break;
                                case 2:
                                  text = '2';
                                  break;
                                case 3:
                                  text = '3';
                                  break;
                                case 4:
                                  text = '4';
                                  break;
                                case 5:
                                  text = '5';
                                  break;
                                case 6:
                                  text = '6';
                                  break;
                                case 7:
                                  text = '7';
                                  break;
                                case 8:
                                  text = '8';
                                  break;
                                case 9:
                                  text = '9';
                                  break;
                                case 10:
                                  text = '10';
                                  break;
                                case 11:
                                  text = '11';
                                  break;
                                case 12:
                                  text = '12';
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
                            }
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
                          isCurved: false,
                          dotData: const FlDotData(
                            show: false,
                          ),
                          color: Theme.of(context).primaryColor,
                          spots: snapshot.data!,
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
                        children: _expenseController.top4YearlyCategories(snapshot.data!),
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
    );
  }

}
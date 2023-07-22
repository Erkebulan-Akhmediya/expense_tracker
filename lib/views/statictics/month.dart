import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:expense_tracker/views/statictics/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Month extends StatelessWidget {
  Month({super.key, required this.user});

  final UserModel user;

  final ExpenseController _expenseController = Get.find<ExpenseController>();

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

  List<Widget> _top4monthlyCategories(List<MapEntry<String, double>> list) {
    List<Widget> widgets = [];

    for (MapEntry<String, double> mapEntry in list) {
      widgets.add(
        Category(
          category: mapEntry.key,
          amount: mapEntry.value,
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<String> expenses = user.expenses;
    List<FlSpot> flSpotList = _expenseController.monthlyStats(expenses);
    return ListView(
      padding: const EdgeInsets.only(top: 60, right: 30, bottom: 10, left: 30),
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              minX: 1,
              minY: 0,
              maxX: daysInMonth(),
              maxY: maxSpentDay(flSpotList),
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
                        case 5:
                          text = '5';
                          break;
                        case 10:
                          text = '10';
                          break;
                        case 15:
                          text = '15';
                          break;
                        case 20:
                          text = '20';
                          break;
                        case 25:
                          text = '25';
                          break;
                        case 30:
                          text = '30';
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
                  color: Theme.of(context).primaryColor,
                  isCurved: false,
                  spots: flSpotList,
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
        Column(
          children: _top4monthlyCategories(
            _expenseController.top4MonthlyCategories(expenses),
          ),
        ),
      ],
    );
  }
}
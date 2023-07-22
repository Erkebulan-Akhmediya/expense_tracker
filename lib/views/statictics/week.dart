import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:expense_tracker/views/statictics/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Week extends StatelessWidget {
  Week({super.key, required this.user});

  final UserModel user;

  final ExpenseController _expenseController = Get.find<ExpenseController>();

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

  List<Widget> _top4weeklyCategories(List<MapEntry<String, double>> list) {
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
    return ListView(
      padding: const EdgeInsets.only(top: 60, right: 30, bottom: 10, left: 30),
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              minX: 0,
              minY: 0,
              maxX: 6,
              maxY: maxSpentDay(
                _expenseController.weeklyStats(user.expenses),
              ),
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
                  spots: _expenseController.weeklyStats(user.expenses),
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
          children: _top4weeklyCategories(
            _expenseController.top4WeeklyCategories(user.expenses),
          ),
        ),
      ],
    );
  }
}
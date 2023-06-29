import 'package:expense_tracker/views/home/expense.dart';
import 'package:expense_tracker/views/statictics/week.dart';
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
          body: const TabBarView(
            children: [
              Week(),
              Text('2'),
              Text('3'),
            ],
          ),
        ),
    );
  }

}
import 'package:expense_tracker/views/statictics/month.dart';
import 'package:expense_tracker/views/statictics/week.dart';
import 'package:expense_tracker/views/statictics/year.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Statistics',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Week',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'Year',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Week(),
              Month(),
              Year(),
            ],
          ),
        ),
    );
  }

}
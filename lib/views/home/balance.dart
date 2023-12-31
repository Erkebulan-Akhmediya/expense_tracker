import 'package:expense_tracker/views/home/today.dart';
import 'package:expense_tracker/views/home/week_month.dart';
import 'package:flutter/material.dart';


class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Today(),
            WeekMonth(),
          ],
        ),
      ),
    );
  }

}
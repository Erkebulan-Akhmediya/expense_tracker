import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../controllers/auth.controller.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();

}

class _TodayState extends State<Today> {
  late Future<List> expenses;

  final ExpenseController _expenseController = Get.put(ExpenseController());
  final User? user = Get.put(AuthController()).currentUser;

  @override
  void initState() {
    super.initState();
    expenses = _expenseController.getUserExpenses(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            FutureBuilder<double>(
              future: _expenseController.todayExpenses(expenses),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    '\$${snapshot.data}',
                    style: TextStyle(
                      fontSize: 45,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  );
                } else {
                  return SkeletonTheme(
                    shimmerGradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.4),
                        Theme.of(context).primaryColor.withOpacity(0.6),
                      ],
                    ),
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 1,
                        lineStyle: SkeletonLineStyle(
                          height: 36,
                          width: 140,
                        ),
                      ),
                    ),
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
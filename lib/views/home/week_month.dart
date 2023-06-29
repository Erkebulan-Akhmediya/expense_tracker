import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../controllers/auth.controller.dart';
import '../../controllers/expense.controller.dart';

class WeekMonth extends StatefulWidget {
  const WeekMonth({super.key});

  @override
  State<WeekMonth> createState() => _WeekMonthState();

}

class _WeekMonthState extends State<WeekMonth> {
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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('This Week'),
                  FutureBuilder<double>(
                    future: _expenseController.thisWeek(expenses),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          '\$${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        );
                      } else {
                        return SkeletonTheme(
                          shimmerGradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ],
                          ),
                          child: SkeletonParagraph(
                            style: const SkeletonParagraphStyle(
                              lines: 1,
                              lineStyle: SkeletonLineStyle(
                                height: 20,
                                width: 100,
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
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const Text('This Month'),
                  FutureBuilder<double>(
                    future: _expenseController.thisMonth(expenses),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          '\$${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SkeletonTheme(
                              shimmerGradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade600,
                                ],
                              ),
                              child: SkeletonParagraph(
                                style: const SkeletonParagraphStyle(
                                  lines: 1,
                                  lineStyle: SkeletonLineStyle(
                                    height: 20,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
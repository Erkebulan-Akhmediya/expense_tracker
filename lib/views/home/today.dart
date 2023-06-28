import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    _expenseController.todayExpenses(expenses);
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
              const Text('Today'),
              FutureBuilder<double>(
                future: _expenseController.todayExpenses(expenses),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      '\$${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 45,
                      ),
                    );
                  } else {
                    return const Text('no data');
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}
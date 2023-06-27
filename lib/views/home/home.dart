import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/views/home/expense.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/expense.model.dart';
import 'balance.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final UserController _userController = UserController();
  final ExpenseController _expenseController = ExpenseController();
  final User? user = AuthController().currentUser;

  Stream<List<dynamic>> getUserExpenses(String uid) {
    return _expenseController.getUserExpenses(uid);
  }

  Future<List<ExpenseModel>> getExpenses(List expenses) {
    return _expenseController.getExpenses(expenses);
  }

  List<Widget> last4Expenses(List<ExpenseModel> list) {
    ExpenseModel temp;
    bool swapped;
    for (var i = 0; i < list.length-1; i++) {
      swapped = false;
      for (var j = 0; j < list.length - i - 1; j++) {
        if (DateTime.parse(list[j+1].date).isBefore(DateTime.parse(list[j].date))) {
          temp = list[j];
          list[j] = list[j+1];
          list[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) break;
    }

    int n = list.length-1;
    List<Widget> widgets = [];
    for (int i = 0; i < 4; i++) {
      if (n - i >= 0) {
        widgets.add(
          Expense(
            category: list[n-i].category,
            name: list[n-i].name,
            date: list[n-i].date,
            amount: list[n-i].amount,
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Good afternoon,',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            StreamBuilder<UserModel>(
              stream: _userController.getUsername(user?.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.username,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  );
                } else {
                  return const Text(
                    'error',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Balance(today: 228,),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 3,
            ),
            child: const Text(
              'Expense History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder(
            stream: getUserExpenses(user!.uid),
            builder: (context, snapshot) {
              List<dynamic>? expenses = snapshot.data;
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: getExpenses(expenses!),
                  builder: (context, snapshot) {
                    if (snapshot.data!.isNotEmpty) {
                      List<ExpenseModel>? data = snapshot.data;
                      return Column(
                        children: last4Expenses(data!),
                      );
                    } else {
                      return const Text('There is no expenses yet');
                    }
                  },
                );
              } else {
                return const Text('There is no expenses yet');
              }
            },
          ),
        ],
      ),
    );
  }

}
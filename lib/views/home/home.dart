import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/expense.model.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:expense_tracker/views/home/balance.dart';
import 'package:expense_tracker/views/home/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final UserController _userController = Get.find<UserController>();
  final ExpenseController _expenseController = Get.find<ExpenseController>();
  final AuthController _authController = Get.find<AuthController>();

  List<Widget> _last4expenses(List<ExpenseModel> expenses) {
    List<Widget> widgets = [];

    for (ExpenseModel expense in expenses) {
      widgets.add(
        Expense(
          category: expense.category,
          name: expense.name,
          date: expense.date,
          amount: expense.amount,
        ),
      );
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
            Text(
              'good_afternoon'.tr,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            StreamBuilder<UserModel>(
              stream: _userController.getUser(
                _authController.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.username,
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
          const Balance(),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 3,
            ),
            child: Text(
              'expense_history'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          StreamBuilder(
            stream: _userController.getUser(
              _authController.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ExpenseModel> expenses = _expenseController.last4Expenses(
                  snapshot.data!.expenses,
                );
                return Column(
                  children: _last4expenses(expenses),
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
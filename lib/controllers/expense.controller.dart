import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/expense.model.dart';
import 'package:expense_tracker/views/statictics/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/home/expense.dart';

class ExpenseController extends GetxController {
  ExpenseController();

  final UserController _userController = UserController();
  final _db = FirebaseFirestore.instance;

  Future<void> createExpense(ExpenseModel expense) async {
    DocumentReference docRef = await _db.collection('Expenses').add(
      expense.toMap(),
    );
    _userController.addExpenseToUser(
      AuthController().currentUser?.uid, docRef.id,
    );
  }

  Future<List> getUserExpenses(String uid) async {
    Future<List> future = _db.collection('Users').doc(uid).get().then(
      (snapshot) => snapshot['expenses'],
    );
    return future;
  }

  Future<List<ExpenseModel>> getExpenses(List expenses) async {
    CollectionReference expenseCollection = _db.collection('Expenses');
    List<ExpenseModel> expenseModelList = [];

    for (dynamic expense in expenses) {
      DocumentSnapshot snapshot = await expenseCollection.doc(
        expense.toString(),
      ).get();
      ExpenseModel expenseModel = ExpenseModel(
        category: snapshot['category'],
        name: snapshot['name'],
        amount: snapshot['amount'],
        date: snapshot['date'],
      );
      expenseModelList.add(expenseModel);
    }

    return expenseModelList;
  }

  List<Widget> last4Expenses(List<ExpenseModel> list) {
    ExpenseModel temp;
    bool swapped;
    for (var i = 0; i < list.length-1; i++) {
      swapped = false;
      for (var j = 0; j < list.length - i - 1; j++) {
        if (DateTime.parse(list[j+1].date).isBefore(
          DateTime.parse(list[j].date),
        )) {
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
  
  Future<double> todayExpenses(Future<List> expenses) {
    double sum = 0;

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          for (ExpenseModel expense in expenseModels) {
            DateTime targetDate = DateTime.parse(expense.date);
            DateTime compareDate = DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
            );
            if (targetDate.compareTo(compareDate) == 0) {
              sum = sum + expense.amount;
            }
          }
          return sum;
        },
      ),
    );
  }

  Future<double> thisWeek(Future<List> expenses) {
    double sum = 0;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          for (ExpenseModel expense in expenseModels) {
            DateTime targetDate = DateTime.parse(expense.date);
            if (targetDate.isAfter(startOfWeek) &&
                targetDate.isBefore(endOfWeek)) {
              sum = sum + expense.amount;
            }
          }
          return sum;
        }
      ),
    );
  }

  Future<double> thisMonth(Future<List> expenses) {
    double sum = 0;
    DateTime now = DateTime.now();

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          for (ExpenseModel expense in expenseModels) {
            DateTime targetDate = DateTime.parse(expense.date);
            if (targetDate.year == now.year && targetDate.month == now.month) {
              sum = sum + expense.amount;
            }
          }
          return sum;
        },
      ),
    );
  }

  Future<List<FlSpot>> weeklyStats(Future<List> expenses) {
    List<double> amounts = [0, 0, 0, 0, 0, 0, 0];
    int index = 0;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          while (startOfWeek.isBefore(endOfWeek)) {

            for (ExpenseModel expense in expenseModels) {
              DateTime targetDate = DateTime.parse(expense.date);
              DateTime compareDate = DateTime.parse(
                DateFormat('yyyy-MM-dd').format(startOfWeek),
              );
              if (targetDate.compareTo(compareDate) == 0) {
                amounts[index] += expense.amount;
              }
            }

            index++;
            startOfWeek = startOfWeek.add(const Duration(days: 1));
          }
          return [
            FlSpot(0, amounts[0]),
            FlSpot(1, amounts[1]),
            FlSpot(2, amounts[2]),
            FlSpot(3, amounts[3]),
            FlSpot(4, amounts[4]),
            FlSpot(5, amounts[5]),
            FlSpot(6, amounts[6]),
          ];
        },
      ),
    );
  }

  List<Widget> top4WeeklyCategories(List<ExpenseModel> expenses) {
    Map<String, double> categories = {
      'Uncategorized': 0,
      'Housing': 0,
      'Transportation': 0,
      'Food': 0,
      'Health and Medical': 0,
      'Personal Care': 0,
      'Entertainment': 0,
      'Debt Payments': 0,
      'Education': 0,
      'Clothing and Accessories': 0,
      'Savings and Investments': 0,
    };

    List<Widget> widgets = [];

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // calculating categories
    for (String category in categories.keys) {
      for (ExpenseModel expense in expenses) {

        DateTime targetDate = DateTime.parse(expense.date);
        bool isInWeek = targetDate.isAfter(startOfWeek) &&
            targetDate.isBefore(endOfWeek);

        if (expense.category == category && isInWeek == true) {
          categories[category] = categories[category]! + expense.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<String, double>> first4Categories = entries.sublist(0, 4);

    // creating widgets
    for (MapEntry<String, double> entry in first4Categories) {
      widgets.add(
        Category(
          category: entry.key,
          amount: entry.value,
        ),
      );
    }
    return widgets;
  }

  Future<List<FlSpot>> monthlyStats(Future<List> expenses) {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    List<double> amounts = List<double>.generate(daysInMonth, (index) => 0);
    int index = 0;

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          while (firstDayOfMonth.isBefore(lastDayOfMonth)) {

            for (ExpenseModel expense in expenseModels) {
              DateTime targetDate = DateTime.parse(expense.date);
              DateTime compareDate = DateTime.parse(
                DateFormat('yyyy-MM-dd').format(firstDayOfMonth),
              );
              if (targetDate.compareTo(compareDate) == 0) {
                amounts[index] += expense.amount;
              }
            }

            index++;
            firstDayOfMonth = firstDayOfMonth.add(const Duration(days: 1));
          }

          return [
            for (int i = 0; i < daysInMonth; i++)
              FlSpot(i.toDouble()+1, amounts[i])
          ];
        },
      ),
    );
  }

  List<Widget> top4MonthlyCategories(List<ExpenseModel> expenses) {
    Map<String, double> categories = {
      'Uncategorized': 0,
      'Housing': 0,
      'Transportation': 0,
      'Food': 0,
      'Health and Medical': 0,
      'Personal Care': 0,
      'Entertainment': 0,
      'Debt Payments': 0,
      'Education': 0,
      'Clothing and Accessories': 0,
      'Savings and Investments': 0,
    };

    List<Widget> widgets = [];

    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    // calculating categories
    for (String category in categories.keys) {
      for (ExpenseModel expense in expenses) {
        DateTime targetDate = DateTime.parse(expense.date);
        bool isInMonth = targetDate.isAfter(
          firstDayOfMonth.subtract(const Duration(days: 1)),
        ) && targetDate.isBefore(
          lastDayOfMonth.add(const Duration(days: 1)),
        );

        if (expense.category == category && isInMonth == true) {
          categories[category] = categories[category]! + expense.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<String, double>> first4Categories = entries.sublist(0, 4);

    // creating widgets
    for (MapEntry<String, double> entry in first4Categories) {
      widgets.add(
        Category(
          category: entry.key,
          amount: entry.value,
        ),
      );
    }
    return widgets;
  }

  List<FlSpot> eachMonthSum(List<ExpenseModel> expenses) {
    List<double> amounts = List<double>.generate(12, (index) => 0);

    for (int month = 1; month <= 12; month++) {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, month, 1);
      DateTime lastDayOfMonth = DateTime(now.year, month + 1, 0);

      while (firstDayOfMonth.isBefore(lastDayOfMonth)) {

        for (ExpenseModel expense in expenses) {
          DateTime targetDate = DateTime.parse(expense.date);
          DateTime compareDate = DateTime.parse(
            DateFormat('yyyy-MM-dd').format(firstDayOfMonth),
          );
          if (targetDate.compareTo(compareDate) == 0) {
            amounts[month-1] += expense.amount;
          }
        }
        firstDayOfMonth = firstDayOfMonth.add(const Duration(days: 1));
      }
    }

    return [
      for (int i = 0; i < 12; i++)
        FlSpot(i.toDouble()+1, amounts[i])
    ];
  }

  Future<List<FlSpot>> yearlyStats(Future<List> expenses) => expenses.then(
    (list) => getExpenses(list).then(
      (expenseModels) => eachMonthSum(expenseModels),
    ),
  );

  List<Widget> top4YearlyCategories(List<ExpenseModel> expenses) {
    Map<String, double> categories = {
      'Uncategorized': 0,
      'Housing': 0,
      'Transportation': 0,
      'Food': 0,
      'Health and Medical': 0,
      'Personal Care': 0,
      'Entertainment': 0,
      'Debt Payments': 0,
      'Education': 0,
      'Clothing and Accessories': 0,
      'Savings and Investments': 0,
    };

    // calculating categories
    for (String category in categories.keys) {
      for (ExpenseModel expense in expenses) {
        DateTime targetDate = DateTime.parse(expense.date);

        if (expense.category == category &&
            targetDate.year == DateTime.now().year) {
          categories[category] = categories[category]! + expense.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<String, double>> first4Categories = entries.sublist(0, 4);

    // creating widgets
    List<Widget> widgets = [];
    for (MapEntry<String, double> entry in first4Categories) {
      widgets.add(
        Category(
          category: entry.key,
          amount: entry.value,
        ),
      );
    }
    return widgets;
  }

}
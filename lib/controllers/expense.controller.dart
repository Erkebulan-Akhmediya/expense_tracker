import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense.model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<void> createExpense(String uid, ExpenseModel expense) async {
    _db.collection('Users').doc(uid).update({
      'expenses': FieldValue.arrayUnion([
        json.encode(expense.toMap()),
      ]),
    });
  }

  List<ExpenseModel> last4Expenses(List<String> list) {
    String temp;
    bool swapped;
    for (var i = 0; i < list.length-1; i++) {
      swapped = false;
      for (var j = 0; j < list.length - i - 1; j++) {
        if (DateTime.parse(ExpenseModel.fromMap(json.decode(list[j+1])).date).isBefore(
          DateTime.parse(ExpenseModel.fromMap(json.decode(list[j])).date),
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
    List<ExpenseModel> expenses = [];
    for (int i = 0; i < 4; i++) {
      if (n - i >= 0) {
        expenses.add(ExpenseModel.fromMap(json.decode(list[n-i])));
      }
    }
    print(expenses);
    return expenses;
  }
  
  double todayExpenses(List<String> expenses) {
    double sum = 0;

    for (String expense in expenses) {
      ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
      DateTime targetDate = DateTime.parse(expenseModel.date);
      DateTime compareDate = DateTime.parse(
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      if (targetDate.compareTo(compareDate) == 0) {
        sum = sum + expenseModel.amount;
      }
    }
    return sum;
  }

  double thisWeek(List<String> expenses) {
    double sum = 0;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    for (String expense in expenses) {
      ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
      DateTime targetDate = DateTime.parse(expenseModel.date);
      if (targetDate.isAfter(startOfWeek) &&
          targetDate.isBefore(endOfWeek)) {
        sum = sum + expenseModel.amount;
      }
    }
    return sum;
  }

  double thisMonth(List<String> expenses) {
    double sum = 0;
    DateTime now = DateTime.now();

    for (String expense in expenses) {
      ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
      DateTime targetDate = DateTime.parse(expenseModel.date);
      if (targetDate.year == now.year && targetDate.month == now.month) {
        sum = sum + expenseModel.amount;
      }
    }
    return sum;
  }

  List<FlSpot> weeklyStats(List<String> expenses) {
    List<double> amounts = [0, 0, 0, 0, 0, 0, 0];
    int index = 0;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    while (startOfWeek.isBefore(endOfWeek)) {

      for (String expense in expenses) {
        ExpenseModel expenseModel = ExpenseModel.fromMap(
          json.decode(expense),
        );
        DateTime targetDate = DateTime.parse(expenseModel.date);
        DateTime compareDate = DateTime.parse(
          DateFormat('yyyy-MM-dd').format(startOfWeek),
        );
        if (targetDate.compareTo(compareDate) == 0) {
          amounts[index] += expenseModel.amount;
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
  }

  List<MapEntry<String, double>> top4WeeklyCategories(List<String> expenses) {
    Map<String, double> categories = {
      'uncategorized': 0,
      'housing': 0,
      'transportation': 0,
      'food': 0,
      'health_and_medical': 0,
      'personal_care': 0,
      'entertainment': 0,
      'debt_payments': 0,
      'education': 0,
      'clothing_and_accessories': 0,
      'savings_and_investments': 0,
    };

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // calculating categories
    for (String category in categories.keys) {
      for (String expense in expenses) {

        ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
        DateTime targetDate = DateTime.parse(expenseModel.date);
        bool isInWeek = targetDate.isAfter(startOfWeek) &&
            targetDate.isBefore(endOfWeek);

        if (expenseModel.category == category && isInWeek == true) {
          categories[category] = categories[category]! + expenseModel.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));

    return entries.sublist(0, 4);
  }

  List<FlSpot> monthlyStats(List<String> expenses) {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    List<double> amounts = List<double>.generate(daysInMonth, (index) => 0);
    int index = 0;

    while (firstDayOfMonth.isBefore(lastDayOfMonth)) {

      for (String expense in expenses) {
        ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
        DateTime targetDate = DateTime.parse(expenseModel.date);
        DateTime compareDate = DateTime.parse(
          DateFormat('yyyy-MM-dd').format(firstDayOfMonth),
        );
        if (targetDate.compareTo(compareDate) == 0) {
          amounts[index] += expenseModel.amount;
        }
      }

      index++;
      firstDayOfMonth = firstDayOfMonth.add(const Duration(days: 1));
    }

    return [
      for (int i = 0; i < daysInMonth; i++)
        FlSpot(i.toDouble()+1, amounts[i])
    ];
  }

  List<MapEntry<String, double>> top4MonthlyCategories(List<String> expenses) {
    Map<String, double> categories = {
      'uncategorized': 0,
      'housing': 0,
      'transportation': 0,
      'food': 0,
      'health_and_medical': 0,
      'personal_care': 0,
      'entertainment': 0,
      'debt_payments': 0,
      'education': 0,
      'clothing_and_accessories': 0,
      'savings_and_investments': 0,
    };

    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    // calculating categories
    for (String category in categories.keys) {
      for (String expense in expenses) {
        ExpenseModel expenseModel = ExpenseModel.fromMap(json.decode(expense));
        DateTime targetDate = DateTime.parse(expenseModel.date);
        bool isInMonth = targetDate.isAfter(
          firstDayOfMonth.subtract(const Duration(days: 1)),
        ) && targetDate.isBefore(
          lastDayOfMonth.add(const Duration(days: 1)),
        );

        if (expenseModel.category == category && isInMonth == true) {
          categories[category] = categories[category]! + expenseModel.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.sublist(0, 4);
  }

  List<FlSpot> yearlyStats(List<String> expenses) {
    List<double> amounts = List<double>.generate(12, (index) => 0);

    for (int month = 1; month <= 12; month++) {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, month, 1);
      DateTime lastDayOfMonth = DateTime(now.year, month + 1, 0);

      while (firstDayOfMonth.isBefore(lastDayOfMonth)) {

        for (String expense in expenses) {
          ExpenseModel expenseModel = ExpenseModel.fromMap(
            json.decode(expense)
          );
          DateTime targetDate = DateTime.parse(expenseModel.date);
          DateTime compareDate = DateTime.parse(
            DateFormat('yyyy-MM-dd').format(firstDayOfMonth),
          );
          if (targetDate.compareTo(compareDate) == 0) {
            amounts[month-1] += expenseModel.amount;
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

  List<MapEntry<String, double>> top4YearlyCategories(List<String> expenses) {
    Map<String, double> categories = {
      'uncategorized': 0,
      'housing': 0,
      'transportation': 0,
      'food': 0,
      'health_and_medical': 0,
      'personal_care': 0,
      'entertainment': 0,
      'debt_payments': 0,
      'education': 0,
      'clothing_and_accessories': 0,
      'savings_and_investments': 0,
    };

    // calculating categories
    for (String category in categories.keys) {
      for (String expense in expenses) {
        ExpenseModel expenseModel = ExpenseModel.fromMap(
          json.decode(expense)
        );
        DateTime targetDate = DateTime.parse(expenseModel.date);

        if (expenseModel.category == category &&
            targetDate.year == DateTime.now().year) {
          categories[category] = categories[category]! + expenseModel.amount;
        }
      }
    }

    // sorting categories
    List<MapEntry<String, double>> entries = categories.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));

    return entries.sublist(0, 4);
  }

}
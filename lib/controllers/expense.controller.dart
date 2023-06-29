import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/expense.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/home/expense.dart';

class ExpenseController extends GetxController {
  ExpenseController();

  final UserController _userController = UserController();
  final _db = FirebaseFirestore.instance;

  Future<void> createExpense(ExpenseModel expense) async {
    DocumentReference docRef = await _db.collection('Expenses').add(expense.toMap());
    _userController.addExpenseToUser(AuthController().currentUser?.uid, docRef.id);
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
  
  Future<double> todayExpenses(Future<List> expenses) {
    double sum = 0;

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          for (ExpenseModel expense in expenseModels) {
            if (DateTime.parse(expense.date).compareTo(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))) == 0) {
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
            bool isInWeek = targetDate.isAfter(startOfWeek) && targetDate.isBefore(endOfWeek);
            if (isInWeek == true) {
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
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    return expenses.then(
      (list) => getExpenses(list).then(
        (expenseModels) {
          for (ExpenseModel expense in expenseModels) {
            DateTime targetDate = DateTime.parse(expense.date);
            bool isInMonth = targetDate.isAfter(firstDayOfMonth) && targetDate.isBefore(lastDayOfMonth);
            if (isInMonth == true) {
              sum = sum + expense.amount;
            }
          }
          return sum;
        },
      ),
    );
  }

}
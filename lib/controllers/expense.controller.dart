import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/expense.model.dart';

class ExpenseController {
  ExpenseController();

  final UserController _userController = UserController();
  final _db = FirebaseFirestore.instance;

  Future<void> createExpense(ExpenseModel expense) async {
    DocumentReference docRef = await _db.collection('Expenses').add(expense.toMap());
    _userController.addExpenseToUser(AuthController().currentUser?.uid, docRef.id);
  }

  getExpense(String id) {
    DocumentReference expense = _db.collection('Expenses').doc(id);
  }

  Stream<List<dynamic>> getUserExpenses(String uid) {
    DocumentReference user = _db.collection('Users').doc(uid);
    Stream<List<dynamic>> expenses = user.snapshots().map((snapshot) {
      snapshot['expenses'];
      return snapshot['expenses'];
    });

    return expenses;
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
}
import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/views/auth/signin_signup.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  Root({super.key});

  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());
  final ExpenseController _expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authController.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return SignInSignUp();
        }
      },
    );
  }

}
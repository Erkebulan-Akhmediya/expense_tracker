import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/views/home/expense.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'balance.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final UserController _userController = UserController();
  final User? user = AuthController().currentUser;

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
          const Balance(),
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
          const Column(
            children: <Widget>[
              Expense(
                categoryIcon: Icons.attach_money_rounded,
                name: 'Netflix',
                date: 'Yesterday',
                amount: 700,
              ),
              Expense(
                categoryIcon: Icons.attach_money_rounded,
                name: 'PayPal',
                date: '21 Jun, 2023',
                amount: 1500,
              ),
              Expense(
                categoryIcon: Icons.attach_money_rounded,
                name: 'Shopify',
                date: '12 Jun, 2023',
                amount: 1000,
              ),
              Expense(
                categoryIcon: Icons.attach_money_rounded,
                name: 'Shopify',
                date: '01 Jun, 2023',
                amount: 1200,
              ),
            ],
          ),
        ],
      ),
    );
  }

}
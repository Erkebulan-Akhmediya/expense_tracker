import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:expense_tracker/views/statictics/month.dart';
import 'package:expense_tracker/views/statictics/week.dart';
import 'package:expense_tracker/views/statictics/year.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Statistics extends StatelessWidget {
  Statistics({super.key});

  final UserController _userController = Get.find<UserController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'statistics'.tr,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'week'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'month'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    'year'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          body: StreamBuilder<UserModel>(
            stream: _userController.getUser(
              _authController.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data!;
                return TabBarView(
                  children: [
                    Week(user: user),
                    Month(user: user),
                    Year(user: user),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
    );
  }

}
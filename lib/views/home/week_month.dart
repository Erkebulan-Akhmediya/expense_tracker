import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class WeekMonth extends StatelessWidget {
  WeekMonth({super.key});

  final ExpenseController _expenseController = Get.find<ExpenseController>();
  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: StreamBuilder<UserModel>(
        stream: _userController.getUser(
          _authController.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'this_week'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '\$${
                              _expenseController.thisWeek(snapshot.data!.expenses)
                          }',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'this_month'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '\$${
                              _expenseController.thisMonth(snapshot.data!.expenses)
                          }',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SkeletonTheme(
                  shimmerGradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).primaryColor.withOpacity(0.6),
                    ],
                  ),
                  child: SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 20,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
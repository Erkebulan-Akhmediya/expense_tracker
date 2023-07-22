import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class Today extends StatelessWidget {
  Today({super.key});

  final ExpenseController _expenseController = Get.find<ExpenseController>();
  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'today'.tr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            StreamBuilder<UserModel>(
              stream: _userController.getUser(
                _authController.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '\$${
                      _expenseController.todayExpenses(snapshot.data!.expenses)
                    }',
                    style: TextStyle(
                      fontSize: 45,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  );
                } else {
                  return SkeletonTheme(
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
                          height: 36,
                          width: 140,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:expense_tracker/controllers/navigation.controller.dart';
import 'package:expense_tracker/views/profile/profile.dart';
import 'package:expense_tracker/views/statictics/statistics.dart';
import 'package:expense_tracker/views/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home/home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NavController _navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: _navController.currentPageIndex.value,
          children: [
            const Home(),
            const Statistics(),
            const Wallet(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _navController.currentPageIndex.value,
          onTap: _navController.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet_rounded),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
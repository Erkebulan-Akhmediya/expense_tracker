import 'package:expense_tracker/views/profile/profile.dart';
import 'package:expense_tracker/views/statictics/statistics.dart';
import 'package:expense_tracker/views/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Statistics(),
    const Wallet(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_rounded),
            label: 'statistics'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.wallet_rounded),
            label: 'wallet'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: 'profile'.tr,
          ),
        ],
      ),
    );
  }
}
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(MyApp().primaryTheme);
            },
            child: const Text('Light'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(MyApp().darkTheme);
            },
            child: const Text('Dark'),
          ),
        ],
      ),
    );
  }

}
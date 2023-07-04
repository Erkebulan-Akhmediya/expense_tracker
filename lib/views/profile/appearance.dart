import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appearance'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(MyApp().primaryTheme);
            },
            child: Text('light'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.changeTheme(MyApp().darkTheme);
            },
            child: Text('dark'.tr),
          ),
        ],
      ),
    );
  }

}
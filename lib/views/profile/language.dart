import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(const Locale('en', 'UK'));
            },
            child: Text('english'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(const Locale('kk', 'KK'));
            },
            child: Text('kazakh'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.updateLocale(const Locale('ru', 'RU'));
            },
            child: Text('russian'.tr),
          ),
        ],
      ),
    );
  }

}
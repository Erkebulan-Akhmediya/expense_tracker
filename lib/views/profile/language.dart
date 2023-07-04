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
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            child: Text('english'.tr),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('kazakh'.tr),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('russian'.tr),
          ),
        ],
      ),
    );
  }

}
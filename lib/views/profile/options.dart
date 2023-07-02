import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';

class Options extends StatelessWidget {
  Options({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Row(
            children: <Widget>[
              Icon(Icons.person_rounded),
              Text('Account Info'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: <Widget>[
              Icon(Icons.format_paint_rounded),
              Text('Appearance'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: <Widget>[
              Icon(Icons.language_rounded),
              Text('Language'),
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            await _authController.signOut();
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.exit_to_app_outlined),
              Text('Log Out'),
            ],
          ),
        ),
      ],
    );
  }

}
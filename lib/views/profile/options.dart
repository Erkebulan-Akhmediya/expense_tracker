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
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: const Icon(Icons.person_rounded),
              ),
              const Text('Account Info'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: const Icon(Icons.format_paint_rounded),
              ),
              const Text('Appearance'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: const Icon(Icons.language_rounded),
              ),
              const Text('Language'),
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            await _authController.signOut();
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: const Icon(Icons.exit_to_app_outlined),
              ),
              const Text('Log Out'),
            ],
          ),
        ),
      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';

class Options extends StatelessWidget {
  Options({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 40,
                  ),
                ),
                const Text(
                  'Account Info',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.format_paint_rounded,
                    size: 40,
                  ),
                ),
                const Text(
                  'Appearance',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.language_rounded,
                    size: 40,
                  ),
                ),
                const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.exit_to_app_outlined,
                    size: 40,
                  ),
                ),
                const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
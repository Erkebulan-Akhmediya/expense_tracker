import 'package:expense_tracker/views/profile/appearance.dart';
import 'package:expense_tracker/views/profile/language.dart';
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
        Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: TextButton(
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
                Text('account_info'.tr),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Appearance(),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.format_paint_rounded,
                    size: 40,
                  ),
                ),
                Text('appearance'.tr),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Language(),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.language_rounded,
                    size: 40,
                  ),
                ),
                Text('language'.tr),
              ],
            ),
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
              Text('log_out'.tr),
            ],
          ),
        ),
      ],
    );
  }

}
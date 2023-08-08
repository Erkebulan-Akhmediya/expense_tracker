import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/views/profile/options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.person_pin,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                StreamBuilder(
                  stream: _userController.getUser(_authController.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.username,
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      );
                    } else {
                      return SkeletonParagraph(
                        style: const SkeletonParagraphStyle(
                          lines: 1,
                        ),
                      );
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text(
                    _authController.currentUser!.email!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Options(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
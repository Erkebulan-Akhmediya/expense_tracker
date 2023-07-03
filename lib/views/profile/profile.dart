import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/views/profile/options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const Icon(
                      Icons.person_pin,
                      size: 100,
                    ),
                  ),
                  StreamBuilder(
                    stream: _userController.getUsername(_authController.currentUser?.uid),
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
                    child: Text(_authController.currentUser!.email!),
                  ),
                  Options(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
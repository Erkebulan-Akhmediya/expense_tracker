import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {
  String? errorMessage = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerificationController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      verifyPassword(
        _passwordController.text,
        _passwordVerificationController.text,
      );
      await AuthController().createUserWithEmailAndPassword(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void verifyPassword(String firstPassword, String secondPassword) {
    if (firstPassword != secondPassword) {
      throw FirebaseAuthException(
        code: 'operation-not-allowed',
        message: 'Password Verification Failed',
      );
    }
  }

  Widget _error() {
    if (errorMessage == '') {
      return Container();
    } else {
      return Text(
        errorMessage!,
        style: const TextStyle(
          color: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          width: 300,
          height: 500,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Icon(
                  Icons.app_registration_rounded,
                  size: 40,
                ),
                Text(
                  'sign_up'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                _error(),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_rounded),
                    labelText: 'username'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                    labelText: 'email_address'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    labelText: 'password'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _passwordVerificationController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    labelText: 'verify_password'.tr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        ),
                        onPressed: createUserWithEmailAndPassword,
                        child: Text(
                          'sign_up'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('swipe_right'.tr)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
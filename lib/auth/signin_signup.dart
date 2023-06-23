import 'package:expense_tracker/auth/sign_in.dart';
import 'package:expense_tracker/auth/sign_up.dart';
import 'package:flutter/material.dart';

class SignInSignUp extends StatelessWidget {
  SignInSignUp({super.key});

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          SignIn(),
          SignUp(),
        ],
      ),
    );
  }

}
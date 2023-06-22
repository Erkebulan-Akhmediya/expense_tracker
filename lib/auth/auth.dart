import 'package:expense_tracker/auth/signin_signup.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  bool isAuth() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (isAuth() == true) {
      return const HomePage();
    } else {
      return SignInSignUp();
    }
  }

}
import 'package:expense_tracker/auth/auth.dart';
import 'package:expense_tracker/auth/signin_signup.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<StatefulWidget> createState() => _RootState();

}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return SignInSignUp();
        }
      },
    );
  }

}
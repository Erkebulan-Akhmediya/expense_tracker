import 'package:expense_tracker/controllers/auth.controller.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<void> signOut() async {
    await AuthController().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: signOut,
        child: const Text('Sign Out'),
      ),
    );
  }
}
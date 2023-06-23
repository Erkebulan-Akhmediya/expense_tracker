import 'package:flutter/material.dart';

import 'auth.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      // TODO: implement error message
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
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    labelText: 'Verify Password',
                    border: OutlineInputBorder(),
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
                        child:  const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: <Widget>[
                    Text('Already have an account? Swipe right')
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
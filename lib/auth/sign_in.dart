import 'package:expense_tracker/auth/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
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
          height: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Icon(
                  Icons.login_rounded,
                  size: 40,
                ),
                const Text(
                  'Sign In',
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        ),
                        onPressed: signInWithEmailAndPassword,
                        child:  const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Row(
                  children: <Widget>[
                    Text('Don\'t have an account? Swipe left'),
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
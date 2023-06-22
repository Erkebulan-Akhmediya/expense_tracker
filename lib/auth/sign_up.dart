import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
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
                        onPressed: () {},
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
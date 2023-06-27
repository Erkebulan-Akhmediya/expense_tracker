import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Today'),
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontSize: 45,
                ),
              ),
            ],
          ),
        )
    );
  }

}
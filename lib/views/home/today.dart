import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today'),
              Text(
                '\$500',
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
            ],
          ),
        )
    );
  }

}
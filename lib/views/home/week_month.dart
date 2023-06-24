import 'package:flutter/material.dart';

class WeekMonth extends StatelessWidget {
  const WeekMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('This Week'),
                  Text(
                    '\$1800',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 15),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('This Month'),
                    Text(
                      '\$2840',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({
    super.key,
    required this.categoryIcon,
    required this.name,
    required this.date,
    required this.amount,
  });

  final IconData categoryIcon;
  final String name;
  final String date;
  final int amount;

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    widget.categoryIcon,
                    size: 60,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.date),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${widget.amount}\$',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
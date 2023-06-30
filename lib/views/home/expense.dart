import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  Expense({
    super.key,
    required this.category,
    required this.name,
    required this.date,
    required this.amount,
  });

  final String category;
  final String name;
  final String date;
  final double amount;

  Map<String, IconData> icons = {
    'Uncategorized': Icons.attach_money_rounded,
    'Housing': Icons.house_rounded,
    'Transportation': Icons.emoji_transportation_rounded,
    'Food': Icons.fastfood_rounded,
    'Health and Medical': Icons.add_box_rounded,
    'Personal Care': Icons.person_rounded,
    'Entertainment': Icons.attractions_rounded,
    'Debt Payments': Icons.money_off_csred_rounded,
    'Education': Icons.menu_book,
    'Clothing and Accessories': Icons.checkroom_rounded,
    'Savings and Investments': Icons.savings_outlined,
  };

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
                    widget.icons[widget.category],
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
                  '\$${widget.amount}',
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
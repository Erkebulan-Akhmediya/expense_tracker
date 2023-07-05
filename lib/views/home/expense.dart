import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({
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

  final Map<String, IconData> icons = const {
    'uncategorized': Icons.attach_money_rounded,
    'housing': Icons.house_rounded,
    'transportation': Icons.emoji_transportation_rounded,
    'food': Icons.fastfood_rounded,
    'health_and_medical': Icons.add_box_rounded,
    'personal_care': Icons.person_rounded,
    'entertainment': Icons.attractions_rounded,
    'debt_payments': Icons.money_off_csred_rounded,
    'education': Icons.menu_book,
    'clothing_and_accessories': Icons.checkroom_rounded,
    'savings_and_investments': Icons.savings_outlined,
  };

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  widget.icons[widget.category],
                  size: 50,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Text(
                    widget.date,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '\$${widget.amount}',
                  style:
                  TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
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
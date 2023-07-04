import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.category,
    required this.amount,
  });

  final String category;
  final double amount;

  final Map<String, IconData> icons = const {
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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).primaryColor.withOpacity(0.3),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(
                    icons[category],
                    size: 40,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                Flexible(
                  child: Text(
                    category,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '\$$amount',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
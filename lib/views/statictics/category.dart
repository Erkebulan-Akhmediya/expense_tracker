import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.category,
    required this.amount,
  });

  final String category;
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
                    category.tr,
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
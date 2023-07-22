class ExpenseModel {
  final String category;
  final String name;
  final double amount;
  final String date;

  ExpenseModel({
    required this.category,
    required this.name,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'category': category,
    'name': name,
    'amount': amount,
    'date': date,
  };

  factory ExpenseModel.fromMap(Map<String, dynamic> expenseMap) => ExpenseModel(
    category: expenseMap['category'],
    name: expenseMap['name'],
    amount: expenseMap['amount'],
    date: expenseMap['date'],
  );
}
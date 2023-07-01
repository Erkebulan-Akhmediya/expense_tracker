import 'package:expense_tracker/controllers/expense.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/expense.model.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<StatefulWidget> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String _selectedCategory = 'Uncategorized';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> createExpense() async {
    try {
      await ExpenseController().createExpense(
        ExpenseModel(
          category: _selectedCategory,
          name: _nameController.text,
          amount: double.parse(_amountController.text),
          date: _dateController.text,
        ),
      );
      Get.snackbar(
        'Success',
        'Expense has been added',
        backgroundColor: Colors.green,
        overlayBlur: 1,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add expense',
        backgroundColor: Colors.red,
        overlayBlur: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Center(
        child: Material(
          elevation: 10,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 550,
            width: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Text(
                        'CATEGORY',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                      child: DropdownButton(
                        value: _selectedCategory,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'Uncategorized',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.attach_money_rounded),
                                Text('Uncategorized'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Housing',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.house_rounded),
                                Text('Housing'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Transportation',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.emoji_transportation_rounded),
                                Text('Transportation'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Food',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fastfood_rounded),
                                Text('Food'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Health and Medical',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add_box_rounded),
                                Text('Health and Medical'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Personal Care',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person_rounded),
                                Text('Personal Care'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Entertainment',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.attractions_rounded),
                                Text('Entertainment'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Debt Payments',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.money_off_csred_rounded),
                                Text('Debt Payments'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Education',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.menu_book),
                                Text('Education'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Clothing and Accessories',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.checkroom_rounded),
                                Text('Clothing and Accessories'),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Savings and Investments',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.savings_outlined),
                                Text('Savings and Investments'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (String? selectedValue) {
                          setState(() {
                            _selectedCategory = selectedValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Text(
                        'NAME',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Text(
                        'AMOUNT',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0),
                      child: Text(
                        'DATE',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          _dateController.text = formattedDate;
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: createExpense,
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
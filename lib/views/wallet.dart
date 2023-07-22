import 'package:expense_tracker/controllers/auth.controller.dart';
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
  String _selectedCategory = 'uncategorized';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();

  Future<void> createExpense() async {
    try {
      await ExpenseController().createExpense(
        _authController.currentUser!.uid,
        ExpenseModel(
          category: _selectedCategory,
          name: _nameController.text,
          amount: double.parse(_amountController.text),
          date: _dateController.text,
        ),
      );
      setState(() {
        _selectedCategory = 'uncategorized';
      });
      _nameController.text = '';
      _amountController.text = '';
      _dateController.text = '';
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
        title: Text('add_expense'.tr),
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
                        'category'.tr,
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
                        items: [
                          DropdownMenuItem(
                            value: 'uncategorized',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.attach_money_rounded),
                                Text('uncategorized'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'housing',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.house_rounded),
                                Text('housing'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'transportation',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.emoji_transportation_rounded),
                                Text('transportation'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'food',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.fastfood_rounded),
                                Text('food'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'health_and_medical',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.add_box_rounded),
                                Text('health_and_medical'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'personal_care',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.person_rounded),
                                Text('personal_care'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'entertainment',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.attractions_rounded),
                                Text('entertainment'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'debt_payments',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.money_off_csred_rounded),
                                Text('debt_payments'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'education',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.menu_book),
                                Text('education'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'clothing_and_accessories',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.checkroom_rounded),
                                Text('clothing_and_accessories'.tr),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'savings_and_investments',
                            child: Row(
                              children: <Widget>[
                                const Icon(Icons.savings_outlined),
                                Text('savings_and_investments'.tr),
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
                        'name'.tr,
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
                        'amount'.tr,
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
                        'date'.tr,
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
                    child: Text(
                      'add'.tr,
                      style: const TextStyle(
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
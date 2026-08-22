import 'package:flutter/material.dart';
import 'package:project_04_expense_tracker_v2/models/expense.dart';
import 'package:project_04_expense_tracker_v2/services/expense_service.dart';
import 'package:uuid/uuid.dart';

import '../models/category.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  Category selectedCategory = Category.food;
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final uuid = Uuid();
  final expenseService = ExpenseService();

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Expenses"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<Category>(
            value: selectedCategory,
            isExpanded: true,
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Expense name"),
            controller: nameController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            expenseService.addExpense(
              Expense(
                id: uuid.v4(),
                title: nameController.text,
                amount: double.parse(amountController.text),
                date: DateTime.now(),
                category: selectedCategory,
              ),
            );
            Navigator.pop(context);
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}

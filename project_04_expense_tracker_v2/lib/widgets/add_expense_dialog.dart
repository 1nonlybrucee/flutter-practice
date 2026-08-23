import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/expense.dart';
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

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Gastos pa!"),
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
            decoration: InputDecoration(
              labelText: "Gastos Description",
              hintText: 'jollibee',
            ),
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
            if (nameController.text.trim().isEmpty ||
                amountController.text.trim().isEmpty) {
              return;
            }
            final expense = Expense(
              id: uuid.v4(),
              title: nameController.text,
              amount: double.parse(amountController.text),
              date: DateTime.now(),
              category: selectedCategory,
            );
            Navigator.pop(context, expense);
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}

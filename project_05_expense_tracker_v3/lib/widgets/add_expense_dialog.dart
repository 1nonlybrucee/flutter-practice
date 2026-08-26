import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';

class AddExpenseDialog extends ConsumerStatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  ConsumerState<AddExpenseDialog> createState() {
    return _AddExpenseDialog();
  }
}

class _AddExpenseDialog extends ConsumerState<AddExpenseDialog> {
  Category selectedCategory = Category.kakanon;

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Gastos Pa!!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            initialValue: selectedCategory,
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedCategory = value;
              }
            },
          ),

          TextField(
            decoration: InputDecoration(label: Text("sain mo ginastos")),
            controller: nameController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text("pira ang gastos")),
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

            ref
                .read(expenseProvider.notifier)
                .addExpense(
                  Expense(
                    id: uuid.v4(),
                    name: nameController.text,
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

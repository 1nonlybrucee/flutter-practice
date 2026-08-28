import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense.dart';

class EditExpenseDialog extends ConsumerStatefulWidget {
  const EditExpenseDialog({super.key, required this.expense});

  final Expense expense;
  @override
  ConsumerState<EditExpenseDialog> createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends ConsumerState<EditExpenseDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.expense.name);
    _amountController = TextEditingController(
      text: widget.expense.amount.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit gastos"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "ngaran kang gastos"),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration: InputDecoration(labelText: "presyo"),
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
            final updatedExpense = widget.expense.copyWith(
              name: _nameController.text,
              amount: double.parse(_amountController.text),
            );
            Navigator.pop(context, updatedExpense);
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

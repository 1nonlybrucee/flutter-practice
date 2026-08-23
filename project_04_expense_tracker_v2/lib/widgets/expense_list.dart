import 'package:flutter/material.dart';
import 'package:project_04_expense_tracker_v2/models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return ListTile(
          title: Text(expense.title),
          subtitle: Text(expense.category.name),
          trailing: Text("₱${expense.amount.toStringAsFixed(2)}"),
        );
      },
    );
  }
}

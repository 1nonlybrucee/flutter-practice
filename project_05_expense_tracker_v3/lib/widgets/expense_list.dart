import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Expense> expenses = ref.watch(expenseProvider).reversed.toList();
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return ListTile(
          title: Text(expense.name),
          subtitle: Text(expense.category.name),
          trailing: Text("₱${expense.amount.toStringAsFixed(2)}"),
        );
      },
    );
  }
}

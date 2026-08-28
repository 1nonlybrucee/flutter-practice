import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key, this.selectedCategory});

  final Category? selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Expense> expenses = ref.watch(expenseProvider).reversed.toList();

    final filteredExpenses = selectedCategory == null
        ? expenses
        : expenses
              .where((expense) => expense.category == selectedCategory)
              .toList();

    if (filteredExpenses.isEmpty) {
      return Center(child: Text("No expenses yet."));
    }

    return ListView.builder(
      itemCount: filteredExpenses.length,
      itemBuilder: (context, index) {
        final expense = filteredExpenses[index];

        return ListTile(
          title: Text(expense.name),
          subtitle: Text(expense.category.name),
          trailing: Text("₱${expense.amount.toStringAsFixed(2)}"),
        );
      },
    );
  }
}

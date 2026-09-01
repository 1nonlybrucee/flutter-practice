import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';
import 'package:project_05_expense_tracker_v3/widgets/edit_expense_dialog.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_period_filter.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({
    super.key,
    this.selectedCategory,
    required this.selectedPeriod,
    this.showEdit = false,
  });

  final Category? selectedCategory;
  final ExpensePeriod selectedPeriod;
  final bool showEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Expense> expenses = ref.watch(expenseProvider).reversed.toList();

    var filteredExpenses = selectedCategory == null
        ? expenses
        : expenses
              .where((expense) => expense.category == selectedCategory)
              .toList();

    DateTime now = DateTime.now();

    switch (selectedPeriod) {
      case ExpensePeriod.today:
        final startOfDay = DateTime(now.year, now.month, now.day);

        filteredExpenses = filteredExpenses
            .where((expense) => !expense.date.isBefore(startOfDay))
            .toList();

      case ExpensePeriod.thisWeek:
        final startOfWeek = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - 1));

        filteredExpenses = filteredExpenses
            .where((expense) => !expense.date.isBefore(startOfWeek))
            .toList();
      case ExpensePeriod.thisMonth:
        final startOfMonth = DateTime(now.year, now.month, 1);

        filteredExpenses = filteredExpenses
            .where((expense) => !expense.date.isBefore(startOfMonth))
            .toList();

      case ExpensePeriod.thisYear:
        final startOfYear = DateTime(now.year, 1, 1);

        filteredExpenses = filteredExpenses
            .where((expense) => !expense.date.isBefore(startOfYear))
            .toList();

      case ExpensePeriod.allTime:
        // Don't filter anything.
        break;
    }

    if (filteredExpenses.isEmpty) {
      return Center(child: Text("No expenses yet."));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: filteredExpenses.length,
      itemBuilder: (context, index) {
        final expense = filteredExpenses[index];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: showEdit
                ? Text(
                    '${expense.name} - ${expense.category.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(
                    expense.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: showEdit
                  ? Text("₱${expense.amount.toStringAsFixed(2)}")
                  : Text(expense.category.name),
            ),
            trailing: showEdit
                ? PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Delete", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) async {
                      if (value == "delete") {
                        ref
                            .read(expenseProvider.notifier)
                            .deleteExpense(expense.id);
                      }
                      if (value == 'edit') {
                        final updatedExpense = await showDialog<Expense>(
                          context: context,
                          builder: (context) {
                            return EditExpenseDialog(expense: expense);
                          },
                        );
                        if (updatedExpense != null) {
                          ref
                              .read(expenseProvider.notifier)
                              .updateExpense(updatedExpense);
                        }
                      }
                    },
                  )
                : Text("₱${expense.amount.toStringAsFixed(2)}"),
          ),
        );
      },
    );
  }
}

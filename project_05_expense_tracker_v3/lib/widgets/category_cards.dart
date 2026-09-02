import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class CategoryCards extends ConsumerWidget {
  const CategoryCards({super.key, required this.selectedPeriod});
  final ExpensePeriod selectedPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Expense> expenses = ref.watch(
      filteredExpensesProvider(selectedPeriod),
    );

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: Category.values.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final category = Category.values[index];

        final categoryTotal = expenses
            .where((expense) => expense.category == category)
            .fold(0.0, (sum, expense) => sum + expense.amount);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('₱${categoryTotal.toStringAsFixed(2)}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

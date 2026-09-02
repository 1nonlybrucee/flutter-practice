import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class TopCategories extends ConsumerWidget {
  const TopCategories({super.key, required this.selectedPeriod});
  final ExpensePeriod selectedPeriod;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topCategories = ref.watch(topThreeCategoriesProvider(selectedPeriod));

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: topCategories.map((entry) {
          return Card(
            child: Container(
              width: 110,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    entry.key.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('₱${entry.value}'),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

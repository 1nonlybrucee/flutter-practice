import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class TopCategories extends ConsumerWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topCategories = ref.watch(topThreeCategoriesProvider);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: topCategories.map((entry) {
          return Card(
            child: Column(
              children: [Text(entry.key.name), Text('₱${entry.value}')],
            ),
          );
        }).toList(),
      ),
    );
  }
}

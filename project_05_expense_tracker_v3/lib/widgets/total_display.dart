import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class TotalDisplay extends ConsumerWidget {
  const TotalDisplay({super.key, required this.selectedPeriod});
  final ExpensePeriod selectedPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalExpenseProvider(selectedPeriod));
    return Text('Total: ₱${total.toStringAsFixed(2)}');
  }
}

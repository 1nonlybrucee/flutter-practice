import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/providers/expense_provider.dart';

class TotalDisplay extends ConsumerWidget {
  const TotalDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalExpenseProvider);
    return Text('Total \$${total.toStringAsFixed(2)}');
  }
}

import 'package:flutter/material.dart';
import '../models/expense.dart';

class TotalExpenses extends StatelessWidget {
  final List<Expense> expenses;

  const TotalExpenses({required this.expenses, super.key});

  double total() {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 1, offset: Offset(1, 1))],
      ),
      child: Text("Total Expenses: ₱${total().toStringAsFixed(2)}"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/widgets/category_cards.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 210, child: CategoryCards()),
        Expanded(child: ExpenseList()),
      ],
    );
  }
}

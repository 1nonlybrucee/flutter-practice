import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import 'package:project_05_expense_tracker_v3/widgets/top_categories.dart';
import 'package:project_05_expense_tracker_v3/widgets/total_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalDisplay(),
        const TopCategories(),
        const Expanded(child: ExpenseList()),
      ],
    );
  }
}

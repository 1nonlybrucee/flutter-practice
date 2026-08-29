import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import 'package:project_05_expense_tracker_v3/widgets/top_categories.dart';
import 'package:project_05_expense_tracker_v3/widgets/total_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const TotalDisplay(),
          const SizedBox(height: 24),
          const TopCategories(),
          const SizedBox(height: 24),
          const Expanded(child: ExpenseList()),
        ],
      ),
    );
  }
}

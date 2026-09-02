import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_period_filter.dart';
import 'package:project_05_expense_tracker_v3/widgets/top_categories.dart';
import 'package:project_05_expense_tracker_v3/widgets/total_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExpensePeriod selectedPeriod = ExpensePeriod.today;

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
          TotalDisplay(selectedPeriod: selectedPeriod),
          const SizedBox(height: 24),
          ExpensePeriodFilter(
            selectedPeriod: selectedPeriod,
            onChanged: (period) {
              setState(() {
                selectedPeriod = period;
              });
            },
          ),
          const SizedBox(height: 16),
          TopCategories(selectedPeriod: selectedPeriod),
          const SizedBox(height: 24),
          Expanded(child: ExpenseList(selectedPeriod: selectedPeriod)),
        ],
      ),
    );
  }
}

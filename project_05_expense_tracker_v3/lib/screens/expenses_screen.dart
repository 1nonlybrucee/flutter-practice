import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
import 'package:project_05_expense_tracker_v3/widgets/category_cards.dart';
import 'package:project_05_expense_tracker_v3/widgets/category_filter.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_period_filter.dart';
import '../models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  Category? selectedCategory;
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
              "Expenses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ExpensePeriodFilter(
            selectedPeriod: selectedPeriod,
            onChanged: (period) {
              setState(() {
                selectedPeriod = period;
              });
            },
          ),
          SizedBox(
            height: 180,
            child: CategoryCards(selectedPeriod: selectedPeriod),
          ),
          const SizedBox(height: 24),
          CategoryFilter(
            selectedCategory: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          Expanded(
            child: ExpenseList(
              selectedCategory: selectedCategory,
              selectedPeriod: selectedPeriod,
              showEdit: true,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/widgets/category_cards.dart';
import 'package:project_05_expense_tracker_v3/widgets/category_filter.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import '../models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 210, child: CategoryCards()),
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
            showEdit: true,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_04_expense_tracker_v2/widgets/expense_list.dart';
import 'package:project_04_expense_tracker_v2/widgets/total_expenses.dart';
import '../widgets/add_expense_dialog.dart';
import '../services/expense_service.dart';
import '../models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  final expenseService;
  const ExpensesScreen({required this.expenseService, super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final expenseService = ExpenseService();

  void _addExpense() async {
    final expense = await showDialog<Expense>(
      context: context,
      builder: (context) {
        return const AddExpenseDialog();
      },
    );

    if (expense != null) {
      setState(() {
        expenseService.addExpense(expense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      body: Column(
        children: [
          TotalExpenses(expenses: expenseService.expenses),
          Expanded(
            child: expenseService.expenses.isEmpty
                ? const Center(child: Text("No expenses yet"))
                : ExpenseList(expenses: expenseService.expenses),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        child: Icon(Icons.add),
      ),
    );
  }
}

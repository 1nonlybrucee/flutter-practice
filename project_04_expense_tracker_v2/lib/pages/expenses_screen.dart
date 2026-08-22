import 'package:flutter/material.dart';
import 'package:project_04_expense_tracker_v2/widgets/add_expense_dialog.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      body: Center(child: Text("Expenses screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddExpenseDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

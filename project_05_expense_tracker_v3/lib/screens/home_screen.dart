import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/widgets/expense_list.dart';
import 'package:project_05_expense_tracker_v3/widgets/total_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gastos Tracker")),
      body: Column(
        children: [
          TotalDisplay(),
          Expanded(child: ExpenseList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("+"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../models/category.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Lunch',
      amount: 150,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      id: '2',
      title: 'Jeepney',
      amount: 30,
      date: DateTime.now(),
      category: Category.transportation,
    ),
    Expense(
      id: '3',
      title: 'Netflix',
      amount: 299,
      date: DateTime.now(),
      category: Category.entertainment,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];

          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.receipt)),
            title: Text(expense.title),
            subtitle: Text(expense.category.name),
            trailing: Text('₱${expense.amount.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

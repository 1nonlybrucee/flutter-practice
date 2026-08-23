import 'package:flutter/material.dart';

import 'package:project_04_expense_tracker_v2/pages/expenses_screen.dart';
import 'package:project_04_expense_tracker_v2/pages/home_screen.dart';
import 'package:project_04_expense_tracker_v2/pages/stats_screen.dart';
import 'package:project_04_expense_tracker_v2/services/expense_service.dart';

import '/navigation/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExpenseService expenseService = ExpenseService();

  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeScreen(),
      ExpensesScreen(expenseService: expenseService),
      const StatsScreen(),
    ];
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Navigation(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_04_expense_tracker_v2/pages/expenses_screen.dart';
import 'package:project_04_expense_tracker_v2/pages/home_screen.dart';
import 'package:project_04_expense_tracker_v2/pages/stats_screen.dart';
import '/navigation/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ExpensesScreen(),
    const StatsScreen(),
  ];

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Navigation(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}

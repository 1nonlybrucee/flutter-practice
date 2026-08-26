import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/screens/expenses_screen.dart';
import 'package:project_05_expense_tracker_v3/screens/home_screen.dart';
import 'package:project_05_expense_tracker_v3/widgets/add_expense_dialog.dart';
import 'package:project_05_expense_tracker_v3/widgets/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), ExpensesScreen()];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gastos Tracker")),

      body: IndexedStack(index: _selectedIndex, children: _screens),

      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddExpenseDialog(),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Add Expense"),
      ),
    );
  }
}

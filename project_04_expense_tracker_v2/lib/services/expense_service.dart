import 'package:project_04_expense_tracker_v2/models/expense.dart';

class ExpenseService {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
  }
}

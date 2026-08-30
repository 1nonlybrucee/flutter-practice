import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  static const String expensesKey = 'expenses';

  @override
  List<Expense> build() {
    _loadExpenses();
    return [];
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedExpenses = prefs.getStringList(expensesKey);

    if (savedExpenses == null) return;

    final loadedExpenses = savedExpenses
        .map((expense) => Expense.fromJson(jsonDecode(expense)))
        .toList();
    state = loadedExpenses;
  }

  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    final expenses = state
        .map((expense) => jsonEncode(expense.toJson()))
        .toList();

    await prefs.setStringList(expensesKey, expenses);
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
    _saveExpenses();
  }

  void deleteExpense(String idToRemove) {
    state = state.where((expense) => expense.id != idToRemove).toList();
    _saveExpenses();
  }

  void updateExpense(Expense updatedExpense) {
    state = [
      for (final expense in state)
        if (expense.id == updatedExpense.id) updatedExpense else expense,
    ];
    _saveExpenses();
  }
}

final expenseProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(
  ExpenseNotifier.new,
);

final totalExpenseProvider = Provider<double>((ref) {
  final expenses = ref.watch(expenseProvider);
  return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
});

final topThreeCategoriesProvider = Provider<List<MapEntry<Category, double>>>((
  ref,
) {
  final expenses = ref.watch(expenseProvider);

  final categoryTotals = <Category, double>{
    for (var category in Category.values) category: 0.0,
  };

  for (final expense in expenses) {
    categoryTotals[expense.category] =
        (categoryTotals[expense.category] ?? 0) + expense.amount;
  }

  final sortedCategories = categoryTotals.entries.toList();

  sortedCategories.sort((a, b) => b.value.compareTo(a.value));

  return sortedCategories.take(3).toList();
});

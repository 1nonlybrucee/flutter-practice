import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';
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

final totalExpenseProvider = Provider.family<double, ExpensePeriod>((
  ref,
  period,
) {
  final expenses = ref.watch(filteredExpensesProvider(period));
  return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
});

final topThreeCategoriesProvider =
    Provider.family<List<MapEntry<Category, double>>, ExpensePeriod>((
      ref,
      period,
    ) {
      final expenses = ref.watch(filteredExpensesProvider(period));

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

final filteredExpensesProvider = Provider.family<List<Expense>, ExpensePeriod>((
  ref,
  period,
) {
  final expenses = ref.watch(expenseProvider);
  return expenses.where((expense) {
    final now = DateTime.now();
    final date = expense.date;

    switch (period) {
      case ExpensePeriod.today:
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;

      case ExpensePeriod.thisWeek:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

        return date.isAfter(
          DateTime(
            startOfWeek.year,
            startOfWeek.month,
            startOfWeek.day,
          ).subtract(const Duration(seconds: 1)),
        );

      case ExpensePeriod.thisMonth:
        return date.year == now.year && date.month == now.month;

      case ExpensePeriod.thisYear:
        return date.year == now.year;

      case ExpensePeriod.allTime:
        return true;
    }
  }).toList();
});

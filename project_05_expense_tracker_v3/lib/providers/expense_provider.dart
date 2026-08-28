import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  static const String hardcodedString = "2026-06-05T14:30:00";

  @override
  List<Expense> build() {
    return [];
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void deleteExpense(String idToRemove) {
    state = state.where((expense) => expense.id != idToRemove).toList();
  }

  void updateExpense(Expense updatedExpense) {
    state = [
      for (final expense in state)
        if (expense.id == updatedExpense.id) updatedExpense else expense,
    ];
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

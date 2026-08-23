import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  static const String hardcodedString = "2026-06-05T14:30:00";

  Expense expense1 = Expense(
    id: '123',
    name: "jollibee",
    amount: 125.44,
    date: DateTime.parse(hardcodedString),
    category: Category.kakanon,
  );

  @override
  List<Expense> build() {
    return [expense1];
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void deleteExpense(String idToRemove) {
    state = state.where((expense) => expense.id != idToRemove).toList();
  }
}

final expenseProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(
  ExpenseNotifier.new,
);

final totalExpenseProvider = Provider<double>((ref) {
  final expenses = ref.watch(expenseProvider);
  return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
});

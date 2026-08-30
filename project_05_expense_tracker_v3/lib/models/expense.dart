enum Category { kakanon, pamasahe, kawat, shopee, bayadan, others }

class Expense {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  });

  Expense copyWith({
    String? id,
    String? name,
    double? amount,
    DateTime? date,
    Category? category,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values.byName(json['category']),
    );
  }
}

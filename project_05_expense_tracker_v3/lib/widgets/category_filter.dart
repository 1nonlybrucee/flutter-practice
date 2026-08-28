import 'package:flutter/material.dart';
import '../models/expense.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  final Category? selectedCategory;
  final ValueChanged<Category?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: selectedCategory,
      items: [
        const DropdownMenuItem(value: null, child: Text("All Categories")),
        ...Category.values.map((category) {
          return DropdownMenuItem(value: category, child: Text(category.name));
        }),
      ],
      onChanged: onChanged,
    );
  }
}

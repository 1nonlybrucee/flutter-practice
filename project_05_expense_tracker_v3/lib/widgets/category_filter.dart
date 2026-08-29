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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Category>(
          value: selectedCategory,
          items: [
            const DropdownMenuItem(value: null, child: Text("Gabos na gastos")),
            ...Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

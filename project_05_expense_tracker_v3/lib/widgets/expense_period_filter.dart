import 'package:flutter/material.dart';

enum ExpensePeriod { today, thisWeek, thisMonth, thisYear, allTime }

class ExpensePeriodFilter extends StatelessWidget {
  final ExpensePeriod selectedPeriod;
  final ValueChanged<ExpensePeriod> onChanged;

  const ExpensePeriodFilter({
    super.key,
    required this.selectedPeriod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ExpensePeriod>(
      value: selectedPeriod,
      items: ExpensePeriod.values.map((period) {
        return DropdownMenuItem(value: period, child: Text(period.name));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

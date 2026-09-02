import 'package:flutter/material.dart';
import 'package:project_05_expense_tracker_v3/models/expense_period.dart';

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
        child: DropdownButton<ExpensePeriod>(
          value: selectedPeriod,
          items: ExpensePeriod.values.map((period) {
            return DropdownMenuItem(
              value: period,
              child: Text(switch (period) {
                ExpensePeriod.today => 'Today',
                ExpensePeriod.thisWeek => 'This Week',
                ExpensePeriod.thisMonth => 'This Month',
                ExpensePeriod.thisYear => 'This Year',
                ExpensePeriod.allTime => 'All Time',
              }),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}

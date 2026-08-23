import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Navigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Expenses",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.bar_chart),
        //   label: "Statistics",
        // ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MemberStatCard extends StatelessWidget {
  final String title;
  final String value;
  const MemberStatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [Text(title), Text(value)]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MemberStatCard extends StatelessWidget {
  const MemberStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [Text("initial title"), Text("inital value")]),
      ),
    );
  }
}

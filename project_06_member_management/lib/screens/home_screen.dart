import 'package:flutter/material.dart';
import 'package:project_06_member_management/widgets/member_stat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Membership")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(child: MemberStatCard()),
                SizedBox(width: 10),
                Expanded(child: MemberStatCard()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

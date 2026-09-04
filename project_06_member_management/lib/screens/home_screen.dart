import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_06_member_management/providers/member_provider.dart';
import 'package:project_06_member_management/widgets/member_stat_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(memberProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Membership")),
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
                Expanded(
                  child: MemberStatCard(
                    title: 'Total Members',
                    value: members.length.toString(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MemberStatCard(
                    title: 'Active Members',
                    value: members
                        .where((member) => member.isActive)
                        .length
                        .toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

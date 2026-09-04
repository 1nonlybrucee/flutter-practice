import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_06_member_management/models/member.dart';

class MemberNotifier extends Notifier<List<Member>> {
  @override
  List<Member> build() {
    return [];
  }

  void addMember(Member member) {
    state = [...state, member];
  }

  void deleteMember(String idToRemove) {
    state = state.where((member) => member.id != idToRemove).toList();
  }
}

final memberProvider = NotifierProvider<MemberNotifier, List<Member>>(
  MemberNotifier.new,
);

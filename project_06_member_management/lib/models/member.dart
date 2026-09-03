class Member {
  String id;
  String name;
  String phone;
  DateTime birthDate;
  DateTime joinedDate;
  bool isActive;

  Member({
    required this.id,
    required this.name,
    required this.phone,
    required this.birthDate,
    required this.joinedDate,
    required this.isActive,
  });

  Member copyWith({
    String? id,
    String? name,
    String? phone,
    DateTime? birthDate,
    DateTime? joinedDate,
    bool? isActive,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      joinedDate: joinedDate ?? this.joinedDate,
      isActive: isActive ?? this.isActive,
    );
  }
}

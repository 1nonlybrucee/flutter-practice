import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_06_member_management/models/member.dart';
import 'package:project_06_member_management/providers/member_provider.dart';
import 'package:uuid/uuid.dart';

class AddMemberDialog extends ConsumerStatefulWidget {
  const AddMemberDialog({super.key});

  @override
  ConsumerState<AddMemberDialog> createState() {
    return _AddMemberDialog();
  }
}

class _AddMemberDialog extends ConsumerState<AddMemberDialog> {
  DateTime? birthdate;
  DateTime? dateJoined;
  final inputName = TextEditingController();
  final inputPhone = TextEditingController();

  var uuid = const Uuid();

  Future<DateTime?> _selectDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }

  @override
  void dispose() {
    inputName.dispose();
    inputPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Member"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: inputName,
            decoration: InputDecoration(label: Text("Name")),
          ),
          TextField(
            controller: inputPhone,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text("Phone")),
          ),
          TextField(
            readOnly: true,
            onTap: () async {
              final date = await _selectDate();
              if (date != null) {
                setState(() {
                  birthdate = date;
                });
              }
            },
            decoration: InputDecoration(
              labelText: "Birthdate",
              hintText: "Select Birthdate",
              suffixIcon: const Icon(Icons.calendar_today),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
            ),
            controller: TextEditingController(
              text: birthdate == null
                  ? ""
                  : "${birthdate!.month}/"
                        "${birthdate!.day}/"
                        "${birthdate!.year}",
            ),
          ),
          TextField(
            readOnly: true,
            onTap: () async {
              final date = await _selectDate();
              if (date != null) {
                setState(() {
                  dateJoined = date;
                });
              }
            },
            decoration: InputDecoration(
              labelText: "Joined Date",
              hintText: "starting date",
              suffixIcon: const Icon(Icons.calendar_today),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
            ),
            controller: TextEditingController(
              text: dateJoined == null
                  ? ""
                  : "${dateJoined!.month}/"
                        "${dateJoined!.day}/"
                        "${dateJoined!.year}",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (inputName.text.trim().isEmpty ||
                inputPhone.text.trim().isEmpty ||
                birthdate == null ||
                dateJoined == null) {
              return;
            }
            ref
                .read(memberProvider.notifier)
                .addMember(
                  Member(
                    id: uuid.v4(),
                    name: inputName.text,
                    phone: inputPhone.text,
                    birthDate: birthdate!,
                    joinedDate: dateJoined!,
                    isActive: true,
                  ),
                );
            Navigator.pop(context);
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}

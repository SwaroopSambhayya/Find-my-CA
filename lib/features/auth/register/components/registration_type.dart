import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationType extends ConsumerStatefulWidget {
  const RegistrationType({super.key});

  @override
  ConsumerState<RegistrationType> createState() => _RegistrationTypeState();
}

class _RegistrationTypeState extends ConsumerState<RegistrationType> {
  late RoleType groupValue;

  void updateRegistrationData(RoleType groupVal) {
    Profile profile = ref.read(registrationProvider);
    profile = profile.copyWith(roletype: groupVal);
    ref.read(registrationProvider.notifier).changeRegistrationState(profile);
  }

  @override
  void initState() {
    groupValue = ref.read(registrationProvider).roletype;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30).copyWith(top: 0),
          child: const Text(
            "Please select registration type",
            style: TextStyle(fontSize: 13),
          ),
        ),
        RadioListTile.adaptive(
            value: RoleType.ca,
            title: const Text(
              "I'm CA",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            groupValue: groupValue,
            onChanged: (RoleType? val) {
              setState(() {
                groupValue = val!;
              });
              updateRegistrationData(val!);
            }),
        RadioListTile.adaptive(
            value: RoleType.client,
            title: const Text(
              "I need a CA",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            groupValue: groupValue,
            onChanged: (RoleType? val) {
              setState(() {
                groupValue = val!;
              });
              updateRegistrationData(val!);
            })
      ],
    );
  }
}

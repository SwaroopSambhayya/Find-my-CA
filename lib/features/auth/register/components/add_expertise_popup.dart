import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpertisePopUp extends ConsumerWidget {
  const AddExpertisePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Add Expertise"),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (val) {},
              onSubmitted: (value) {
                List<String> exp =
                    ref.read(registrationProvider).expertise ?? [];
                exp.add(value);
                List<String> availableExp =
                    ref.read(availableExpertiseProvider.notifier).state;
                ref.read(availableExpertiseProvider.notifier).state = [
                  ...availableExp,
                  value
                ];
                ref.read(registrationProvider.notifier).changeExpertise(exp);
                Navigator.pop(context);
              },
              decoration: getInputDecoration(
                  hintText: "Enter expertise", iconData: Icons.grading),
            ),
          ),
        )
      ],
    );
  }
}

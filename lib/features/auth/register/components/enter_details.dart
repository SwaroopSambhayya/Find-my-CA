import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterDetails extends ConsumerWidget {
  const EnterDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(registrationProvider.select((value) => value.roletype)) ==
            RoleType.ca
        ? const CAForm()
        : const ClientForm();
  }
}

class CAForm extends StatefulWidget {
  const CAForm({super.key});

  @override
  State<CAForm> createState() => _CAFormState();
}

class _CAFormState extends State<CAForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // DisplayPictureRounded()
        const CircleAvatar(
          radius: 40,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: getInputDecoration(
                    hintText: "First Name", iconData: Icons.person),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                decoration: getInputDecoration(
                    hintText: "Last Name", iconData: Icons.person),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: getInputDecoration(
                      hintText: "Email", iconData: Icons.email),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: getInputDecoration(
                      hintText: "Phone", iconData: Icons.phone_android),
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expertise",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ClientForm extends StatefulWidget {
  const ClientForm({super.key});

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

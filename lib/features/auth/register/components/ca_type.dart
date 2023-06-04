import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CAType extends ConsumerStatefulWidget {
  const CAType({super.key});

  @override
  ConsumerState<CAType> createState() => _CATypeState();
}

class _CATypeState extends ConsumerState<CAType> {
  late CARegistererType groupValue;
  @override
  void initState() {
    groupValue = ref.read(registrationProvider).registererType;
    super.initState();
  }

  void updateCAType(CARegistererType val) {
    Profile profile =
        ref.read(registrationProvider).copyWith(registererType: val);
    ref.read(registrationProvider.notifier).changeRegistrationState(profile);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RadioListTile.adaptive(
            title: Text(caTypes[index]),
            value: getRegistererTypeMapping(caTypes[index]),
            groupValue: groupValue,
            onChanged: (CARegistererType? val) {
              setState(() {
                groupValue = val!;
              });
              updateCAType(val!);
            });
      },
      itemCount: caTypes.length,
    );
  }
}

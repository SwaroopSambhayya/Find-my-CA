import 'dart:math';

import 'package:find_my_ca/features/auth/providers/password_provider.dart';
import 'package:find_my_ca/features/auth/register/components/ca_type.dart';
import 'package:find_my_ca/features/auth/register/components/enter_details.dart';
import 'package:find_my_ca/features/auth/register/components/registration_type.dart';
import 'package:find_my_ca/features/auth/register/providers/form_state_provider.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/extensions.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/providers/location_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:stack_trace/stack_trace.dart' as stack_trace;

class Register extends ConsumerStatefulWidget {
  final PageController pageController;
  const Register({super.key, required this.pageController});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  int step = 0;
  @override
  void initState() {
    super.initState();
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is stack_trace.Trace) return stack.vmTrace;
      if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
      return stack;
    };
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currentLocationProvider(context));

    RoleType role = ref.watch(
      registrationProvider.select((value) => value.roletype),
    );

    ref.listen(registrationAuthProvider, (previous, next) {
      next.showLiveStatus(context, widget.pageController);
    });

    CARegistererType registererType =
        ref.watch(registrationProvider.select((value) => value.registererType));

    if (role != RoleType.none) {
      ref.listen(registrationProvider.select((value) => value.roletype),
          (previous, next) {
        ref
            .read(registrationProvider.notifier)
            .changeRegistrationState(const Profile().copyWith(roletype: next));
      });
    }

    return Stack(
      children: [
        Stepper(
          elevation: 0,
          currentStep: step,
          key: Key(Random.secure().nextDouble().toString()),
          type: StepperType.horizontal,
          steps: [
            Step(
                isActive: step >= 0,
                title: StepperTitle(
                  title: step == 0 ? "Registration type" : "",
                ),
                content: const RegistrationType()),
            if (role == RoleType.ca)
              Step(
                isActive: step >= 1,
                title: StepperTitle(title: step == 1 ? "Choose CA type" : ""),
                content: const CAType(),
              ),
            const Step(
              title: StepperTitle(title: "Enter Details"),
              content: EnterDetails(),
            )
          ],
          onStepContinue: getStepActionStatus(step, role, registererType, ref)
              ? null
              : () {
                  if ((role == RoleType.ca && step == 2) ||
                      (role == RoleType.client && step == 1)) {
                    if (ref.read(formStateProvider).currentState!.validate()) {
                      ref.read(registrationAuthProvider.notifier).register(
                            ref.read(registrationProvider).email,
                            ref.read(passwordProvider),
                          );
                    }
                  } else {
                    setState(() {
                      step += 1;
                    });
                  }
                },
          onStepCancel: () {
            if (step > 0) {
              setState(() {
                step = step - 1;
              });
            } else {
              widget.pageController.jumpToPage(0);
            }
          },
        ),
      ],
    );
  }
}

class StepperTitle extends StatelessWidget {
  final String title;
  const StepperTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

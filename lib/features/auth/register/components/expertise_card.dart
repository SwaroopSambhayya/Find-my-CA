import 'package:find_my_ca/features/auth/register/components/add_expertise_popup.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/components/dotted_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpertiseCard extends StatelessWidget {
  const ExpertiseCard({
    super.key,
    required this.availableExpertises,
    required this.expertises,
    required this.ref,
  });

  final List<String> availableExpertises;
  final List<String> expertises;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Choose your expertise",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Wrap(
                spacing: 10,
                children: availableExpertises
                    .map((topic) => Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 2),
                          child: ChoiceChip(
                              side: BorderSide.none,
                              onSelected: (value) {
                                List<String> exp = expertises;

                                if (exp.contains(topic)) {
                                  exp.remove(topic);
                                } else {
                                  exp.add(topic);
                                }

                                ref
                                    .read(registrationProvider.notifier)
                                    .changeExpertise(exp);
                              },
                              selectedColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              labelStyle: const TextStyle(),
                              label: Text(topic),
                              selected: expertises.contains(topic)),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DottedButton(
                label: "Add more",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AddExpertisePopUp());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

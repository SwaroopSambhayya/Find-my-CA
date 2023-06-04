// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationError extends ConsumerWidget {
  const LocationError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Oops!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(locationMessage +
              (Platform.isIOS ? iosLocationMessage : androidLocationMessage)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () async {
              await ref.read(locationProvider).requestPermission();
              ref.invalidate(currentLocationProvider(context));
              ref.read(currentLocationProvider(context));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.my_location),
            label: const Text("Okay"),
          ),
        )
      ],
    );
  }
}

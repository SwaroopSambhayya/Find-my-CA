// ignore_for_file: use_build_context_synchronously

import 'package:find_my_ca/shared/components/location_error.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:location/location.dart';

final locationProvider = Provider.autoDispose<Location>((ref) => Location());

final currentLocationProvider =
    FutureProvider.family<GoogleGeocodingResult, BuildContext>(
        (ref, context) async {
  bool serviceEnabled = false;
  Location location = ref.read(locationProvider);
  try {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Please enable location service");
      }
    }
  } catch (e) {
    print(e);
    showDialog(context: context, builder: (context) => const LocationError());
  }
  PermissionStatus status = await location.hasPermission();
  if (status == PermissionStatus.granted) {
    GoogleGeocodingResult result = await getLocationFromCoordinates(ref);
    ref.read(currentLocation.notifier).state = result;
    return result;
  } else {
    showDialog(context: context, builder: (context) => const LocationError());
  }
  throw Exception("Permission denied");
});

final currentLocation = StateProvider<GoogleGeocodingResult?>((ref) => null);

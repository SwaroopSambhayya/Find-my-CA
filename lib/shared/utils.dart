import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/providers/google_api_provider.dart';
import 'package:find_my_ca/shared/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:location/location.dart';

InputDecoration getInputDecoration(
    {required String hintText,
    required IconData iconData,
    void Function()? suffixOnTap}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: TextStyle(fontFamily: "Poppins", color: Colors.grey[350]),
    suffixIcon: InkWell(
      onTap: suffixOnTap,
      child: Icon(
        iconData,
        color: Colors.black,
        size: 18,
      ),
    ),
  );
}

bool getStepActionStatus(int step, RoleType roleType,
    CARegistererType registererType, WidgetRef ref) {
  switch (step) {
    case 0:
      return roleType == RoleType.none;
    case 1:
      return registererType == CARegistererType.none;
    default:
      return false;
  }
}

CARegistererType getRegistererTypeMapping(String type) {
  switch (type) {
    case "Sole proprietorship":
      return CARegistererType.sole;
    case "Sole proprietorship with registered firm":
      return CARegistererType.soleWithRegisteredFirm;
    default:
      return CARegistererType.partneredFirm;
  }
}

Future<GoogleGeocodingResult> getLocationFromCoordinates(
    FutureProviderRef<GoogleGeocodingResult> ref) async {
  Location location = ref.read(locationProvider);
  LocationData locationDetail = await location.getLocation();
  ref.read(registrationProvider.notifier).changeLatLng(locationDetail);
  GoogleGeocodingResponse result = await ref
      .read(googleProvider)
      .reverse('${locationDetail.latitude},${locationDetail.longitude}');
  return result.results.first;
}

List<String> getAddressCityCountry(GoogleGeocodingResult result) {
  String getValueBasedOnKey(String key) {
    return result.addressComponents
        .firstWhere((entry) => entry.types.contains(key))
        .longName;
  }

  List<String> resultsArray = [];
  resultsArray.add(
      "${getValueBasedOnKey('neighborhood')},${getValueBasedOnKey('sublocality')},${getValueBasedOnKey('locality')}");
  resultsArray.add(getValueBasedOnKey('administrative_area_level_3'));
  resultsArray.add(getValueBasedOnKey('country'));
  return resultsArray;
}

// Form validators
String? emptyValidators(String? val) {
  if (val == null || val.isEmpty) {
    return "This field should not be empty";
  }
  return null;
}

String getErrorBasedOnType(String? type) {
  print(type);
  switch (type) {
    case 'user_already_exists':
      return userAlreadyRegistered;
    case 'general_rate_limit_exceeded':
      return rateLimitExceeded;
    case 'user_invalid_credentials':
      return invalidCredential;
  }
  return connectivityIssue;
}

import 'package:find_my_ca/shared/key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

final googleProvider = Provider<GoogleGeocodingApi>(
  (ref) => GoogleGeocodingApi(GOOGLE_API_KEY, isLogged: true),
);

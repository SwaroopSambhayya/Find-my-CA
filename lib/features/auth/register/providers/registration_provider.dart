import 'package:find_my_ca/features/auth/register/repositories/registration.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationProvider =
    StateNotifierProvider<Registration, Profile>((ref) => Registration());

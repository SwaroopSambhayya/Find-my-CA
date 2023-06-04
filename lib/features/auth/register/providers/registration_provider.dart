import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/features/auth/register/repositories/registration.dart';
import 'package:find_my_ca/features/auth/register/repositories/registration_auth_notifier.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/providers/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationProvider =
    StateNotifierProvider<Registration, Profile>((ref) => Registration());

final availableExpertiseProvider =
    StateProvider<List<String>>((ref) => expertise);

final registrationAuthProvider =
    StateNotifierProvider<RegistrationAuth, AsyncValue<void>>((ref) {
  Account account = ref.read(accountProvider);

  return RegistrationAuth(account, ref);
});

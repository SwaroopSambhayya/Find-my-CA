import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/apis/register_user.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationAuth extends StateNotifier<AsyncValue<dynamic>> {
  final Account account;
  final Ref ref;

  RegistrationAuth(this.account, this.ref) : super(const AsyncValue.data(null));

  Future<void> register(email, password) async {
    state = const AsyncValue.loading();
    try {
      User user = await registerNewUser(
          email: email,
          password: password,
          account: account,
          database: ref.read(databaseProvider),
          profile: ref.read(registrationProvider));
      state = AsyncValue.data(user);
      Future.delayed(const Duration(seconds: 1),
          () => ref.read(registrationProvider.notifier).reset());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

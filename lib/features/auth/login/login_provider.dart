import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/login/login_repositoty.dart';
import 'package:find_my_ca/shared/providers/account_provider.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginAuth, AsyncValue<void>>((ref) {
  Account account = ref.read(accountProvider);
  return LoginAuth(account, ref);
});

final authStateProvider = FutureProvider<User?>((ref) async {
  User? user = await ref.read(accountProvider).get();
  // ignore: unnecessary_type_check
  if (user is User) {
    ref.read(authStateListener.notifier).state = ['users.*.sessions.*.create'];
  }
  return user;
});

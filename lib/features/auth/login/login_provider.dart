import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/features/auth/login/login_repositoty.dart';
import 'package:find_my_ca/shared/providers/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginAuth, AsyncValue<void>>((ref) {
  Account account = ref.read(accountProvider);
  return LoginAuth(account);
});

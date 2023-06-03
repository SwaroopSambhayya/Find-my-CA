import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/shared/providers/account_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountSessionProvider = FutureProvider<Session>((ref) async {
  Account account = ref.read(accountProvider);
  return await account.getSession(sessionId: 'current');
});

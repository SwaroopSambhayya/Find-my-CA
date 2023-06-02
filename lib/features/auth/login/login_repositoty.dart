import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/apis/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginAuth extends StateNotifier<AsyncValue<dynamic>> {
  final Account account;
  LoginAuth(this.account) : super(const AsyncValue.data(null));

  Future<void> loginUser(email, password) async {
    state = const AsyncValue.loading();
    try {
      Session session = await login(email, password, account);
      state = AsyncValue.data(session);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

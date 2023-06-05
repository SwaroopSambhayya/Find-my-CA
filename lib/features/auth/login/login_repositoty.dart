import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/apis/login.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginAuth extends StateNotifier<AsyncValue<dynamic>> {
  final Account account;
  final Ref ref;
  LoginAuth(this.account, this.ref) : super(const AsyncValue.data(null));

  Future<void> loginUser(email, password) async {
    state = const AsyncValue.loading();
    try {
      Session session = await login(email, password, account);
      state = AsyncValue.data(session);
      ref.read(authStateListener.notifier).state = [
        'users.*.sessions.*.create'
      ];
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> logoutUser() async {
    state = const AsyncValue.loading();
    try {
      var result = await logout(account);
      state = AsyncValue.data(result);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

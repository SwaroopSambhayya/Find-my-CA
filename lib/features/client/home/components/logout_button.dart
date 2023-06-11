import 'package:find_my_ca/features/auth/login/login_provider.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/extensions.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:find_my_ca/shared/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: ErrorText(
                error: error,
              ),
            ),
          );
        },
        data: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(logoutSuccess),
            ),
          );
          ref.read(authStateListener.notifier).state = [
            'users.*.sessions.*.delete'
          ];
          Future.delayed(const Duration(milliseconds: 500), () {
            ref.invalidate(userIdProvider);
          });
        },
      );
    });
    return IconButton(
      onPressed: () {
        ref.read(loginProvider.notifier).logoutUser();
      },
      icon: const Text("Logout"),
    );
  }
}

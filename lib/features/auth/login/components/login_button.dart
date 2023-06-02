import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/login/login_provider.dart';
import 'package:find_my_ca/features/auth/providers/password_provider.dart';
import 'package:find_my_ca/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButton extends ConsumerWidget {
  final String email;
  const LoginButton({super.key, required this.email});

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
            const SnackBar(
              content: Text('Login Successfull'),
            ),
          );
        },
      );
    });

    AsyncValue loginStatus = ref.watch(loginProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton(
        onPressed: () {
          ref.read(loginProvider.notifier).loginUser(
                email,
                ref.read(passwordProvider),
              );
        },
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 60),
              ),
            ),
        child: loginStatus.isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).scaffoldBackgroundColor)
            : const Text(
                "Login",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

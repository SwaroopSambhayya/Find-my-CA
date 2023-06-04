import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/auth.dart';
import 'package:find_my_ca/features/auth/login/login_provider.dart';
import 'package:find_my_ca/features/client/home/home.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _key = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final authListener = ref.watch(authStateListener);
  return GoRouter(
    initialLocation: '/login',
    navigatorKey: _key,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) {
          return const Home();
        },
      ),
      GoRoute(
          path: login,
          name: login,
          builder: (context, state) {
            return const Auth();
          }),
      GoRoute(
          path: '/error',
          name: 'error',
          builder: (context, state) {
            return const Scaffold(
              body: Text('ERROR'),
            );
          })
    ],
    redirect: (context, state) {
      if (authListener.contains('users.*.sessions.*.create')) {
        return '/';
      }

      if (authState.isLoading) {
        return null;
      }

      if (authState.hasError) {
        return '/login';
      }
      // ignore: unnecessary_type_check
      if (authState is AsyncValue<User?>) {
        return '/';
      }

      return null;
    },
  );
});

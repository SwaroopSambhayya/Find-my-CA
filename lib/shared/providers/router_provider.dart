import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/auth.dart';
import 'package:find_my_ca/features/auth/login/login_provider.dart';
import 'package:find_my_ca/features/client/home/home.dart';
import 'package:find_my_ca/features/profile/profile.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _routeKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();
final regex = RegExp(r'^[/*]{1,}');

final routeProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final authListener = ref.watch(authStateListener);
  return GoRouter(
    initialLocation: '/login',
    navigatorKey: _routeKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: shellKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: child);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: shellKey,
            path: '/',
            //name: home,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: Home());
            },
          ),
          GoRoute(
            parentNavigatorKey: shellKey,
            path: '/profile',
            //name: profile,
            pageBuilder: (context, state) {
              print(state.location);
              return const NoTransitionPage(child: Profile());
            },
          ),
        ],
      ),
      GoRoute(
          path: login,
          name: login,
          parentNavigatorKey: _routeKey,
          builder: (context, state) {
            return const Auth();
          }),
      GoRoute(
          path: '/error',
          name: 'error',
          parentNavigatorKey: _routeKey,
          builder: (context, state) {
            return const Scaffold(
              body: Text('ERROR'),
            );
          })
    ],
    redirect: (context, state) {
      if (authState.isLoading) {
        return null;
      }

      if (authState.hasError ||
          authListener.contains('users.*.sessions.*.delete')) {
        return login;
      }

      if (state.location != login && state.location != '/') {
        return state.location;
      }
      // ignore: unnecessary_type_check
      if (authState is AsyncValue<User?>) {
        return '/';
      }

      return null;
    },
  );
});

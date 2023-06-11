// ignore_for_file: avoid_print

import 'package:appwrite/models.dart';
import 'package:find_my_ca/features/auth/auth.dart';
import 'package:find_my_ca/features/auth/login/login_provider.dart';
import 'package:find_my_ca/features/client/home/home.dart';
import 'package:find_my_ca/features/profile/edit_profile.dart';
import 'package:find_my_ca/features/profile/profile.dart';
import 'package:find_my_ca/features/splash.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/providers/appwrite_realtime.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/navigation.dart';

final _routeKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();
final subRouteKey = GlobalKey<NavigatorState>();
final regex = RegExp(r'^[/*]{1,}');

final routeProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final authListener = ref.watch(authStateListener);
  authState.whenOrNull(
    error: (error, stackTrace) => print(error),
  );
  return GoRouter(
    initialLocation: splash,
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
            path: home,
            //name: home,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: Navigation());
            },
          ),
          GoRoute(
            parentNavigatorKey: shellKey,
            path: '/profile',
            pageBuilder: (context, state) {
              print(state.location);
              return const NoTransitionPage(child: UserProfile());
            },
            routes: [
              GoRoute(
                path: 'editProfile',
                builder: (context, state) {
                  final profile = state.extra as Profile;
                  print(state.location);
                  return EditProfile(profile: profile);
                },
              ),
            ],
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
          path: splash,
          name: splash,
          parentNavigatorKey: _routeKey,
          builder: (context, state) {
            return const SplashScreen();
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
      print(state.location);
      if (authState.isLoading) {
        print('Auth state loading');
        return splash;
      }

      if (state.location != login &&
          state.location != '/' &&
          state.location != splash) {
        print('In defined location');
        return state.location;
      }

      if (authListener.contains('users.*.sessions.*.create')) {
        return home;
        // return '/';
      }

      if (authState.hasError ||
          authListener.contains('users.*.sessions.*.delete')) {
        print('Auth state has error');
        return login;
      }

      // ignore: unnecessary_type_check
      if (authState is AsyncValue<User?>) {
        print('Im going home');
        return '/';
      }

      return null;
    },
  );
});

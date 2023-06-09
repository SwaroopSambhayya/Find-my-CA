import 'package:find_my_ca/firebase_options.dart';
import 'package:find_my_ca/shared/providers/router_provider.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    GoRouter router = ref.watch(routeProvider);
    return MaterialApp.router(
      theme: lightThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

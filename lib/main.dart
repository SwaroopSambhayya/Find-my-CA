import 'package:find_my_ca/shared/route_config.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        theme: lightThemeData,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

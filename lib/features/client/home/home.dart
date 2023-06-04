import 'package:find_my_ca/features/client/home/components/logout_button.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.go('/home/profile');
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: const Placeholder());
  }
}

import 'package:find_my_ca/features/client/home/components/logout_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [LogoutButton()],
        ),
        body: const Placeholder());
  }
}

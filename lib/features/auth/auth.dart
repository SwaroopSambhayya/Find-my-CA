import 'package:find_my_ca/features/auth/login/login.dart';
import 'package:find_my_ca/features/auth/register/register.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
  });

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late List<Widget> authWidgets;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    authWidgets = [
      Login(
        pageController: _controller,
      ),
      Register(pageController: _controller)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return authWidgets[index];
          },
          itemCount: 2,
        ),
      ),
    );
  }
}

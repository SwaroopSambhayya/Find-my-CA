import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/resources/images/splash.png'),
          Text(
            "Find my CA",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

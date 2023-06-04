import 'package:find_my_ca/features/auth/login/components/login_button.dart';
import 'package:find_my_ca/features/auth/providers/password_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  final PageController pageController;
  const Login({super.key, required this.pageController});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late ScrollController _scrollController;
  bool showPassword = false;
  String username = "";

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToLast() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: MediaQuery.orientationOf(context) == Orientation.landscape
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      child: Container(
        margin: const EdgeInsets.all(20).copyWith(bottom: 0),
        height: MediaQuery.of(context).size.height,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Hi, welcome to FindMyCA",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              Column(
                children: [
                  TextFormField(
                    onTap: () => scrollToLast(),
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: emptyValidators,
                    style: const TextStyle(fontFamily: "Poppins"),
                    decoration: getInputDecoration(
                        hintText: "Username", iconData: Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      validator: emptyValidators,
                      onTap: () => scrollToLast(),
                      onChanged: (value) {
                        ref.read(passwordProvider.notifier).state = value;
                      },
                      obscureText: !showPassword,
                      style: const TextStyle(fontFamily: "Poppins"),
                      decoration: getInputDecoration(
                          suffixOnTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          hintText: "Password",
                          iconData: showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                    ),
                  ),
                  LoginButton(
                    email: username,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Are you new?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5)
                              .copyWith(bottom: 6),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          widget.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

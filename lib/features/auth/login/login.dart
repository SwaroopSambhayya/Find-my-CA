import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  final PageController pageController;
  const Login({super.key, required this.pageController});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ScrollController _scrollController;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Hi, welcome to FindMyCA",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Column(
              children: [
                TextField(
                  onTap: () => scrollToLast(),
                  style: const TextStyle(fontFamily: "Poppins"),
                  decoration: getInputDecoration(
                      hintText: "Username", iconData: Icons.person),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    onTap: () => scrollToLast(),
                    obscureText: true,
                    style: const TextStyle(fontFamily: "Poppins"),
                    decoration: getInputDecoration(
                        hintText: "Password", iconData: Icons.key),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              minimumSize: MaterialStateProperty.all(
                                Size(MediaQuery.of(context).size.width, 60),
                              ),
                            ),
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
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
    );
  }
}

import 'package:find_my_ca/features/client/home/home.dart';
import 'package:find_my_ca/features/notifications/notifications.dart';
import 'package:find_my_ca/features/profile/profile.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Navigation extends ConsumerStatefulWidget {
  final int selectedIndex;
  const Navigation({super.key, this.selectedIndex = 0});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Center(
      child: Icon(Icons.chat_bubble_outlined),
    ),
    Notifications(),
    UserProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 55,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 3,
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(1, 0))
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => IconButton(
                  onPressed: () => _onItemTapped(index),
                  icon: Icon(
                    getIcons(index),
                    color: _selectedIndex == index ? primaryColor : Colors.grey,
                    size: 22,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  getIcons(index) {
    switch (index) {
      case 0:
        return _selectedIndex == index ? Icons.home : Icons.home_outlined;
      case 1:
        return _selectedIndex == index
            ? Icons.messenger
            : Icons.messenger_outline;
      case 2:
        return _selectedIndex == index
            ? Icons.notifications
            : Icons.notifications_outlined;
      case 3:
        return _selectedIndex == index ? Icons.person : Icons.person_outlined;
    }
  }
}

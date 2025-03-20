import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.chat_outlined), label: ''),
        NavigationDestination(icon: Icon(Icons.attach_money), label: ''),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          label: '',
        ),
        NavigationDestination(icon: Icon(Icons.lightbulb_outline), label: ''),
        NavigationDestination(icon: Icon(Icons.person_outline), label: ''),
      ],
      onDestinationSelected: (int value) {
        setState(() {
          selectedIndex = value;
        });
      },
      selectedIndex: selectedIndex,
    );
  }
}

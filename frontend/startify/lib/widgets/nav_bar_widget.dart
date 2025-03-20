import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.chat_outlined), label: ''),
            NavigationDestination(icon: Icon(Icons.attach_money), label: ''),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.lightbulb_outline),
              label: '',
            ),
            NavigationDestination(icon: Icon(Icons.person_outline), label: ''),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}

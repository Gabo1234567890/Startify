import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        List<bool> whereIsHome = [false, false, false, false, false];
        if (selectedPage != 0) {
          whereIsHome[selectedPage - 1] = true;
        }

        return NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: selectedPage == 0
                ? Colors.transparent
                : Theme.of(context).colorScheme.secondaryContainer,
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer);
                }
                return TextStyle(
                    color: Theme.of(context).colorScheme.onSurface);
              },
            ),
          ),
          child: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            destinations: [
              NavigationDestination(
                icon: whereIsHome[0]
                    ? Icon(Icons.home_outlined)
                    : Icon(Icons.chat_outlined),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: whereIsHome[1]
                    ? Icon(Icons.home_outlined)
                    : Icon(Icons.attach_money),
                label: 'Invest',
              ),
              NavigationDestination(
                icon: whereIsHome[2]
                    ? Icon(Icons.home_outlined)
                    : Icon(Icons.calendar_month_outlined),
                label: 'Calendar',
              ),
              NavigationDestination(
                icon: whereIsHome[3]
                    ? Icon(Icons.home_outlined)
                    : Icon(Icons.lightbulb_outline),
                label: 'Startups',
              ),
              NavigationDestination(
                icon: whereIsHome[4]
                    ? Icon(Icons.home_outlined)
                    : Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (int value) {
              if (selectedPage - 1 == value) {
                selectedPageNotifier.value = 0;
              } else {
                selectedPageNotifier.value = value + 1;
              }
            },
            selectedIndex: selectedPage == 0 ? selectedPage : selectedPage - 1,
          ),
        );
      },
    );
  }
}

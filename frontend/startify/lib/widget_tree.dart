import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/calendar_page.dart';
import 'package:startify/pages/chat_page.dart';
import 'package:startify/pages/home_page.dart';
import 'package:startify/pages/investments_page.dart';
import 'package:startify/pages/my_startups_page.dart';
import 'package:startify/pages/profile_page.dart';
import 'package:startify/widgets/app_bar_widget.dart';
import 'package:startify/widgets/nav_bar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ChatPage(),
  InvestmentsPage(),
  CalendarPage(),
  MyStartupsPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/home_page.dart';
import 'package:startify/pages/profile_page.dart';
import 'package:startify/widgets/app_bar_widget.dart';
import 'package:startify/widgets/nav_bar_widget.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

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

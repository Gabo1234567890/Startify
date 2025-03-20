import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/home_page.dart';
import 'package:startify/widget_tree.dart';

class AppBarWidgetNoLogIn extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgetNoLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WidgetTree()),
            );
          },
          child: Icon(Icons.arrow_back)
        ),
        
      ),
      title: Text('Startify', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            darkModeNotifier.value = !darkModeNotifier.value;
          },
          icon: ValueListenableBuilder(
            valueListenable: darkModeNotifier,
            builder: (context, darkMode, child) {
              return Icon(darkMode ? Icons.light_mode : Icons.dark_mode);
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

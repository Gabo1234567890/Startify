import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/widget_tree.dart';

class AppBarChatWidget extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  const AppBarChatWidget({super.key, required this.name});

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
          child: Icon(Icons.arrow_back),
        ),
      ),
      title: Column(
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Specialization', style: TextStyle(fontSize: 12)),
        ],
      ),
      centerTitle: true,
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('lib/assets/avatar2.png'),
          radius: 20,
        ),
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Theme.of(context).splashColor, height: 3),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

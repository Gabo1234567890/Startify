import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/calendar_page.dart';
import 'package:startify/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkModeNotifier,
      builder: (context, darkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WidgetTree(),
          theme: ThemeData(
            brightness: darkMode ? Brightness.dark : Brightness.light,
          ),
          
        );
      },
    );
  }
}

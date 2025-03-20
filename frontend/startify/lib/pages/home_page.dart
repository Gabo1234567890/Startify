import 'package:flutter/material.dart';
import 'package:startify/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [SearchBarWidget()]));
  }
}

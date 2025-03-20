import 'package:flutter/material.dart';
import 'package:startify/widgets/idea_preview_widget.dart';
import 'package:startify/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [SearchBarWidget(), IdeaPreviewWidget()]),
      ),
    );
  }
}

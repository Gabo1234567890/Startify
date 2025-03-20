import 'package:flutter/material.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/search_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SearchBarWidget(),
            ListView(
              shrinkWrap: true,
              controller: ScrollController(),
              physics: NeverScrollableScrollPhysics(),
              children: [
                IdeaCardWidget(),
                IdeaCardWidget(),
                IdeaCardWidget(),
                IdeaCardWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

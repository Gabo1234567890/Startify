import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/person_card_widget.dart';
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
            ValueListenableBuilder(
              valueListenable: myIdeaNotifier,
              builder: (context, myIdea, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (myIdeaNotifier.value) {
                    myIdeaNotifier.value = false;
                  }
                });
                return ValueListenableBuilder(
                  valueListenable: ideaSearchNotifier,
                  builder: (context, ideaSearch, child) {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children:
                          ideaSearch
                              ? [
                                IdeaCardWidget(),
                                IdeaCardWidget(),
                                IdeaCardWidget(),
                                IdeaCardWidget(),
                              ]
                              : [
                                PersonCardWidget(),
                                PersonCardWidget(),
                                PersonCardWidget(),
                                PersonCardWidget(),
                              ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

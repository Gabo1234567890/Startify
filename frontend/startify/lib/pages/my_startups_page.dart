import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/plus_button_widget.dart';

class MyStartupsPage extends StatelessWidget {
  const MyStartupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text(
                      'Startups: 4',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 175),
                    PlusButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 5.0,
                  ),
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Search Startups...',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: myIdeaNotifier,
                builder: (context, myIdea, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!myIdeaNotifier.value) {
                      myIdeaNotifier.value = true;
                    }
                  });
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      IdeaCardWidget(),
                      IdeaCardWidget(),
                      IdeaCardWidget(),
                      IdeaCardWidget(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

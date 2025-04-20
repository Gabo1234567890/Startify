import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/widgets/idea_card_widget.dart';

class InvestmentsPage extends StatelessWidget {
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Invested Money',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text('1000 \$')),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Received Money',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text('3000 \$')),
                      ),
                    ],
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: myIdeaNotifier,
                builder: (context, myIdea, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (myIdeaNotifier.value) {
                      myIdeaNotifier.value = false;
                    }
                  });
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // IdeaCardWidget(),
                      // IdeaCardWidget(),
                      // IdeaCardWidget(),
                      // IdeaCardWidget(),
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

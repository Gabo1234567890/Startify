import 'package:flutter/material.dart';
import 'package:startify/widgets/app_bar_widget.dart';
import 'package:startify/widgets/app_bar_widget_nologin.dart';
import 'package:startify/widgets/person_card_widget.dart';
import 'package:startify/widgets/plus_button_widget.dart';
import 'package:startify/widgets/edit_button_widget.dart';

class MyStartupPage extends StatelessWidget {
  const MyStartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidgetNoLogIn(),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 20),
                      child: Text(
                        "STARTUP'S NAME",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PlusButton(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 165,
                            height: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/idea_placeholder.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 165,
                            height: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/idea_placeholder.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 165,
                            height: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                              image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/idea_placeholder.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              "DESCRIPTION",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: 180,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: EditButtonWidget(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Mobile application that connects enterpreneurs and investitors.',
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'TEAM',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: 225,
                          ),
                          PlusButton(),
                        ],
                      ),
                    ),
                    PersonCardWidget(),
                    PersonCardWidget(),
                    PersonCardWidget(),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'DOCUMENTS',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "1. Document's name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.circle_outlined),
                      ],
                    ),
                    Container(
                      width: 140,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

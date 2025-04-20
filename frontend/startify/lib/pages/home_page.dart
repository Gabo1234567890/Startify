import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/services/auth_service.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/person_card_widget.dart';
import 'package:startify/widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = AuthService().getUsers();
  }

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
                    return ideaSearch
                        ? ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // IdeaCardWidget(),
                            // IdeaCardWidget(),
                            // IdeaCardWidget(),
                            // IdeaCardWidget(),
                          ],
                        )
                        : FutureBuilder<List<Map<String, dynamic>>>(
                          future: _usersFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              final users = snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  final user = users[index];
                                  return PersonCardWidget(
                                    name: user['username'],
                                    bio:
                                        user['bio'] == null || user['bio'] == ''
                                            ? 'No bio'
                                            : user['bio'],
                                  );
                                },
                              );
                            }
                          },
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

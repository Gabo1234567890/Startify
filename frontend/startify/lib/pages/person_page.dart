import 'package:flutter/material.dart';
import 'package:startify/pages/dm_page.dart';
import 'package:startify/services/auth_service.dart';
import 'package:startify/services/chat_service.dart';
import 'package:startify/widgets/app_bar_widget_nologin.dart';
import 'package:startify/widgets/idea_card_widget.dart';

class PersonPage extends StatelessWidget {
  final String name;
  final String bio;

  const PersonPage({super.key, required this.name, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetNoLogIn(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          final allUsers = await AuthService().getUsers();
                          late final id;
                          for (dynamic element in allUsers) {
                            if (element['username'] == name) {
                              id = element['id'];
                              break;
                            }
                          }
                          final chat = await ChatService().createChat(id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DmPage(chatId: chat['id'], name: name),
                            ),
                          );
                        } catch (e) {
                          print("Error starting chat: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to start chat: $e")),
                          );
                        }
                      },
                      icon: Icon(Icons.chat_outlined, size: 60),
                    ),
                  ],
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage("lib/assets/avatar2.png"),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(bio, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Startups",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IdeaCardWidget(
                      name: name,
                      description: "description",
                      goalAmount: 0,
                      raisedAmount: 0,
                    ),
                    IdeaCardWidget(
                      name: name,
                      description: "description",
                      goalAmount: 0,
                      raisedAmount: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

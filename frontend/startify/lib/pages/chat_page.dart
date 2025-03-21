import 'package:flutter/material.dart';
import 'package:startify/widgets/chat_card_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 15, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert_rounded),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Search Chat...',
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
            ChatCardWidget(),
          ],
        ),
      ),
    );
  }
}

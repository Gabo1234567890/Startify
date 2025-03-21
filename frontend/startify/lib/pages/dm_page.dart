import 'package:flutter/material.dart';
import 'package:startify/widgets/app_bar_chat_widget.dart';
import 'package:startify/widgets/chat_bubble_widget.dart';

class DmPage extends StatelessWidget {
  const DmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarChatWidget(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children:
                  const [
                    ChatBubbleWidget(message: "Hello!", isSentByMe: false),
                    ChatBubbleWidget(
                      message: "Hey! How are you?",
                      isSentByMe: true,
                    ),
                    ChatBubbleWidget(
                      message: "I'm good, what about you?",
                      isSentByMe: false,
                    ),
                    ChatBubbleWidget(
                      message: "Doing great! Working on a Flutter project.",
                      isSentByMe: true,
                    ),
                  ].reversed.toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).splashColor, width: 3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle file selection
                  },
                ),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle sending message
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

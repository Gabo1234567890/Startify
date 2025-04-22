import 'package:flutter/material.dart';
import 'package:startify/services/auth_service.dart';
import 'package:startify/services/chat_service.dart';
import 'package:startify/widgets/app_bar_chat_widget.dart';
import 'package:startify/widgets/chat_bubble_widget.dart';

class DmPage extends StatefulWidget {
  final String chatId;
  final String name;

  const DmPage({super.key, required this.chatId, required this.name});

  @override
  State<DmPage> createState() => _DmPageState();
}

class _DmPageState extends State<DmPage> {
  late Future<List<Map<String, dynamic>>> _messages;
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _messages = ChatService().getMessages(widget.chatId);
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty || _isSending) {
      return;
    }
    setState(() => _isSending = true);

    try {
      await ChatService().sendMessage(widget.chatId, content);
      _messageController.clear();
      setState(() {
        _messages = ChatService().getMessages(widget.chatId);
      });
    } catch (e) {
      print("Error sending message: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to send message: $e")));
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarChatWidget(name: widget.name),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _messages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages'));
          }

          final messages = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return FutureBuilder<bool>(
                      future: isSentByMe(message),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return ChatBubbleWidget(
                            message: message['content'],
                            isSentByMe: snapshot.data!,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
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
                      controller: _messageController,
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
                IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> isSentByMe(message) async {
  final currentUser = await AuthService().getProfile();
  final allUsers = await AuthService().getUsers(withCurrent: true);
  late final id;
  for (dynamic element in allUsers) {
    if (element['username'] == currentUser['username']) {
      id = element['id'];
      break;
    }
  }

  return message['sender_id'] == id;
}

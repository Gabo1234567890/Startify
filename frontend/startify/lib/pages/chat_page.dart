import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startify/pages/login_page.dart';
import 'package:startify/services/chat_service.dart';
import 'package:startify/widgets/chat_card_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Map<String, dynamic>>> _chats;
  final storage = FlutterSecureStorage();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _chats = _getChats();
  }

  Future<void> _checkLoginStatus() async {
    final token = await storage.read(key: 'access_token');
    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      _chats = _getChats();
    });
  }

  Future<List<Map<String, dynamic>>> _getChats() {
    return ChatService().getChats(search: _searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _chats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No chats available'));
          }

          final chats = snapshot.data!;
          return SingleChildScrollView(
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
                            onChanged: _onSearchChanged,
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
                ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ChatCardWidget(
                      chatId: chat['id'],
                      name: chat['user1_name'],
                      lastMessage: chat['last_message'],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

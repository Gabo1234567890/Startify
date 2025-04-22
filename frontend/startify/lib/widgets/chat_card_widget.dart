import 'package:flutter/material.dart';
import 'package:startify/pages/dm_page.dart';

class ChatCardWidget extends StatelessWidget {
  final String chatId;
  final String name;
  final String lastMessage;

  const ChatCardWidget({
    super.key,
    required this.chatId,
    required this.name,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 25,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DmPage(chatId: chatId, name: name);
                  },
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/avatar2.png'),
              radius: 35,
            ),
            title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Specialization',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(height: 0, thickness: 3),
        ],
      ),
    );
  }
}

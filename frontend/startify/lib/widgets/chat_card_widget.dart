import 'package:flutter/material.dart';
import 'package:startify/pages/dm_page.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget({super.key});

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
                    return DmPage();
                  },
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/avatar2.png'),
              radius: 35,
            ),
            title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Last message • 19:03',
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

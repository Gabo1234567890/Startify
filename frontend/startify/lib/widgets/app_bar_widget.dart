import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/login_page.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final storage = FlutterSecureStorage();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await storage.read(key: 'access_token');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    setState(() {
      isLoggedIn = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: GestureDetector(
          onTap: () {
            isLoggedIn
                ? logout()
                : Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
          },
          child: Center(child: Text(isLoggedIn ? 'Log Out' : 'Log In')),
        ),
      ),
      title: Text('Startify', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            darkModeNotifier.value = !darkModeNotifier.value;
          },
          icon: ValueListenableBuilder(
            valueListenable: darkModeNotifier,
            builder: (context, darkMode, child) {
              return Icon(darkMode ? Icons.light_mode : Icons.dark_mode);
            },
          ),
        ),
      ],
    );
  }
}

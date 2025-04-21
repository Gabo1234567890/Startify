import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:startify/pages/create_startup_page.dart';
import 'package:startify/pages/login_page.dart';
import 'package:startify/services/startup_service.dart';
import 'package:startify/widgets/idea_card_widget.dart';
import 'package:startify/widgets/plus_button_widget.dart';

class MyStartupsPage extends StatefulWidget {
  const MyStartupsPage({super.key});

  @override
  State<MyStartupsPage> createState() => _MyStartupsPageState();
}

class _MyStartupsPageState extends State<MyStartupsPage> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: StartupService().getMyStartups(),
        builder: (context, snapshot) {
          final startups = snapshot.data ?? [];
          return SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Text(
                          'Startups: ${startups.length}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 175),
                        PlusButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateStartupPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 5.0,
                      ),
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Search Startups...',
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Center(child: CircularProgressIndicator())
                  else if (snapshot.hasError)
                    Center(child: Text('Error: ${snapshot.error}'))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: startups.length,
                      itemBuilder: (context, index) {
                        final startup = startups[index];
                        return IdeaCardWidget(
                          name: startup['name'],
                          description: startup['description'] ?? '',
                          goalAmount: startup['goalAmount'] ?? 0,
                          raisedAmount: startup['raisedAmount'] ?? 0,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

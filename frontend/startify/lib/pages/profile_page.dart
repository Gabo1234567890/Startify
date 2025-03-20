import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _isPasswordVisible = false; // Controls password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 100, // Adjust size
                backgroundImage: AssetImage(
                  "lib/assets/avatar2.png", //! Get from backend via REST
                ),
              ),
            ),
            SizedBox(height: 26), //! Spacing
            Text(
              "Text1",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //! Handle account change logic
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text("Change Account", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 16),
            _buildTitle(context, "About Me"),
            _buildField(
              "This is a short bio. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
            SizedBox(height: 10),
            _buildTitle(context, "Email"),
            _buildField("user@example.com"),
            SizedBox(height: 10),
            _buildTitle(context, "Password"),
            _buildPasswordField("Passss"), // Hidden password with bullets
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.primaryContainer, // Adapts to theme
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              //! Handle edit action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField(String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Text(
        value,
        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildPasswordField(String password) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _isPasswordVisible ? password : "•" * password.length,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ],
      ),
    );
  }
}

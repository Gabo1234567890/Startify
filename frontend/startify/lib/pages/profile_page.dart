import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool _isPasswordVisible = false; //* Controls password visibility

  @override
  Widget build(BuildContext context) {
    // Determine the current theme mode
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on the theme mode
    final Color containerColor =
        isDarkMode ? Color(0xFF2D526C) : Color.fromRGBO(224, 253, 255, 1);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color iconColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(
                        "lib/assets/avatar2.png", //! Get from backend via REST
                      ),
                    ),

                    //* Edit Profile Picture Button
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: containerColor,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: iconColor),
                          onPressed: () {
                            //! Handle profile picture change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Text(
                "Name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  //! Handle account change logic
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  foregroundColor: textColor,
                  backgroundColor: containerColor,
                ),
                child: const Text("Change Account"),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), // Round top-right
                        bottomRight: Radius.circular(20), // Round bottom-right
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'About me',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 185),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Icon(Icons.edit, size: 20, color: iconColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildField(
                "This is a short bio. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textColor: textColor,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), // Round top-right
                        bottomRight: Radius.circular(20), // Round bottom-right
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 218),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Icon(Icons.edit, size: 20, color: iconColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildField("user@example.com", textColor: textColor),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), // Round top-right
                        bottomRight: Radius.circular(20), // Round bottom-right
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 184),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Icon(Icons.edit, size: 20, color: iconColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildPasswordField("Passss", textColor: textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String value, {required Color textColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: textColor.withValues(alpha: 0.7), // Slightly transparent text
        ),
      ),
    );
  }

  Widget _buildPasswordField(String password, {required Color textColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _isPasswordVisible ? password : "•" * password.length,
            style: TextStyle(
              fontSize: 16,
              color: textColor.withValues(
                alpha: 0.7,
              ), // Slightly transparent text
            ),
          ),
          IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: textColor,
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

import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/login_page.dart';
import 'package:startify/services/auth_service.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  MyProfilePageState createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  bool _isPasswordVisible = false;
  bool _isLoading = true;
  bool isEditingBio = false;
  late TextEditingController bioController;
  late Map<String, dynamic> userData = {};

  Future<void> _loadUserData() async {
    try {
      final data = await AuthService().getProfile();
      setState(() {
        userData = data;
        _isLoading = false;
      });

      if (userData['username'] == "" || userData['username'] == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    bioController = TextEditingController(text: userData["bio"] ?? "");
    bioController.selection = TextSelection.fromPosition(
      TextPosition(offset: bioController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ValueListenableBuilder(
          valueListenable: darkModeNotifier,
          builder: (context, darkMode, child) {
            final Color containerColor =
                darkMode ? Color(0xFF2D526C) : Color.fromRGBO(224, 253, 255, 1);
            final Color textColor = darkMode ? Colors.white : Colors.black;
            final Color iconColor = darkMode ? Colors.white : Colors.black;
            return Padding(
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
                    userData["username"],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
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
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
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
                              onPressed: () async {
                                if (isEditingBio) {
                                  try {
                                    await AuthService().updateProfile(
                                      bio: bioController.text,
                                    );
                                    setState(() {
                                      isEditingBio = false;
                                    });
                                  } catch (e) {
                                    print("Error updating bio: $e");
                                  }
                                } else {
                                  setState(() {
                                    isEditingBio = true;
                                    bioController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(
                                        offset: bioController.text.length,
                                      ),
                                    );
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Icon(
                                isEditingBio ? Icons.check : Icons.edit,
                                size: 20,
                                color: iconColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isEditingBio
                      ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: TextField(
                          controller: bioController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Enter your bio...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(color: textColor),
                          maxLines: null,
                        ),
                      )
                      : _buildField(
                        bioController.text.isNotEmpty
                            ? bioController.text
                            : "No bio.",
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
                            bottomRight: Radius.circular(
                              20,
                            ), // Round bottom-right
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
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: iconColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildField(userData['email'], textColor: textColor),
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
                            bottomRight: Radius.circular(
                              20,
                            ), // Round bottom-right
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
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: iconColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildPasswordField("Passss", textColor: textColor),
                ],
              ),
            );
          },
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

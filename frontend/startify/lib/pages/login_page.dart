import 'package:flutter/material.dart';
import 'package:startify/data/notifiers.dart';
import 'package:startify/pages/create_account_page.dart';
import 'package:startify/widget_tree.dart';
import 'package:startify/widgets/app_bar_widget_nologin.dart';
import 'package:startify/services/auth_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AuthService().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      String username = JwtDecoder.decode(response['access_token'])['username'];

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Welcome back, $username!")));
      selectedPageNotifier.value = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WidgetTree()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetNoLogIn(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              const Icon(Icons.person_outline, size: 200),
              const SizedBox(height: 40),

              // Email Field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Sign In Button
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child:
                    _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In", style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 15),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountPage(),
                    ),
                  );
                },
                child: const Text(
                  "Don't have an account? Create one here!",
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

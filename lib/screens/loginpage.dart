import 'package:flutter/material.dart';
import 'package:portfolioapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolioapp/widgets/custombutton.dart';
import 'package:portfolioapp/widgets/normal_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      User? user = await _authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNormalTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            SizedBox(height: 20),
            buildNormalTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomButton(
              isLoading: _isLoading,
              text: 'Login',
              onTap: _login,
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

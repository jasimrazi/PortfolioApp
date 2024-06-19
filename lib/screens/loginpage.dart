import 'package:flutter/material.dart';
import 'package:portfolioapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolioapp/widgets/appbar.dart';
import 'package:portfolioapp/widgets/button.dart';
import 'package:portfolioapp/widgets/textbutton.dart';
import 'package:portfolioapp/widgets/normal_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  Future<void> _login() async {
    setState(() {
      _emailError =
          _emailController.text.isEmpty ? 'Email should not be empty' : null;
      _passwordError = _passwordController.text.isEmpty
          ? 'Password should not be empty'
          : null;
    });

    if (_emailError != null || _passwordError != null) {
      return;
    }

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
        SnackBar(
          content: Text('Failed to sign in: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
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
      appBar: CustomAppBar(title: 'Login Page'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildNormalTextField(
                controller: _emailController,
                hintText: 'Email',
                errorText: _emailError,
              ),
              SizedBox(height: 20),
              buildNormalTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                errorText: _passwordError,
              ),
              SizedBox(height: 20),
              CustomButton(
                isLoading: _isLoading,
                text: 'Login',
                onTap: _login,
              ),
              SizedBox(height: 20),
              CustomTextButton(
                text: 'Don\'t have an account? Sign Up',
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

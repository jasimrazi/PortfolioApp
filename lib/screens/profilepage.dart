import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolioapp/widgets/button.dart';
import 'package:portfolioapp/widgets/textfield.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      _fetchUserData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(_currentUser!.uid)
          .get();
      if (doc.exists) {
        setState(() {
          _userData = doc.data();
          _isLoading = false;
          emailController.text = _currentUser?.email ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  Future<void> _updateUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(_currentUser!.uid)
          .update({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user data: $e')),
      );
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Color(0xfffafbfb),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit your email and password below:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    controller: emailController,
                    labelText: 'Email',
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    isObscure: true,
                  ),
                  Spacer(),
                  CustomButton(
                    isLoading: false,
                    text: 'Update',
                    onTap: _updateUserData,
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    isLoading: false,
                    text: 'Logout',
                    onTap: _logout,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
    );
  }
}

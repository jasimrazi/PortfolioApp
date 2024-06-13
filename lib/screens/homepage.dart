import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolioapp/screens/userinfo.dart';
import 'package:portfolioapp/widgets/custom_appbar.dart';
import 'package:portfolioapp/widgets/section_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(_currentUser!.uid)
          .get();
      setState(() {
        _userData = doc.data();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Portfolio'),
      body: _isLoading
          ? Center(child: CupertinoActivityIndicator())
          : _userData == null
              ? Center(child: Text('No data found'))
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 75,
                          backgroundImage: _userData!['profile_image'] != null
                              ? NetworkImage(_userData!['profile_image'])
                              : null,
                        ),
                        SizedBox(height: 20),
                        SectionContainer(
                          title: 'Personal Information',
                          icon: Icons.info_outline,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${_userData!['name']}'),
                              SizedBox(height: 10),
                              Text('Custom URL: ${_userData!['custom_url']}'),
                              SizedBox(height: 10),
                              Text('About Me: ${_userData!['about_me']}'),
                            ],
                          ),
                        ),
                        SectionContainer(
                          title: 'Social Media',
                          icon: Icons.public_outlined,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _userData!['social_media']
                                .map<Widget>((link) => Text(link))
                                .toList(),
                          ),
                        ),
                        SectionContainer(
                          title: 'Projects',
                          icon: Icons.work_outline,
                          child: Column(
                            children:
                                _userData!['projects'].map<Widget>((project) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title: ${project['title']}'),
                                  SizedBox(height: 5),
                                  Text(
                                      'Description: ${project['description']}'),
                                  SizedBox(height: 5),
                                  Text('URL: ${project['url']}'),
                                  Divider(color: Colors.grey.shade200),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserInfoPage()),
          ).then((value) {
            // Refresh the user data after editing
            _fetchUserData();
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

// home_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolioapp/screens/userinfo.dart';
import 'package:portfolioapp/widgets/appbar.dart';
import 'package:portfolioapp/widgets/section_container.dart';
import 'package:portfolioapp/widgets/social_media_icons.dart';

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

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed(
        '/login'); // Adjust the route to your login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Portfolio', onLogout: _logout),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${_userData!['name']}',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text('Custom URL: ${_userData!['custom_url']}'),
                            SizedBox(height: 10),
                            SectionContainer(
                              title: 'About me',
                              child: Text(
                                '${_userData!['about_me']}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.grey.shade600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _userData!['social_media']
                              .map<Widget>((link) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SocialMediaIconWidget(url: link),
                                  ))
                              .toList(),
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

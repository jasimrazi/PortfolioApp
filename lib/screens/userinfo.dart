import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolioapp/widgets/custom_appbar.dart';
import 'package:portfolioapp/widgets/custom_button.dart';
import 'package:portfolioapp/widgets/custom_textbutton.dart';
import 'package:portfolioapp/widgets/social_media_field.dart';
import 'package:portfolioapp/widgets/project_field.dart';
import 'package:portfolioapp/widgets/textfield.dart';
import 'package:portfolioapp/widgets/section_container.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();
  final List<TextEditingController> _socialMediaControllers = [
    TextEditingController()
  ];
  final List<Map<String, TextEditingController>> _projectControllers = [
    {
      'title': TextEditingController(),
      'description': TextEditingController(),
      'url': TextEditingController()
    }
  ];

  bool _isLoading = false;
  XFile? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  Future<void> _submitData() async {
    if (_nameController.text.isEmpty || _urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name and Custom URL are required')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final data = {
          'name': _nameController.text,
          'custom_url': _urlController.text,
          'about_me': _aboutMeController.text,
          'social_media': _socialMediaControllers
              .map((controller) => controller.text)
              .toList(),
          'projects': _projectControllers.map((controllers) {
            return {
              'title': controllers['title']!.text,
              'description': controllers['description']!.text,
              'url': controllers['url']!.text,
            };
          }).toList(),
        };

        if (_profileImage != null) {
          // You can upload the image to Firebase Storage and get the URL, then save it to Firestore
        }

        await FirebaseFirestore.instance
            .collection('userdata')
            .doc(user.uid)
            .set(data);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit data: $e')),
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
      appBar: CustomAppBar(title: 'Complete your profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(File(_profileImage!.path))
                      : null,
                  child: _profileImage == null
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(height: 20),
              SectionContainer(
                title: 'Personal Information',
                icon: Icons.info_outline,
                child: Column(
                  children: [
                    buildTextField(
                        controller: _nameController, labelText: 'Name'),
                    buildTextField(
                        controller: _urlController, labelText: 'Custom URL'),
                    buildTextField(
                      controller: _aboutMeController,
                      labelText: 'About Me',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SectionContainer(
                title: 'Social Media',
                icon: Icons.public_outlined,
                child: Column(
                  children: [
                    ..._socialMediaControllers.asMap().entries.map((entry) {
                      return SocialMediaField(
                        controller: entry.value,
                        onRemove: () {
                          setState(() {
                            _socialMediaControllers.removeAt(entry.key);
                          });
                        },
                      );
                    }).toList(),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey.shade200,
                    ),
                    CustomTextButton(
                      text: 'Add Social Media Link',
                      icon: Icons.add_circle_outline,
                      onTap: () {
                        setState(() {
                          _socialMediaControllers.add(TextEditingController());
                        });
                      },
                    ),
                  ],
                ),
              ),
              SectionContainer(
                title: 'Projects',
                icon: Icons.work_outline,
                child: Column(
                  children: [
                    ..._projectControllers.asMap().entries.map((entry) {
                      return ProjectField(
                        titleController: entry.value['title']!,
                        descriptionController: entry.value['description']!,
                        urlController: entry.value['url']!,
                        onRemove: () {
                          setState(() {
                            _projectControllers.removeAt(entry.key);
                          });
                        },
                      );
                    }).toList(),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey.shade200,
                    ),
                    CustomTextButton(
                      text: 'Add Project',
                      icon: Icons.add_circle_outline,
                      onTap: () {
                        setState(() {
                          _projectControllers.add({
                            'title': TextEditingController(),
                            'description': TextEditingController(),
                            'url': TextEditingController(),
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                isLoading: _isLoading,
                text: 'Submit',
                onTap: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

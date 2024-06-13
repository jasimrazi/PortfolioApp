import 'package:flutter/material.dart';
import 'package:portfolioapp/widgets/textfield.dart';

class ProjectField extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController urlController;
  final VoidCallback onRemove;

  ProjectField({
    required this.titleController,
    required this.descriptionController,
    required this.urlController,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTextField(
          controller: titleController,
          labelText: 'Project Title',
        ),
        buildTextField(
          controller: descriptionController,
          labelText: 'Project Description',
          maxLines: 5,
        ),
        buildTextField(
          controller: urlController,
          labelText: 'Project URL',
        ),
        IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: onRemove,
        ),
      ],
    );
  }
}

// project_widget.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectWidget extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectWidget({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${project['title']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '${project['description']}',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.link,
                color: Colors.grey.shade400,
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  final Uri uri = Uri.parse(project['url']);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch ${project['url']}'),
                      ),
                    );
                  }
                },
                child: Text(
                  '${project['url']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

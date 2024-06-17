// social_media_icon_widget.dart
import 'package:flutter/material.dart';
import 'package:portfolioapp/utilities/social_media.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIconWidget extends StatelessWidget {
  final String url;

  SocialMediaIconWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () async {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch $url')),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(50),
            ),
            child: SocialMediaUtils.getSocialMediaIcon(url),
          ),
        ),
      ),
    );
  }
}

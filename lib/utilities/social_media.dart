// social_media_utils.dart
import 'package:flutter/material.dart';

class SocialMediaUtils {
  static Widget getSocialMediaIcon(String url) {
    if (url.contains('instagram.com')) {
      return Image.asset('assets/icons/instagram.png', width: 24, height: 24);
    } else if (url.contains('facebook.com')) {
      return Image.asset('assets/icons/facebook.png', width: 24, height: 24);
    } else if (url.contains('github.com')) {
      return Image.asset('assets/icons/github.png', width: 24, height: 24);
    } else if (url.contains('linkedin.com')) {
      return Image.asset('assets/icons/linkedin.png', width: 24, height: 24);
    } else {
      return Icon(Icons.link); // Default icon if no match found
    }
  }
}

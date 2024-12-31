
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';


class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({super.key,
    required this.isUser,
    required this.message,
    required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
          left: isUser ? 100 : 16, right: isUser ? 16 : 100),
      decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
              topRight: const Radius.circular(10),
              bottomRight: isUser ? Radius.zero : const Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: message,
            onTapLink: (text, href, title) => _launchURL(href ?? ''),
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 16,
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: isUser ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }


  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    print('Launching URL: $uri');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      print('URL launched successfully');
    } else {
      throw 'Could not launch $url';
    }
  }
}
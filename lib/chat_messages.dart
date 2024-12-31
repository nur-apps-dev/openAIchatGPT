
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
   ChatMessages({super.key, required this.text, required this.sender, this.isImage = false});
   final String text;
   final String sender;
   final bool isImage;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(sender, style: TextStyle(color: sender == "user"? Colors.red: Colors.green),),
        Expanded(
          child: isImage
              ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              text,
              loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null
                  ? child
                  : const CircularProgressIndicator.adaptive(),
            ),
          )
              : Text(text,style: TextStyle(),)
        ),
      ],
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'chat_messages.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
//
// import 'const.dart';
// class GptScreen extends StatefulWidget {
//    GptScreen({super.key});
//
//
//   @override
//   State<GptScreen> createState() => _GptScreenState();
// }
//
// class _GptScreenState extends State<GptScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<ChatMessages> _messages = [];
//
//   late OpenAI chatGPT;
//   bool _isImageSearch = false;
//
//   bool _isTyping = false;
//   @override
//   void initState() {
//     super.initState();
//     chatGPT = OpenAI.instance.build(
//       token: OPENAI_API_KEY, // Replace with your actual API key
//       baseOption: HttpSetup(receiveTimeout: Duration(seconds: 5)),
//       enableLog: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     chatGPT?.close();
//     chatGPT?.genImgClose();
//     super.dispose();
//   }
//   void _senderMessages(){
//     ChatMessages chatMessages = ChatMessages(
//       text: _controller.text,
//       sender: "user",
//       isImage: false,
//     );
//     setState(() {
//       _messages.insert(0, chatMessages);
//       _isTyping = true;
//     });
//     _controller.clear();
//   }
//
//   Widget _buildTextComposer(){
//     return Row(
//       children: [
//         Expanded(child: TextField(
//           controller: _controller,
//           onSubmitted: (value)=>_senderMessages(),
//           decoration: InputDecoration.collapsed(hintText: "send a message"),
//         )),
//         IconButton(onPressed: ()=>
//           _senderMessages(),
//          icon: Icon(Icons.send))
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text("data"),),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Flexible(child: ListView.builder(
//                 reverse: true,
//                 padding: EdgeInsets.all(8),
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                 return _messages[index];
//               },)),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: _buildTextComposer(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

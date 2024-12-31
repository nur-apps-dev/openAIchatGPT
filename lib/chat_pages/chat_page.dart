// import 'dart:async';
//
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:chatbot_openai/const.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
//
// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});
//
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
// final _openAI = OpenAI.instance.build(
//   token: OPENAI_API_KEY,
//   baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)), // Adjust timeout
//   enableLog: true,
// );
// final ChatUser _currentUser = ChatUser(id: "1",lastName: "Nur",firstName: "Islam");
// final ChatUser _gptChatUser = ChatUser(id: "2",lastName: "Cheloper",firstName: "GPT");
//
// List<ChatMessage> _messeges = <ChatMessage>[];
// List<ChatUser> _typeUser = <ChatUser>[];
// Timer? _debounce;
//
//
// class _ChatPageState extends State<ChatPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ChatGpt",style: TextStyle( color: Colors.white),),backgroundColor: Colors.red,),
//     body: DashChat(
//         currentUser: _currentUser,
//       typingUsers: _typeUser,
//         messageOptions: const MessageOptions(
//           currentUserContainerColor: Colors.black
//         ),
//         onSend: (ChatMessage m){
//          getChatResponse(m);
//     }, messages: _messeges),
//     );
//   }
//   Future<void> getChatResponse(ChatMessage mM) async{
// setState(() {
//   _messeges.insert(0, mM);
//   _typeUser.add(_gptChatUser);
// });
// final List<Messages> _messageHistory = _messeges.reversed.map((m) {
//   if(m.user == _currentUser){
//     return Messages(role: Role.user,content: m.text);
//   }else{
//     return Messages(role: Role.assistant,content: m.text);
//   }
//   // // return {
//   // //   'role': message.user.id == _currentUser.id ? 'user' : 'assistant',
//   // //   'content': message.text ?? '',
//   // // };
//   // if()
// }).toList();
//
// final request = ChatCompleteText(
//   model:GptTurbo0301ChatModel(),
//   messages: _messageHistory,
//   maxToken: 200,
// );
// // final response = await _openAI.onChatCompletion(request: request);
// // for( var element in response!.choices){
// //   if(element.message != null){
// //     setState(() {
// //       _messeges.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(),text: element.message!.content),);
// //     });
// //
// //   }
// // }
//     try {
//       final response = await _openAI.onChatCompletion(request: request);
//       print("response ------------------------------$response");
//       for (var element in response!.choices) {
//         if (element.message != null) {
//           setState(() {
//             _messeges.insert(0, ChatMessage(
//               user: _gptChatUser,
//               createdAt: DateTime.now(),
//               text: element.message!.content,
//             ));
//           });
//         }
//       }
//     } catch (error) {
//       if (error.toString().contains('insufficient_quota')) {
//         setState(() {
//           _messeges.insert(0, ChatMessage(
//             user: _gptChatUser,
//             createdAt: DateTime.now(),
//             text: "You've exceeded your quota. Please check your OpenAI plan and billing details.",
//           ));
//         });
//       } else {
//         print("Error: $error");
//         setState(() {
//           _messeges.insert(0, ChatMessage(
//             user: _gptChatUser,
//             createdAt: DateTime.now(),
//             text: "An unexpected error occurred: ${error.toString()}",
//           ));
//         });
//       }
//     }
//
//     setState(() {
//   _typeUser.remove(_gptChatUser);
// });
//   }
//
//
// }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:dash_chat_2/dash_chat_2.dart';
// // import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// //
// // // OpenAI setup
// // final _openAI = OpenAI.instance.build(
// //   token: OPENAI_API_KEY,
// //   baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
// //   enableLog: true,
// // );
// //
// // // Define Chat Users
// // final ChatUser _currentUser = ChatUser(id: "1", lastName: "Nur", firstName: "Islam");
// // final ChatUser _gptChatUser = ChatUser(id: "2", lastName: "Cheloper", firstName: "GPT");
// //
// // // Messages list
// // List<ChatMessage> _messege = <ChatMessage>[];
// //
// // class ChatPage extends StatefulWidget {
// //   const ChatPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ChatPage> createState() => _ChatPageState();
// // }
// //
// // class _ChatPageState extends State<ChatPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("ChatGpt", style: TextStyle(color: Colors.white)),
// //         backgroundColor: Colors.red,
// //       ),
// //       body: DashChat(
// //         currentUser: _currentUser,
// //         messageOptions: const MessageOptions(
// //           currentUserContainerColor: Colors.black,
// //         ),
// //         onSend: (ChatMessage m) {
// //           getChatResponse(m); // Trigger response on message send
// //         },
// //         messages: _messege,
// //       ),
// //     );
// //   }
// //
// //   Future<void> getChatResponse(ChatMessage m) async {
// //     // Add the user's message to the list
// //     setState(() {
// //       _messege.insert(0, m);
// //     });
// //
// //     // Debug: Print the current list of messages
// //     print('_messege: $_messege');
// //
// //     // Construct chat history in the required format
// //     List<Map<String, dynamic>> _chatHistory = _messege.reversed.map((message) {
// //       return {
// //         'role': message.user.id == _currentUser.id ? 'user' : 'assistant',
// //         'content': message.text ?? '',
// //       };
// //     }).toList();
// //
// //     print('Constructed _chatHistory: $_chatHistory'); // Debug constructed history
// //
// //     // Create the API request
// //     final request = ChatCompleteText(
// //       model: GptTurbo16k0631Model(), // Ensure the correct model is used
// //       messages: _chatHistory, // Pass chat history as a list of maps
// //       maxToken: 200, // Set appropriate maxToken
// //     );
// //
// //     print('Sending request: $request'); // Debug request details
// //
// //     try {
// //       // Send the API request
// //       final response = await _openAI.onChatCompletion(request: request);
// //
// //       print('API Response: $response'); // Debug API response
// //
// //       // Process the API response and add the bot's reply
// //       for (var element in response!.choices) {
// //         if (element.message != null) {
// //           setState(() {
// //             _messege.insert(
// //               0,
// //               ChatMessage(
// //                 user: _gptChatUser,
// //                 createdAt: DateTime.now(),
// //                 text: element.message!.content,
// //               ),
// //             );
// //           });
// //         }
// //       }
// //     } catch (e) {
// //       // Handle and debug any errors
// //       print('Error: $e');
// //     }
// //   }
// // }

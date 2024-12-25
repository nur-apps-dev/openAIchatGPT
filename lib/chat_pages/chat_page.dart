import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_openai/const.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}
final _openAI = OpenAI.instance.build(token: OPENAI_API_KEY, baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
final ChatUser _currentUser = ChatUser(id: "1",lastName: "Nur",firstName: "Islam");
final ChatUser _gptChatUser = ChatUser(id: "2",lastName: "Cheloper",firstName: "GPT");

List<ChatMessage> _messege = <ChatMessage>[];
class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatGpt",style: TextStyle( color: Colors.white),),backgroundColor: Colors.red,),
    body: DashChat(currentUser: _currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black
        ),
        onSend: (ChatMessage m){
getChatResponse(m);
    }, messages: _messege),
    );
  }
  Future<void> getChatResponse(ChatMessage m) async{
setState(() {
  _messege.insert(0, m);
});
  }
}

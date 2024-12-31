
import 'package:chatbot_openai/model/message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import '../constant/color.dart';
import '../constant/constant.dart';

import 'message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _userInput = TextEditingController();
  late final GenerativeModel model;
  late final ScrollController _scrollController;
  late final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    _scrollController = ScrollController();
    _addMessage(
      isUser: false,
      message: "Welcome! How can I assist you today?",
    );

  }

  @override
  void dispose() {
    _userInput.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final message = _userInput.text;
    if (message.isNotEmpty) {
      _userInput.clear();
      //FocusScope.of(context).unfocus(); // Collapse the keyboard
      _addMessage(isUser: true, message: message);

      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      _addMessage(isUser: false, message: response.text ?? "");
    }
  }

  void _addMessage({required bool isUser, required String message}) {
    // print("_scrollToBottom() called");

    setState(() {
      _messages.add(
        Message(
          isUser: isUser,
          message: message,
          date: DateTime.now(),
        ),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        final fullScroll = maxScroll == currentScroll;
        if (!fullScroll) {
          _scrollController.animateTo(
            maxScroll,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: textColorBlack),
                      controller: _userInput,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: inputFieldColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your message here!',
                      ),
                      cursorColor: textColorBlack,
                      onFieldSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    iconSize: 32,
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blueAccent),
                      foregroundColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.9),
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    ),
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

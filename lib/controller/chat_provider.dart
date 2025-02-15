

import 'package:flutter/material.dart';

import '../model/chat.dart';

class ChatProvider with ChangeNotifier {
  // Dummy data
  final List<Chat> _chats = [
    Chat(
      id: 1,
      user: "user123",
      createdAt: DateTime.now(),
      messages: [
        Message(
          sender: "user",
          text: "Free tonight?👀",
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        Message(
          sender: "ai",
          text: "Yeah, i think so!",
          createdAt: DateTime.now().subtract(const Duration(minutes: 28)),
        ),
        Message(
          sender: "user",
          text: "Hmm.. movies?",
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
        ),
        Message(
          sender: "ai",
          text: "What you wanna do?",
          createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
        ),
        Message(
          sender: "ai",
          text: "Sounds good! I can meet after 6.",
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        Message(
          sender: "ai",
          text: "Bit busy til then...😅",
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        Message(
          sender: "user",
          text: "Sounds good! What you up to now?",
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    ),
  ];

  // Getter for current chat
  Chat get currentChat => _chats.first;

  // Send a new message
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMessage = Message(
      sender: "user",
      text: text,
      createdAt: DateTime.now(),
    );

    _chats.first.messages.add(newMessage);
    notifyListeners();

    // Simulate AI response after a delay
    Future.delayed(const Duration(seconds: 1), () {
      receiveMessage("Thanks for your message! I'll get back to you soon.");
    });
  }

  // Receive a new message (from AI)
  void receiveMessage(String text) {
    final newMessage = Message(
      sender: "ai",
      text: text,
      createdAt: DateTime.now(),
    );

    _chats.first.messages.add(newMessage);
    notifyListeners();
  }
}



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Message {
  final String content;
  Message(this.content);
}

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  void sendMessage(String content) async {
    // Send message to AO backend
    final response = await http.post(
      Uri.parse('http://ao-backend/chat'),
      body: {'message': content},
    );
    if (response.statusCode == 200) {
      _messages.add(Message(content));
      notifyListeners();
    }
  }
}

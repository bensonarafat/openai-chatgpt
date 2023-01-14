import 'package:flutter/material.dart';
import 'package:openai_chat/repository/openai_repository.dart';
import 'package:openai_chat/widgets/ai_message.dart';
import 'package:openai_chat/widgets/loading.dart';
import 'package:openai_chat/widgets/user_message.dart';

/// Chat Model
class ChatModel extends ChangeNotifier {
  /// List of messages.
  List<Widget> messages = [];

  /// Message list getter.
  List<Widget> get getMessages => messages;

  /// Sends chat request to OpenAI chat server.
  Future<void> sendChat(String txt) async {
    addUserMessage(txt);

    final response =
        await OpenAiRepository.sendMessage(prompt: txt);
    final text =
      (response['choices'] as List<dynamic>).map((t) =>
        (t as Map)['text'] as String,);
    //remove the last item
    messages..removeLast()
    ..add(AiMessage(text: text.first));

    notifyListeners();
  }

  /// Adds a new message to the list.
  void addUserMessage(String txt) {
    messages..add(UserMessage(text: txt))
    ..add(const Loading(text: '...'));
    notifyListeners();
  }
}

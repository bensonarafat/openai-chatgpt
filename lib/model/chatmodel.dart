import 'package:flutter/material.dart';
import 'package:openai_chat/repository/openai_repository.dart';
import 'package:openai_chat/widgets/ai_message.dart';
import 'package:openai_chat/widgets/loading.dart';
import 'package:openai_chat/widgets/user_message.dart';

class ChatModel extends ChangeNotifier {
  List<Widget> messages = [];

  List<Widget> get getMessages => messages;

  Future<void> sendChat(String txt) async {
    addUserMessage(txt);

    Map<String, dynamic> response =
        await OpenAiRepository.sendMessage(prompt: txt);
    String text = response['choices'][0]['text'];
    //remove the last item
    messages.removeLast();
    messages.add(AiMessage(text: text));

    notifyListeners();
  }

  void addUserMessage(txt) {
    messages.add(UserMessage(text: txt));
    messages.add(const Loading(text: "..."));
    notifyListeners();
  }
}

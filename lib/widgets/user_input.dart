// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:provider/provider.dart';

import 'package:openai_chat/api_constants.dart';
import 'package:openai_chat/model/chatmodel.dart';

/// User Input
class UserInput extends StatelessWidget {
  final Function scrollFunction;

  /// Constructor.
  const UserInput({
    Key? key,
    required this.scrollFunction,
    required this.chatcontroller,
  }) : super(key: key);

  /// Text editing controller
  final TextEditingController chatcontroller;

  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar(emailAddress);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 5,
          right: 5,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff444654),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: gravatar.imageUrl(),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                flex: 5,
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    onFieldSubmitted: (e) {
                      context.read<ChatModel>().sendChat(e);
                      chatcontroller.clear();
                    },
                    controller: chatcontroller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      filled: true,
                      fillColor: Color(0xff343541),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () {
                    context.read<ChatModel>().sendChat(chatcontroller.text);
                    chatcontroller.clear();
                    scrollFunction();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

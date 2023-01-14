import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:openai_chat/api_constants.dart';
import 'package:openai_chat/model/chatmodel.dart';
import 'package:provider/provider.dart';

/// User Input
class UserInput extends StatelessWidget {
  /// Constructor.
  const UserInput({
    super.key,
    required this.chatcontroller,
  });
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
          border: Border(
            top: BorderSide(
              color: Color(0xffd1d5db),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: gravatar.imageUrl(),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
            ),
            Expanded(
              flex: 5,
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
                  suffixIcon: Icon(
                    Icons.send,
                    color: Color(0xffacacbe),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

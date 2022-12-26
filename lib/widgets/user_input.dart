import 'package:flutter/material.dart';
import 'package:openai_chat/model/chatmodel.dart';
import 'package:provider/provider.dart';

class UserInput extends StatelessWidget {
  final TextEditingController chatcontroller;
  const UserInput({
    Key? key,
    required this.chatcontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              flex: 1,
              child: Image.asset(
                "images/avatar.png",
                height: 40,
              ),
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
                      Radius.circular(5.0),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
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

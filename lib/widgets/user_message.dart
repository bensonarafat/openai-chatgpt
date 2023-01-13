import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:openai_chat/api_constants.dart';

/// User Message
class UserMessage extends StatelessWidget {
  /// User message
  const UserMessage({
    super.key,
    required this.text,
  });

  /// User message text.
  final String text;

  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar(emailAddress);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: CachedNetworkImage(
                  imageUrl: gravatar.imageUrl(),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 8,
              ),
              child: SizedBox(
                height: 100,
                child: SelectionArea(
                  onSelectionChanged: (content) async {
                    if (content != null) {
                      await Clipboard.setData(
                          ClipboardData(text: content.plainText));
                    }
                  },
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xffd1d5db),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:openai_chat/api_constants.dart';

class UserMessage extends StatelessWidget {
  final String text;
  const UserMessage({
    Key? key,
    required this.text,
  }) : super(key: key);

  Size calculateTextSize({
    required String text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final TextDirection textDirection = Directionality.of(context);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar(emailAddress);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
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

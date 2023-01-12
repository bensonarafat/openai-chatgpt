import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum RenderingState { none, inProgress, complete }

class AiMessage extends StatefulWidget {
  final String text;
  const AiMessage({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<AiMessage> createState() => _AiMessageState();
}

class _AiMessageState extends State<AiMessage> {
  RenderingState renderingState = RenderingState.none;
  Size renderSize = Size.zero;
  GlobalKey textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff444654),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: const Color(0xff0fa37f),
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset(
                  "images/ai-avatar.svg",
                  height: 30,
                  width: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: renderingState != RenderingState.complete
                ? AnimatedTextKit(
                    key: textKey,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        widget.text,
                        textStyle: const TextStyle(
                          color: Color(0xffd1d5db),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    onFinished: () {
                      setState(() {
                        renderingState = RenderingState.complete;
                        renderSize = (textKey.currentContext != null
                            ? textKey.currentContext!.size
                            : const Size(300, 100))!;
                      });
                    },
                    totalRepeatCount: 1,
                  )
                : SizedBox(
                    width: renderSize.width,
                    height: renderSize.height,
                    child: SelectableText.rich(
                      TextSpan(
                          text: widget.text,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white)),
                      onSelectionChanged: (selection, cause) async {
                        if (cause != null &&
                            cause == SelectionChangedCause.longPress) {
                          String selected = widget.text
                              .substring(selection.start, selection.end);
                          await Clipboard.setData(
                              ClipboardData(text: selected));
                        }
                      },
                    )),
          ),
        ],
      ),
    );
  }
}

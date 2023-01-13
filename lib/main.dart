import 'package:flutter/material.dart';
import 'package:openai_chat/model/chatmodel.dart';
import 'package:openai_chat/widgets/user_input.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// Main app class
class MyApp extends StatefulWidget {
  /// Constructor
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final chatcontroller = TextEditingController();

    return MaterialApp(
      title: 'Open AI Chat',
      home: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xff343541),
          appBar: AppBar(
            backgroundColor: const Color(0xff343541),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Color(0xffd1d5db),
              ),
            ),
            elevation: 0,
            title: const Text('New Chat'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Color(0xffd1d5db),
                ),
              ),
            ],
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ChatModel()),
            ],
            child: Consumer<ChatModel>(builder: (context, model, child) {
              final messages = model.getMessages;
              return Stack(
                children: [
                  //chat

                  Container(
                    margin: const EdgeInsets.only(bottom: 80),
                    child: ListView(
                      children: [
                        const Divider(
                          color: Color(0xffd1d5db),
                        ),
                        for (int i = 0; i < messages.length; i++) messages[i]
                      ],
                    ),
                  ),
                  //input
                  UserInput(
                    chatcontroller: chatcontroller,
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

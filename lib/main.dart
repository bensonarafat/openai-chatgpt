import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:openai_chat/api_constants.dart';
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
  ScrollController _scrollController = ScrollController();
  void automaticScrollList() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    final chatcontroller = TextEditingController();
    final gravatar = Gravatar(emailAddress);

    return MaterialApp(
      title: 'Open AI Chat',
      home: SafeArea(
        top: false,
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: const Color(0xff343541),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CachedNetworkImage(
                            imageUrl: gravatar.imageUrl(),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          emailAddress,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 23, 23, 29),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'new options will be added soon...',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xff343541),
          appBar: AppBar(
            backgroundColor: const Color(0xff343541),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    if (!Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).openDrawer();
                    }
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xffd1d5db),
                  ),
                );
              },
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
            child: Consumer<ChatModel>(
              builder: (context, model, child) {
                final messages = model.getMessages;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return messages[index];
                        },
                      ),
                    ),
                    UserInput(
                      chatcontroller: chatcontroller,
                      scrollFunction: automaticScrollList,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

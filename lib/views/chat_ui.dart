import 'package:chat_animation/utils/assets.dart';
import 'package:chat_animation/utils/theme.dart';
import 'package:chat_animation/widgets/compose_message.dart';
import 'package:chat_animation/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/chat_model.dart';

class ChatUI extends StatefulWidget {
  const ChatUI({Key? key}) : super(key: key);

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  String? _selectedText;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<ChatModel> chats = [
    ChatModel(
      text: 'How\'s your day going?',
      isSender: false,
    ),
    ChatModel(
      text: 'Trust you\'re good?',
      isSender: false,
    ),
    ChatModel(
      text: 'I\'m fine',
      isSender: true,
    ),
    ChatModel(
      text: 'How are you?',
      isSender: false,
    ),
  ];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          ImageAssets.avatar,
          height: 45,
          width: 45,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(
              listKey: listKey,
              chats: chats,
              scrollController: scrollController,
              onMessageSwipe: (p0, {String? text}) {
                setState(() {
                  _selectedText = text;
                });
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedText != null) ...[
              Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      color: kMalachite.withOpacity(0.5),
                    ),
                    child: Text(
                      _selectedText!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedText = null;
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
            const Divider(
              color: kBrightGray,
              thickness: 1.3,
            ),
            const Gap(3),
            ComposeMessage(
              onMesssageSend: (text) {
                ChatModel chatModel = ChatModel(
                  text: text,
                  isSender: true,
                  repliedText: _selectedText,
                );

                setState(() {
                  listKey.currentState!.insertItem(0,
                      duration: const Duration(milliseconds: 400));
                  chats.insert(0, chatModel);
                  _selectedText = null;
                });
              },
            ),
            const Gap(11),
          ],
        ),
      ),
    );
  }
}

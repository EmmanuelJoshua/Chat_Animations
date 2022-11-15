import 'package:chat_animation/models/chat_model.dart';
import 'package:flutter/material.dart';

import 'chat_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList(
      {Key? key,
      required this.listKey,
      required this.chats,
      required this.scrollController,
      this.onMessageSwipe})
      : super(key: key);
  final Key listKey;
  final List<ChatModel> chats;
  final ScrollController scrollController;
  final Function(Key, {String text})? onMessageSwipe;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: listKey,
        initialItemCount: chats.length,
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        reverse: true,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          ChatModel chatModel = chats[index];
          return SizeTransition(
            axis: Axis.vertical,
            sizeFactor: animation,
            child: ChatBubble(
              chat: chatModel,
              onSwipe: onMessageSwipe,
            ),
          );
        });
  }
}

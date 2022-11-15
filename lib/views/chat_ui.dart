import 'package:chat_animation/utils/assets.dart';
import 'package:chat_animation/utils/theme.dart';
import 'package:chat_animation/widgets/compose_message.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/chat_bubble.dart';

class ChatUI extends StatefulWidget {
  const ChatUI({Key? key}) : super(key: key);

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  String? _selectedText;
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
      body: ListView(
        padding: const EdgeInsets.only(top: 15, bottom: 30),
        physics: const BouncingScrollPhysics(),
        children: [
          ChatBubble(
            text: 'How was the concert?',
            isSender: false,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
          ),
          ChatBubble(
            text:
                'Awesome! Next time you gotta come as well shjsjkskjs skjskjkjs!',
            isSender: true,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
          ),
          ChatBubble(
            text: 'Ok, when is the next date?',
            isSender: false,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
          ),
          ChatBubble(
            text: 'Ok, when is the next date?',
            isSender: false,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
          ),
          ChatBubble(
            text: 'Ok, when is the next date?',
            isSender: false,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
          ),
          ChatBubble(
            text: 'Ok, when is the next date?',
            isSender: false,
            onSwipe: (key, {String? text}) {
              setState(() {
                _selectedText = text;
              });
            },
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
            // const Spacer(),
            const Divider(
              color: kBrightGray,
              thickness: 1.3,
            ),
            const Gap(3),
            ComposeMessage(
              onMesssageSend: (text) {
                setState(() {
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

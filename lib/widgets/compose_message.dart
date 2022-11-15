import 'package:chat_animation/utils/theme.dart';
import 'package:flutter/material.dart';

class ComposeMessage extends StatefulWidget {
  const ComposeMessage({
    Key? key,
    required this.onMesssageSend,
  }) : super(key: key);

  final Function(String) onMesssageSend;

  @override
  State<ComposeMessage> createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  bool isUserTyping = false;
  TextEditingController textfieldController = TextEditingController();

  @override
  void dispose() {
    textfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: kBrightGray,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
            margin: const EdgeInsets.only(left: 16, right: 8),
            child: TextField(
              controller: textfieldController,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: black.withOpacity(0.8),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isUserTyping = true;
                  });
                } else {
                  setState(() {
                    isUserTyping = false;
                  });
                }
              },
              showCursor: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: kLavenderGray,
                ),
                hintText: 'Message',
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.decelerate,
          height: isUserTyping ? 45 : 0,
          width: isUserTyping ? 45 : 0,
          margin: const EdgeInsets.only(right: 12),
          decoration:
              const BoxDecoration(color: kMalachite, shape: BoxShape.circle),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            opacity: isUserTyping ? 1 : 0,
            child: InkWell(
              onTap: () {
                String text = textfieldController.text;
                if (text.isNotEmpty) {
                  widget.onMesssageSend.call(text);
                  textfieldController.clear();
                  setState(() {
                    isUserTyping = false;
                  });
                }
              },
              child: const Icon(
                Icons.send_rounded,
                color: white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

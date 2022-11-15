import 'package:chat_animation/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import '../utils/constrained_physics.dart';

class ChatBubble extends StatefulWidget {
  static const double swipeDistance = 60.0;

  const ChatBubble({
    Key? key,
    required this.text,
    required this.isSender,
    this.onSwipe,
  }) : super(key: key);
  final String text;
  final bool isSender;
  final Function(Key, {String text})? onSwipe;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  ScrollController? _scrollController;
  ScrollDirection? _swipeDirection;
  double _swipeDistance = 0.0;
  final Key _key = GlobalKey();

  @override
  void initState() {
    _resetScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double swipeRatio =
        math.min(1.0, _swipeDistance.abs() / ChatBubble.swipeDistance);
    double w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ConstrainedScrollPhysics(
            maxOverscroll: ChatBubble.swipeDistance * 1.5,
          ),
          controller: _scrollController,
          child: Transform.scale(
            scale: 1.0 - swipeRatio * 0.1,
            child: SizedBox(
              width: w + 0.1,
              child: Row(
                mainAxisAlignment: widget.isSender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        widget.isSender ? 100.0 : 16.0,
                        8,
                        widget.isSender ? 16.0 : 100.0,
                        8,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: widget.isSender
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(32),
                                  bottomRight: Radius.circular(4),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(32),
                                ),
                          color: widget.isSender
                              ? kMalachite.withOpacity(0.7)
                              : kBrightGray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                              color: widget.isSender
                                  ? Colors.white
                                  : black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _resetScrollController() {
    _scrollController?.dispose();
    _scrollController = ScrollController();
    _scrollController?.addListener(_handleSwipe);
  }

  void _handleSwipe() {
    double d = _scrollController!.position.pixels;

    if (_swipeDirection != _scrollController!.position.userScrollDirection &&
        _scrollController!.position.userScrollDirection !=
            ScrollDirection.reverse) {
      _swipeDirection = _scrollController!.position.userScrollDirection;

      widget.onSwipe?.call(
        _key,
        text: widget.text,
      );
    }

    if (_scrollController!.position.atEdge) {
      _swipeDirection = null;
    }

    setState(() {
      _swipeDistance = d;
    });
  }
}

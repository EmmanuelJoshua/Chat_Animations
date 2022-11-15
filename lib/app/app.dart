import 'package:flutter/material.dart';

import '../utils/theme.dart';
import '../views/chat_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const ChatUI(),
    );
  }
}

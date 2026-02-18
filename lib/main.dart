import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const RoadAssistApp());
}

class RoadAssistApp extends StatelessWidget {
  const RoadAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Road Assistance',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: const Color(0xfff4f4f4),
      ),
      home: const HomePage(),
    );
  }
}




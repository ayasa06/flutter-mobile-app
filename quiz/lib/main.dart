import 'package:flutter/material.dart';
import 'view/home_screen.dart';
import 'view/quiz_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mushroom Quiz',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
      routes: {
        '/quiz': (context) => QuizScreen(),
        //'/explanation': (context) => ExplanationScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'view/start_screen.dart';
import 'view/home_screen.dart';
import 'view/quiz_screen.dart';
import 'view/explanation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mushroom Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => HomeScreen(),
        '/quiz': (context) => QuizScreen(),
        '/explanation': (context) => ExplanationScreen(),
      },
    );
  }
}

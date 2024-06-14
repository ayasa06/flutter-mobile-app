import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionNumber = 1;
  String mushroomName = 'Mushroom 1'; // Replace with actual data
  String mushroomImage = 'assets/kinoko_tukiyotake.png'; // Replace with actual data

  void _answer(bool isEdible) {
    Navigator.pushNamed(
      context, 
      '/explanation',
      arguments: {
        'isEdible': isEdible,
        'mushroomName': mushroomName,
        'mushroomImage': mushroomImage,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question $questionNumber'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mushroomName, style: TextStyle(fontSize: 24)),
            Image.asset(mushroomImage),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _answer(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4F50),
                  ),
                  child: Text('有毒'),
                ),
                ElevatedButton(
                  onPressed: () => _answer(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1),
                  ),
                  child: Text('食用'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

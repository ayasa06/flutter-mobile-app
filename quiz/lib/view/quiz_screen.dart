import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionNumber = 1;
  String mushroomName = 'アカハツ'; // Replace with actual data
  String mushroomImage =
      'assets/mushrooms/tukiyotake.png'; // Replace with actual data

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
        title: Text('Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 40.0, left: 20.0, right: 20.0), // Added top padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the top
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$questionNumber/10',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                mushroomName,
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 10.0), // Reduced space between text and image
            Image.asset(
              mushroomImage,
              height: 200.0,
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _answer(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4F50),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // More rectangular shape
                    ),
                  ),
                  child: Text('有毒'),
                ),
                ElevatedButton(
                  onPressed: () => _answer(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // More rectangular shape
                    ),
                  ),
                  child: Text('食用'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.0,
        color: Colors.orange,
      ),
    );
  }
}

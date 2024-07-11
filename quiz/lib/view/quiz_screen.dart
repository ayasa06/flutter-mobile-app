import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionNumber = 1;
  late List<Map<String, dynamic>> _quizData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
  }

  Future<void> _fetchQuizData() async {
    var db = DatabaseHelper.instance;
    _quizData = await db.queryRowsByDifficulty('easy');
    print('Fetched quiz data count: ${_quizData.length}');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mushroom Quiz'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_quizData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mushroom Quiz'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Text('クイズデータが存在しません。'),
        ),
      );
    }

    Map<String, dynamic> currentQuestion = _quizData[questionNumber - 1];
    String questionText = currentQuestion[DatabaseHelper.columnQuestion];
    String correctAnswer = currentQuestion[DatabaseHelper.columnAnswer];
    String mushroomName = currentQuestion[DatabaseHelper.columnMushroomName];
    String mushroomImage = currentQuestion[DatabaseHelper.columnMushroomImage];
    List<String> options = currentQuestion[DatabaseHelper.columnOptions].split(',');

    return Scaffold(
      appBar: AppBar(
        title: Text('Mushroom Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$questionNumber/5',
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
            SizedBox(height: 10.0),
            Image.asset(
              mushroomImage,
              height: 200.0,
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options.map((option) {
                return ElevatedButton(
                  onPressed: () {
                    _answer(option == correctAnswer, mushroomName, mushroomImage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: option == 'はい' ? Color(0xFFFF4F50) : Color(0xFF4169E1),
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(option),
                );
              }).toList(),
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

  void _answer(bool isCorrect, String mushroomName, String mushroomImage) async {
    bool? shouldContinue = await Navigator.pushNamed(
      context,
      '/explanation',
      arguments: {
        'isEdible': isCorrect,
        'mushroomName': mushroomName,
        'mushroomImage': mushroomImage,
      },
    ) as bool?;

    if (shouldContinue == true && questionNumber < 5) {
      setState(() {
        questionNumber++;
      });
    } else if (shouldContinue == true) {
      Navigator.pop(context);
    }
  }
}

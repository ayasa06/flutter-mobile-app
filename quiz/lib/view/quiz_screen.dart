import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'result_screen.dart'; // ResultScreenのインポートを追加

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionNumber = 1;
  int correctAnswers = 0;
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
    _quizData = _quizData.map((q) => {...q, 'is_correct': false}).toList(); // 正解情報を追加
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
    String correctAnswer = currentQuestion[DatabaseHelper.columnAnswer];
    String mushroomName = currentQuestion[DatabaseHelper.columnMushroomName];
    String mushroomImage = currentQuestion[DatabaseHelper.columnMushroomImage];
    List<String> options = currentQuestion[DatabaseHelper.columnOptions].split(',');

    return Scaffold(
      appBar: AppBar(
        title: Text('Mushroom Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
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
            SizedBox(height: 10.0),
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
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _answer(option == correctAnswer, mushroomName, mushroomImage);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: option == '有毒' ? Color(0xFFFF4F50) : Color(0xFF4169E1),
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(option, style: TextStyle(color: Colors.black)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _showQuitDialog();
                },
                child: Text('中断', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _answer(bool isCorrect, String mushroomName, String mushroomImage) async {
    if (isCorrect) {
      correctAnswers++;
      _quizData[questionNumber - 1]['is_correct'] = true; // 正解情報を更新
    }

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(correctAnswers: correctAnswers, quizData: _quizData),
        ),
      );
    }
  }

  void _showQuitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('クイズを中断しますか？', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  child: Text('はい', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

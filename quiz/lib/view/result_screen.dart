import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final List<Map<String, dynamic>> quizData;

  ResultScreen({required this.correctAnswers, required this.quizData});

  String getResultMessage(int correctAnswers) {
    if (correctAnswers <= 2) {
      return 'もう少し頑張ろう！';
    } else if (correctAnswers <= 4) {
      return '頑張ったね！';
    } else {
      return '素晴らしい！';
    }
  }

  @override
  Widget build(BuildContext context) {
    String resultMessage = getResultMessage(correctAnswers);

    return Scaffold(
      appBar: AppBar(
        title: Text('結果'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '正解数',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            Text(
              '$correctAnswers 問 / 5問中',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/kinoko_logo.png', height: 50), // 結果アイコン
                SizedBox(width: 10),
                Text(
                  resultMessage,
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold), // フォントサイズを小さめに
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: quizData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> question = quizData[index];
                  String mushroomName = question['mushroom_name'];
                  String mushroomImage = question['mushroom_image'];
                  bool isCorrect = question['is_correct'];
                  String answerImage = isCorrect ? 'assets/ok.png' : 'assets/no.png';
                  String toxicIcon = question['answer'] == '有毒' ? 'assets/skull.png' : '';
                                
  
                  return ListTile(
                    leading: Image.asset(mushroomImage, width: 50, height: 50),
                    title: Row(
                      children: [
                        Text('${index + 1}. $mushroomName'),
                        if (toxicIcon.isNotEmpty) Image.asset(toxicIcon, width: 20, height: 20),
                      ],
                    ),
                    trailing: Image.asset(answerImage, width: 20, height: 20),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              child: Text('トップへ', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD9D9D9),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20), // 余白を追加
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

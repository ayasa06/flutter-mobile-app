import 'package:flutter/material.dart';

class ExplanationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    bool isEdible = arguments['isEdible'];
    String mushroomName = arguments['mushroomName'];
    String mushroomImage = arguments['mushroomImage'];
    bool correctAnswer = false; // ツキヨタケは有毒なので、正解は false

    return Scaffold(
      appBar: AppBar(
        title: Text('Explanation'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(isEdible == correctAnswer ? 'assets/ok.png' : 'assets/no.png', height: 100.0),
                SizedBox(height: 10.0),
                Text(
                  isEdible == correctAnswer ? '正解: 有毒' : '不正解: 有毒',
                  style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 161, 142, 142)),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD9D9D9),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('次へ進む'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'ツキヨタケは有毒なキノコの一つ。見た目がマツタケに似ているが、マツタケと違って赤い傘を持ち、白い斑点がある。',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Image.asset(mushroomImage, height: 150.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.0,
        color: Colors.orange,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ExplanationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    bool isEdible = arguments['isEdible'];
    String mushroomName = arguments['mushroomName'];
    String mushroomImage = arguments['mushroomImage'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Explanation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isEdible
                ? Image.asset(
                    'assets/kinoko_tukiyotake.png') // Replace with correct image
                : Image.asset(
                    'assets/kinoko_tukiyotake.png'), // Replace with correct image
            Text(
              isEdible ? '正解' : '不正解',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isEdible
                    ? 'このキノコは食用です。美味しく料理できます。'
                    : 'このキノコは非常に毒性が高く、食べると危険です。',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Go to next question or end quiz
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4169E1),
              ),
              child: Text('次に進む'),
            ),
            Image.asset(mushroomImage), // Display selected mushroom image
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 200.0), // ロゴ画像
            SizedBox(height: 20.0),
        
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0), // Increased vertical padding
                textStyle: TextStyle(fontSize: 16, color: Colors.white), // Decreased font size and changed text color to white
              ),
              child: Text('クイズを始める', style: TextStyle(color: Colors.white)),
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

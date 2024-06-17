import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mushroom Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0), // Adjusted top padding
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align to the top
              children: [
                _buildDifficultyButton(
                  context,
                  '初級者',
                  1,
                  '/quiz',
                  'easy',
                ),
                _buildDifficultyButton(
                  context,
                  '中級者',
                  3,
                  '/quiz',
                  'medium',
                ),
                _buildDifficultyButton(
                  context,
                  '上級者',
                  5,
                  '/quiz',
                  'hard',
                ),
                SizedBox(height: 30.0),
                _buildBookButton(
                  context,
                  'きのこ図鑑',
                  'assets/book.png',
                  '/book', // Replace with actual route
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String title, int starCount, String route, String difficulty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route, arguments: difficulty);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0), // Increased vertical padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: List.generate(starCount, (index) => Image.asset('assets/star.png', height: 20.0)),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookButton(BuildContext context, String title, String imagePath, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0), // Increased vertical padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 30.0),
                SizedBox(width: 20.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 5.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

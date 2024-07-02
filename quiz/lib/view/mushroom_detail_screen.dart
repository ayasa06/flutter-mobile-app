import 'package:flutter/material.dart';

class MushroomDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String mushroomName = arguments['name'];
    String mushroomImage = arguments['image'];

    return Scaffold(
      appBar: AppBar(
        title: Text(mushroomName),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(mushroomImage, height: 200.0),
            SizedBox(height: 20.0),
            Text(
              mushroomName,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20.0),
            Text(
              'ここにきのこの説明が入ります。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
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

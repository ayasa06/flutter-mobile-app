import 'package:flutter/material.dart';
import 'view/start_screen.dart';
import 'view/home_screen.dart';
import 'view/quiz_screen.dart';
import 'view/explanation_screen.dart';
import 'view/mushroom_catalog_screen.dart';
import 'view/mushroom_detail_screen.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = DatabaseHelper.instance;

  // 初期データを挿入
  var quizData = await db.queryAllRows();
  print('Initial data count: ${quizData.length}');

  if (quizData.isEmpty) {
    List<Map<String, dynamic>> initialData = [
      {
        DatabaseHelper.columnQuestion: 'このキノコは有毒ですか？',
        DatabaseHelper.columnAnswer: 'はい',
        DatabaseHelper.columnOptions: 'はい,いいえ',
        DatabaseHelper.columnDifficulty: 'easy',
        DatabaseHelper.columnMushroomName: 'ツキヨタケ',
        DatabaseHelper.columnMushroomImage: 'assets/mushrooms/tukiyotake.png',
        DatabaseHelper.columnMushroomDescription: 'ツキヨタケは有毒なキノコの一つ。見た目がマツタケに似ているが、マツタケと違って赤い傘を持ち、白い斑点がある。'
      },
      {
        DatabaseHelper.columnQuestion: 'このキノコは食用ですか？',
        DatabaseHelper.columnAnswer: 'いいえ',
        DatabaseHelper.columnOptions: 'はい,いいえ',
        DatabaseHelper.columnDifficulty: 'easy',
        DatabaseHelper.columnMushroomName: 'アミガサタケ',
        DatabaseHelper.columnMushroomImage: 'assets/mushrooms/amigasatake.jpg',
        DatabaseHelper.columnMushroomDescription: 'アミガサタケは食用のキノコで、フランス料理などで人気がある。しかし、食べる前に十分な加熱が必要。'
      },
      {
        DatabaseHelper.columnQuestion: 'このキノコは毒キノコですか？',
        DatabaseHelper.columnAnswer: 'はい',
        DatabaseHelper.columnOptions: 'はい,いいえ',
        DatabaseHelper.columnDifficulty: 'easy',
        DatabaseHelper.columnMushroomName: 'ドクツルタケ',
        DatabaseHelper.columnMushroomImage: 'assets/mushrooms/dokuturutake.jpg',
        DatabaseHelper.columnMushroomDescription: 'ドクツルタケは非常に毒性の強いキノコで、食べると命にかかわることがあります。'
      },
      {
        DatabaseHelper.columnQuestion: 'このキノコは食べられますか？',
        DatabaseHelper.columnAnswer: 'はい',
        DatabaseHelper.columnOptions: 'はい,いいえ',
        DatabaseHelper.columnDifficulty: 'easy',
        DatabaseHelper.columnMushroomName: 'マツタケ',
        DatabaseHelper.columnMushroomImage: 'assets/mushrooms/matutake.jpg',
        DatabaseHelper.columnMushroomDescription: 'マツタケは日本料理で高級食材とされており、秋の味覚として知られています。'
      },
      {
        DatabaseHelper.columnQuestion: 'このキノコは食べられますか？',
        DatabaseHelper.columnAnswer: 'いいえ',
        DatabaseHelper.columnOptions: 'はい,いいえ',
        DatabaseHelper.columnDifficulty: 'easy',
        DatabaseHelper.columnMushroomName: 'カエンタケ',
        DatabaseHelper.columnMushroomImage: 'assets/mushrooms/kaentake.jpg',
        DatabaseHelper.columnMushroomDescription: 'カエンタケは非常に毒性の強いキノコで、食べると重篤な症状を引き起こします。'
      },
    ];
    for (var data in initialData) {
      await db.insert(data);
    }

    // データを挿入した後に再度クエリを実行して確認
    quizData = await db.queryAllRows();
    print('Data after insertion: ${quizData.length}');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mushroom Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => HomeScreen(),
        '/quiz': (context) => QuizScreen(),
        '/explanation': (context) => ExplanationScreen(),
        '/mushroom_catalog': (context) => MushroomCatalogScreen(),
        '/mushroom_detail': (context) => MushroomDetailScreen(),
      },
    );
  }
}

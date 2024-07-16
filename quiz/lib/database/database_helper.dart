import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final _databaseName = "QuizDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'quiz';

  static final columnId = '_id';
  static final columnQuestion = 'question';
  static final columnAnswer = 'answer';
  static final columnOptions = 'options';
  static final columnDifficulty = 'difficulty';
  static final columnMushroomName = 'mushroom_name';
  static final columnMushroomImage = 'mushroom_image';
  static final columnMushroomDescription = 'mushroom_description';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<int> insert(Map<String, dynamic> row) async {
    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> quizList = prefs.getStringList('quizData') ?? [];
      quizList.add(json.encode(row));
      await prefs.setStringList('quizData', quizList);
      return 1;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> quizList = prefs.getStringList('quizData') ?? [];
      return quizList.map((item) => Map<String, dynamic>.from(json.decode(item))).toList();
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future<List<Map<String, dynamic>>> queryRowsByDifficulty(String difficulty) async {
    if (kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> quizList = prefs.getStringList('quizData') ?? [];
      List<Map<String, dynamic>> allRows = quizList.map((item) => Map<String, dynamic>.from(json.decode(item))).toList();
      return allRows.where((row) => row[columnDifficulty] == difficulty).toList();
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';

class TxtParser {
  static Future<List<String>> loadFile(String pathTxtFile) async {
    List<String> wordList = [];
    String data = await rootBundle.loadString(pathTxtFile);
    LineSplitter.split(data).forEach((element) {
      wordList.add(element);
    });
    return wordList;
  }
}

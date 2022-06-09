import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordgame_app/screens/game_screen.dart';
import 'package:wordgame_app/txt_parser.dart';
import 'package:wordgame_app/widgets/letter_collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> letterFuture;
  late List<String> letters;
  void returnLetter() async {
    letters = await letterFuture;
  }

  @override
  void initState() {
    letterFuture = findRandomSevenLetters();
    returnLetter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: letterFuture,
                builder: (context, snapshot) {
                  if (!(snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done)) {
                    return const CircularProgressIndicator();
                  }
                  return LetterCollection(
                    letters: snapshot.data as List<String>,
                  );
                },
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.2,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        letterFuture = findRandomSevenLetters();
                      });
                      letters = await letterFuture;
                    },
                    child: const Text('Reset and load new board'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return GameScreen(letters: letters);
                        },
                      ));
                    },
                    child: const Text('PLAY'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> findRandomSevenLetters() async {
    List<String> alphabet = [
      'A',
      'B',
      'C',
      'Ç',
      'D',
      'E',
      'F',
      'G',
      'Ğ',
      'H',
      'İ',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'Ö',
      'P',
      'R',
      'S',
      'Ş',
      'T',
      'U',
      'Ü',
      'V',
      'Y',
      'Z',
    ];
    List<String> sevenLetters = await _getData();
    var randomWord = sevenLetters[Random().nextInt(sevenLetters.length)];
    List<String> letters = randomWord.split("")..shuffle();
    letters = letters.map((e) {
      return e.toUpperCase();
    }).toList();
    Set<String> setOfLetters = letters.toSet();
    if (setOfLetters.length < 7) {
      int num = 7 - setOfLetters.length;
      for (var i = 0; i < num; i++) {
        var let = alphabet[Random().nextInt(alphabet.length)];
        while (setOfLetters.contains(let) == true) {
          let = alphabet[Random().nextInt(alphabet.length)];
        }
        setOfLetters.add(let);
      }
    }
    print(setOfLetters);
    return setOfLetters.toList();
  }

  List<String> findLetters() {
    List<String> letters = [];
    findRandomSevenLetters().then((value) {
      letters = value.toList();
    });
    return letters;
  }

  Future<List<String>> _getData() async {
    const String path = 'assets/sozluk_v2.txt';
    List<String> wordList = await TxtParser.loadFile(path);
    List<String> seven = [];

    for (var element in wordList) {
      if (element.length == 7) {
        seven.add(element);
      }
    }
    return seven;
  }
}

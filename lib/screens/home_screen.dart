import 'dart:math';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:wordgame_app/txt_parser.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double sz = mediaQuery.size.height * 0.12;
    final double dist = sz * 0.5;
    return FutureBuilder(
        future: findRandomSevenLetters(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                  body: Column(
                children: [
                  Container(
                    height: sz * 6,
                    width: double.infinity,
                    color: Colors.green,
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: [
                        Positioned(
                            top: 0.5 * dist, child: _button(snapshot.data[1])),
                        Positioned(
                            top: 1.5 * dist,
                            child: _buttonRow(
                                snapshot.data[2] + snapshot.data[3])),
                        Positioned(
                            top: 2.5 * dist,
                            child: _button(snapshot.data[0], center: true)),
                        Positioned(
                            top: 3.5 * dist,
                            child: _buttonRow(
                                snapshot.data[4] + snapshot.data[5])),
                        Positioned(
                            top: 4.5 * dist, child: _button(snapshot.data[6])),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Reset and load new board'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('PLAY'),
                  ),
                ],
              )),
            );
          }
          return const Scaffold(body: CircularProgressIndicator());
        });
  }

  Widget _button(String letter, {bool center = false}) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: SizedBox(
        height: 80,
        child: ClipPolygon(
          sides: 6,
          borderRadius: 1,
          rotate: 90.0,
          child: Container(
            alignment: Alignment.center,
            color: !center ? Colors.blueGrey : Colors.amber,
            width: 100,
            height: 100,
            child: Text(
              letter,
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonRow(String chars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: chars.split("").map((e) => _button(e)).toList(),
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
      'ğ',
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

import 'package:flutter/material.dart';
import 'package:wordgame_app/widgets/letter_collection.dart';

class GameScreen extends StatefulWidget {
  List<String> letters;
  GameScreen({required this.letters, Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Game Screen')),
        body: Column(
          children: [
            Expanded(
                child: LetterCollection(
              letters: widget.letters,
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class LetterCollection extends StatelessWidget {
  const LetterCollection({required this.letters, Key? key}) : super(key: key);
  final List<String> letters;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double sz = mediaQuery.size.height * 0.12;
    final double dist = sz * 0.5;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          createCollection(sz, dist),
        ],
      )),
    );
  }

  Widget createCollection(double sz, double dist) {
    return Container(
      height: sz * 5,
      width: double.infinity,
      color: Colors.blueGrey,
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [
          Positioned(top: 0.5 * dist, child: _button(letters[1])),
          Positioned(
              top: 1.5 * dist, child: _buttonRow(letters[2] + letters[3])),
          Positioned(top: 2.5 * dist, child: _button(letters[0], center: true)),
          Positioned(
              top: 3.5 * dist, child: _buttonRow(letters[4] + letters[5])),
          Positioned(top: 4.5 * dist, child: _button(letters[6])),
        ],
      ),
    );
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
            color: !center ? Colors.yellow.shade600 : Colors.black,
            width: 100,
            height: 100,
            child: Text(
              letter,
              style: TextStyle(
                  color: !center ? Colors.black : Colors.yellow, fontSize: 40),
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
}

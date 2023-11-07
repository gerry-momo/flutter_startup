import 'dart:math';
import 'package:flutter/material.dart';


Color getColor(int index) {
  int num = index % 10;
  switch (num) {
    case 0:
      return Colors.orange[200]!;
    case 1:
      return Colors.green[300]!;
    case 2:
      return Colors.red[300]!;
    case 3:
      return Colors.greenAccent;
    case 4:
      return Colors.pinkAccent[100]!;
    case 5:
      return Colors.amberAccent[100]!;
    case 6:
      return Colors.blue[300]!;
    case 7:
      return Colors.lightGreenAccent[100]!;
    case 8:
      return Colors.deepPurpleAccent[100]!;
    case 9:
      return Colors.deepOrange[300]!;
  }
  return Colors.black87;
}

List<Color> colorsBox = [
  Colors.red[300]!,
  Colors.green[300]!,
  Colors.blue[300]!,
  Colors.orange[300]!,
  Colors.lightGreen[400]!,
  Colors.blueAccent[100]!,
  const Color(0xffd2901b),
  const Color(0xeeff7f50),
  const Color(0xff2ed573),
  const Color(0xee1e90ff),
  const Color(0xff262d50),
  const Color(0xffbadc58),
  const Color(0xffff6b81),
  const Color(0xff1b6265),
  Colors.deepPurple[300]!,
  Colors.orange[200]!,
  Colors.green[300]!,
  Colors.red[300]!,
  Colors.greenAccent,
  Colors.pinkAccent[100]!,
  const Color(0xfffed330),
  Colors.blue[300]!,
  Colors.lightGreenAccent[100]!,
  Colors.deepPurpleAccent[100]!,
  Colors.deepOrange[300]!,
];
List<Color> colorsBox2 = [
  Colors.orange[200]!,
  Colors.green[300]!,
  Colors.red[300]!,
  Colors.greenAccent,
  Colors.pinkAccent[100]!,
  Colors.amberAccent[100]!,
  Colors.blue[300]!,
  Colors.lightGreenAccent[100]!,
  Colors.deepPurpleAccent[100]!,
  Colors.deepOrange[300]!,
];

List colorStyle = [
  [Colors.white, Colors.black],
  [Colors.black, Colors.white],
  [Colors.white, Colors.black26],
  [const Color(0x55eb4d4b), const Color(0xffe74c3c)],
  [const Color(0xeeeb4d4b), Colors.deepOrange[300]!],
  [Colors.amberAccent[100]!, Colors.orange[200]!],
  [const Color(0xff6ab04c), const Color(0xffbadc58)],
  [const Color(0x66130f40), const Color(0xff30336b)],
  [const Color(0x552980b9), const Color(0xff3498db)],
];

Color getRandomColor({String? seed}) {
  var rng = Random();
  int rdm = rng.nextInt(colorsBox.length);
  return colorsBox[rdm];
}

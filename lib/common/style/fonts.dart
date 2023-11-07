import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fonts {
  static const TextStyle bigTip =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle textTip = TextStyle(fontSize: 16);

  static const TextStyle field = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      letterSpacing: 4 );

  static const TextStyle newField = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      letterSpacing: 4 );
}

class MyBorder {
  Decoration normal = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(5, 88, 200, 0.8),
          offset: Offset(0, 5),
          blurRadius: 12)
    ],
  );
  Decoration delete = const BoxDecoration(
    color: Colors.redAccent,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(5, 88, 200, 0.8),
          offset: Offset(0, 5),
          blurRadius: 12)
    ],
  );
}

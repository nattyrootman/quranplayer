import 'package:flutter/material.dart';

class MyColor {
  static const linear1 = LinearGradient(colors: [
    Color.fromARGB(255, 247, 61, 210),
    Color.fromARGB(255, 188, 5, 204),
    Color.fromARGB(255, 182, 3, 155)
  ]);

  static const linear2 = LinearGradient(
      colors: [Colors.blueAccent, Colors.blue, Colors.blueAccent]);

  static const LinearGradient gradient1 = LinearGradient(
    colors: [Color(0xFFff9a9e), Color(0xFFfad0c4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradient2 = LinearGradient(
    colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradient3 = LinearGradient(
    colors: [Color(0xFFffecd2), Color(0xFFfcb69f)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient gradient4 = LinearGradient(
    colors: [Color(0xFFff9966), Color(0xFFff5e62)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradient5 = LinearGradient(
    colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

//
  static const linear4 =LinearGradient(
    colors: [Color.fromARGB(255, 243, 38, 192), Color.fromARGB(255, 128, 8, 102),Color.fromARGB(255, 113, 4, 153),Color.fromARGB(255, 119, 5, 186)],
  );

  // #009FFF
}

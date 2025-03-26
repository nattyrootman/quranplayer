import 'package:flutter/material.dart';

import 'mytext_theme.dart';

class MythemeData {
  static ThemeData ligthThem = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: MytextTheme.lightTextThem);

  static ThemeData darkThemData = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
      textTheme: MytextTheme.darkTextTheme);

}
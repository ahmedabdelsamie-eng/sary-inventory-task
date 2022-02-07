import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(color: Colors.black87, fontSize: 18),
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 18, color: Colors.white),
      headline3: TextStyle(color: Colors.black87, fontSize: 16)),
);

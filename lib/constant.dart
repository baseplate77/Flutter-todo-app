import 'package:flutter/material.dart';

import 'provider/tasks.dart' show TaskType;

//List<String> taskType = ['Personal', 'Work', 'Home'];
List<Color> currentColor = [Color(0xFFE8816D), Color(0xFFF05D70)];

//final List<String> cardScreen = ['personalcard', 'workcard', 'homecard'];

const TextStyle kTaskTextStyle = TextStyle(
  fontFamily: "Baloo Tammudu 2",
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
const TextStyle kCardTaskStyle = TextStyle(
    decoration: TextDecoration.none,
    fontFamily: 'Baloo Tammudu 2',
    fontSize: 18.0,
    color: Colors.white70,
    fontWeight: FontWeight.bold);

const TextStyle kCardCategaryStyle = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 25.0,
  height: 1,
  fontFamily: 'Baloo Tammudu 2',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

final List<String> heroTag = [
  'personalcard',
  'workcard',
  'homecard',
];

final appColor = [
  [Color(0xFF28CFFB), Color(0xFF8374F7)],
  [Color(0xFFFFAD7F), Color(0xFFFFD97A)],
  [Color(0xFFf54291), Color(0xFF8374F7)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
  [Color(0xFF28CFFB), Color(0xFFffcb74)],
  [Color(0xFFFFAD7F), Color(0xFFefee9d)],
  [Color(0xFFfaeee7), Color(0xFF4DE9A4)],

  [Color(0xFFFFAD7F), Color(0xFFFFD97A)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
  [Color(0xFF28CFFB), Color(0xFF8374F7)],
  [Color(0xFFd92027), Color(0xFFFFD97A)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
  [Color(0xFF28CFFB), Color(0xFF8374F7)],
  [Color(0xFFFFAD7F), Color(0xFFFFD97A)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
  [Color(0xFF28CFFB), Color(0xFF8374F7)],
  [Color(0xFFFFAD7F), Color(0xFFFFD97A)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
  [Color(0xFF28CFFB), Color(0xFF8374F7)],
  [Color(0xFFFFAD7F), Color(0xFFFFD97A)],
  [Color(0xFF11AEE1), Color(0xFF4DE9A4)],
];

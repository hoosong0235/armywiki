// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

const Color ROKA = Color(
  0xFF2A5034,
);
const Color ROKA64 = Color(
  0xA02A5034,
);
const LinearGradient ROKAGradient = LinearGradient(
  colors: [
    ROKA,
    ROKA64,
  ],
);

const Color GeminiFirst = Color(
  0xFF4991E7,
);
const Color GeminiSecond = Color(
  0xFF7F7BD1,
);
const Color GeminiThird = Color(
  0xFFD26565,
);
const LinearGradient GeminiGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    GeminiFirst,
    GeminiSecond,
    GeminiThird,
  ],
);
const LinearGradient GeminiGradientDiagonal = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    GeminiFirst,
    GeminiSecond,
    GeminiThird,
  ],
);
const List<Color> Geminis = [
  GeminiFirst,
  GeminiSecond,
  GeminiThird,
];
Color get geminiRandom => Geminis[Random().nextInt(Geminis.length)];

const Color Star = Color(
  0xFFFF9600,
);

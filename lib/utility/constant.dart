import 'package:flutter/material.dart';

const EdgeInsets chipEdgeInsets = EdgeInsets.fromLTRB(
  8,
  6,
  16,
  6,
);
const EdgeInsets cardEdgeInsets = EdgeInsets.all(
  12,
);
const EdgeInsets chatEdgeInsets = EdgeInsets.all(
  12,
);

BorderRadius cardBorderRadius = BorderRadius.circular(
  12,
);

const bool isHttps = true;

const String baseHttpUrl = "http://3.34.209.210:8000";
const String baseHttpsUrl = "https://d35c-3-34-209-210.ngrok-free.app";
String get baseUrl => isHttps ? baseHttpsUrl : baseHttpUrl;

import 'package:flutter/material.dart';

enum Sender {
  user(
    MainAxisAlignment.end,
    BorderRadius.only(
      topLeft: Radius.circular(
        12,
      ),
      topRight: Radius.circular(
        0,
      ),
      bottomRight: Radius.circular(
        12,
      ),
      bottomLeft: Radius.circular(
        12,
      ),
    ),
  ),
  ai(
    MainAxisAlignment.start,
    BorderRadius.only(
      topLeft: Radius.circular(
        0,
      ),
      topRight: Radius.circular(
        12,
      ),
      bottomRight: Radius.circular(
        12,
      ),
      bottomLeft: Radius.circular(
        12,
      ),
    ),
  );

  const Sender(
    this.mainAxisAlignment,
    this.borderRadius,
  );

  final MainAxisAlignment mainAxisAlignment;
  final BorderRadius borderRadius;
}

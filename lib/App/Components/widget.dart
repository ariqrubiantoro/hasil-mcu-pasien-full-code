import 'package:flutter/material.dart';

textDefault(String message, double size, Color color, FontWeight fw) {
  return Text(
    message,
    style: TextStyle(
        fontFamily: 'poppins', fontSize: size, color: color, fontWeight: fw),
  );
}

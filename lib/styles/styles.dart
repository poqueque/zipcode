import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle title =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle subtitle = TextStyle(
      fontSize: 12, color: AppColors.grey, fontWeight: FontWeight.bold);

  static const TextStyle bigText = TextStyle(
      fontSize: 32);
  static const TextStyle bigTextBold = TextStyle(
      fontSize: 32, fontWeight: FontWeight.bold);

  static const TextStyle label = TextStyle(
      fontSize: 13, color: AppColors.orange);
}

class AppColors {
  static const Color grey = Colors.black54;
  static const Color blue = Colors.blue;
  static const Color orange = Colors.deepOrange;
}

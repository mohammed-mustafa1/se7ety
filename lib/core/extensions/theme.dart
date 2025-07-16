import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;
}

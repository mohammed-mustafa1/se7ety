import 'package:flutter/material.dart';

enum SnackBarType { success, error }

showMainSnackBar(
  BuildContext context, {
  required String text,
  required SnackBarType type,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            type == SnackBarType.success ? Colors.green : Colors.red,
        content: Text(text),
      ),
    );

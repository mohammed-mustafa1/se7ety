import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class ErrorTextUi extends StatelessWidget {
  const ErrorTextUi({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: TextStyles.getTitle()));
  }
}

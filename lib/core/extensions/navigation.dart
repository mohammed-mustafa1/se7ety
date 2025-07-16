import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigatorExtension on BuildContext {
  Future<void> pushTo(String routeName, {Object? extra}) async {
    await push(routeName, extra: extra);
  }

  void pushToBase(String routName) {
    go(routName);
  }

  void pushToReplace(String routName, {Object? extra}) {
    pushReplacement(routName, extra: extra);
  }
}

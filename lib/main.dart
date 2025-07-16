import 'package:flutter/material.dart';
import 'package:se7ety/core/routers/app_routers.dart';

void main() {
  runApp(Se7ety());
}

class Se7ety extends StatelessWidget {
  const Se7ety({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routers,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/utils/theme.dart';
import 'package:se7ety/firebase_options.dart';
import 'package:se7ety/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPrefs.init();
  FireBaseService.init();
  runApp(Se7ety());
}

class Se7ety extends StatelessWidget {
  const Se7ety({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale('ar'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.routers,
      debugShowCheckedModeBanner: false,
    );
  }
}

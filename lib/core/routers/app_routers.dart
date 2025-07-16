import 'package:go_router/go_router.dart';
import 'package:se7ety/features/intro/page/splash_screen.dart';

class AppRouter {
  static const String splash = '/';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
    ],
  );
}

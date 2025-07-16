import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splash = '/';

  static final routers = GoRouter(
    routes: [
      // GoRoute(path: splash, builder: (context, state) => SplashScreen()),
    ],
  );
}

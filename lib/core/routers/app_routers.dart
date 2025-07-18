import 'package:go_router/go_router.dart';
import 'package:se7ety/features/intro/onboarding/presentation/page/on_boarding_screen.dart';
import 'package:se7ety/features/intro/splash/page/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnBoardingScreen(),
      ),
    ],
  );
}

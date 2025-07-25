import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/page/doctor_register_screen.dart';
import 'package:se7ety/features/auth/presentation/page/login_screen.dart';
import 'package:se7ety/features/auth/presentation/page/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/presentation/page/on_boarding_screen.dart';
import 'package:se7ety/features/intro/splash/page/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onBoarding = '/onBoarding';
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String doctorRegister = '/doctorRegister';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: register,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: RegisterScreen(userType: state.extra as UserType),
            ),
      ),
      GoRoute(
        path: login,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: LoginScreen(userType: state.extra as UserType),
            ),
      ),
      GoRoute(
        path: doctorRegister,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: BlocProvider(
                create: (context) => AuthCubit(),
                child: DoctorRegisterScreen(),
              ),
            ),
      ),
    ],
  );
}
